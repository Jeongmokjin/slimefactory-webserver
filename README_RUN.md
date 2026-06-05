# 슬라임 팩토리 — 실행 안내

팀 나무목(정목진·김나윤) · Tomcat 10.1(Jakarta EE 10) · Java 21 · MySQL · 순수 Servlet/JSP/JDBC

---

## 1. 데이터베이스 준비

`slimedb` 데이터베이스는 이미 생성되어 있다고 가정한다. 스키마와 초기 데이터를 넣는다.

```bash
# 스키마 생성
mysql -uroot -p slimedb < db/schema.sql
# 초기 데이터(관리자/샘플상품) 입력
mysql -uroot -p slimedb < db/seed.sql
```

> DB가 아직 없다면 먼저: `CREATE DATABASE slimedb DEFAULT CHARSET utf8mb4;`

### 기본 계정 (seed.sql)
| 아이디 | 비밀번호 | 권한 |
|---|---|---|
| `admin` | `admin1234` | ADMIN (상품 등록/수정/삭제) |
| `test`  | `test1234`  | USER |

---

## 2. DB 접속정보 (적용 완료)

`src/main/java/util/DBUtil.java` 상단 상수에 실제 접속정보가 설정되어 있다.
(로컬 MySQL 8.0 `root` 계정으로 연결 검증 완료, `db/schema.sql`·`db/seed.sql` 적용 완료)

```java
private static final String URL = "jdbc:mysql://localhost:3306/slimedb?...";
private static final String USER = "root";
private static final String PASSWORD = "wjdahrwls@1028";   // ← 환경 바뀌면 여기 수정
```

> 다른 PC/계정에서 돌릴 때는 이 세 상수만 바꾸면 된다.
> CLI 로 시드를 다시 넣을 땐 한글 깨짐 방지를 위해 `--default-character-set=utf8mb4` 를 붙인다:
> `mysql --default-character-set=utf8mb4 -uroot -p slimedb < db/seed.sql`

---

## 3. 라이브러리 (WEB-INF/lib)

Tomcat 10.1 은 Jakarta 네임스페이스라 기존 `jstl-1.2.jar`(javax)가 **동작하지 않는다**.
이미 다음과 같이 교체해 두었다.

- ❌ 제거: `jstl-1.2_2.jar` (javax)
- ✅ 추가: `jakarta.servlet.jsp.jstl-api-3.0.0.jar`, `jakarta.servlet.jsp.jstl-3.0.1.jar`
- 그대로 사용: `mysql-connector-j-9.7.0.jar`, `cos_2.jar`(이미지 업로드), `commons-fileupload`, `commons-io`

JSP 태그라이브러리는 모두 Jakarta JSTL(`uri="jakarta.tags.core"`, `jakarta.tags.fmt`)을 쓴다.

---

## 4. 이클립스에서 실행

1. **Project → Clean** (옛 인메모리 클래스 잔재 제거)
2. 프로젝트를 **Tomcat 10.1** 서버에 Add and Remove
3. **Run on Server** → 브라우저에서 `http://localhost:8080/SlimeFactory/`
   - 루트 접속 → `index.jsp` → `/main` 으로 forward

> `src/main/resources` 의 `messages_*.properties`(다국어)는 빌드 시 `WEB-INF/classes` 로
> 배포되도록 `.classpath` / `.settings` 에 소스 폴더로 등록해 두었다.

---

## 5. URL ↔ 기능 매핑

| URL | 기능 | 권한 |
|---|---|---|
| `/main` | 시작페이지(접속시간) | 전체 |
| `/products` | 상품 목록 | 전체 |
| `/product?id=` | 상품 상세 (없으면 예외페이지) | 전체 |
| `/member/join` | 회원가입(중복확인·유효성) | 전체 |
| `/member/login` `/member/logout` | 로그인/로그아웃(세션) | 전체/USER |
| `/member/edit` `/mypage` | 정보수정·탈퇴(Soft delete) / 내정보·주문내역 | USER |
| `/cart` `/cart/add` | 장바구니 조회·수량변경·담기 | USER |
| `/order/checkout` `/order/place` | 주문서 / 주문확정(재고차감 트랜잭션·쿠키) | USER |
| `/admin/product/manage` `/admin/product/form` `/admin/product/save` `/admin/product/delete` | 상품 관리/등록·수정/저장(이미지업로드)/삭제 | **ADMIN** |

---

## 6. 구현 포인트 점검

- **인증/인가**: `filter/AuthFilter` — 미로그인 시 로그인 페이지로 리다이렉트(원래 경로 복귀), `/admin/*` 는 ADMIN 만
- **인코딩**: `filter/EncodingFilter` — 전 요청 UTF-8
- **비밀번호**: `util/PasswordUtil` — SHA-256 해시 저장(평문 금지). 운영 시 BCrypt 권장 위치 주석 표기
- **탈퇴**: Soft delete(`UPDATE user SET deleted_at = NOW()`), 활성 조회는 `WHERE deleted_at IS NULL`
- **장바구니**: 로그인 사용자 DB 영속화, 같은 상품 재담기 시 `UNIQUE` + `ON DUPLICATE KEY UPDATE` 로 수량 증가
- **주문 트랜잭션**: `service/OrderService` — order/order_item insert + `order_item.price` 스냅샷 + `product.stock` 차감을 한 트랜잭션, 재고 부족 시 롤백
- **예외 처리**: `web.xml` 의 `<error-page>` — 404 / 500 / `ProductNotFoundException`(상품없음)
- **이미지 업로드**: cos `MultipartRequest` → `webapp/resources/uploads/` 저장, DB 에 상대경로 기록
- **다국어**: `messages_ko/en.properties` + JSTL `fmt`, 헤더의 KO/EN 토글(세션 보관)

---

## 7. 패키지 구조

```
src/main/java/
├── controller/   # 서블릿(요청 분기) — @WebServlet
├── dao/          # UserDao, ProductDao, CartDao, OrderDao (PreparedStatement)
├── dto/          # User, Product, Cart, Order, OrderItem (테이블과 1:1)
├── service/      # OrderService (주문 트랜잭션)
├── filter/       # AuthFilter, EncodingFilter
├── exception/    # ProductNotFoundException, OutOfStockException
└── util/         # DBUtil, PasswordUtil
src/main/resources/   # messages*.properties (다국어)
src/main/webapp/pages/ # common · product · member · cart · order · error
```
