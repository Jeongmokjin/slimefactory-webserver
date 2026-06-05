-- =====================================================
-- 슬라임 팩토리 — 초기 데이터(시드)
-- 실행: mysql -uroot -p slimedb < db/seed.sql
--
-- 비밀번호는 PasswordUtil.hash() = SHA-256("slime-factory-2025" + 평문) 와
-- 동일한 값으로 미리 계산해 넣었다. (애플리케이션 로그인과 호환)
--   admin / admin1234   (ADMIN)
--   test  / test1234    (USER)
-- =====================================================

USE slimedb;

-- 관리자 계정 (비번: admin1234)
INSERT INTO `user` (user_id, name, password, email, phone, role) VALUES
('admin', '관리자', '59957ca380a8637e2e01fb94aa1400969367367441aab94cb12f5a7b7f083680',
 'admin@slime.com', '010-0000-0000', 'ADMIN')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- 일반 사용자 (비번: test1234)
INSERT INTO `user` (user_id, name, password, email, phone, role) VALUES
('test', '김슬라임', '4341616bdf15500be724a4ac05eb07250c301ebfe7a317dcfd897a9f815e1278',
 'test@slime.com', '010-1111-2222', 'USER')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- 샘플 상품
INSERT INTO `product` (name, price, description, stock, image_url) VALUES
('말랑 베이직 슬라임', 6900, '가장 기본이 되는 쫀득한 베이직 슬라임. 손에 달라붙지 않고 부드럽게 늘어나요.', 120, NULL),
('크리스탈 클리어 슬라임', 8900, '유리처럼 투명하게 비치는 클리어 슬라임. 톡톡 터지는 청량한 소리가 매력.', 80, NULL),
('버터 카라멜 슬라임', 9500, '진한 카라멜 향이 솔솔, 꾸덕꾸덕 부드럽게 펴 발리는 버터 슬라임.', 60, NULL),
('스타더스트 글리터 슬라임', 11000, '은하수를 담은 듯 반짝이는 글리터가 가득한 프리미엄 슬라임.', 45, NULL),
('민트 소다 슬라임', 7500, '청량한 민트색에 작은 거품 비즈가 콕콕. 시원한 소다 느낌.', 95, NULL),
('베리 핑크 클라우드 슬라임', 8200, '구름처럼 폭신폭신한 클라우드 슬라임. 달콤한 베리향과 핑크빛.', 70, NULL),
('레몬 버터 슬라임', 9500, '상큼한 레몬향이 가득한 노란 버터 슬라임. 꾸덕한 텍스처.', 55, NULL),
('오로라 클리어 글리터 슬라임', 12500, '클리어 베이스 위에 오로라 글리터가 흩날리는 한정판.', 30, NULL);
