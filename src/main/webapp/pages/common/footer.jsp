<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%-- 공통 바닥글: 다크 밴드 + 접속 시간 출력 (시작페이지 모듈화 요구사항) --%>
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<footer class="bg-dark text-light mt-5">
	<div class="container py-4">
		<div class="row gy-4">
			<div class="col-12 col-md-4">
				<h5 class="fw-bold mb-2">슬라임 팩토리</h5>
				<p class="small text-secondary mb-0">
					웹서버컴퓨팅 텀프로젝트<br>
					팀 나무목 — 정목진 · 김나윤
				</p>
			</div>
			<div class="col-6 col-md-3">
				<h6 class="fw-bold">쇼핑</h6>
				<ul class="list-unstyled small mb-0">
					<li><a href="${ctx}/products" class="link-light text-decoration-none">전체 상품</a></li>
					<li><a href="${ctx}/cart" class="link-light text-decoration-none">장바구니</a></li>
					<li><a href="${ctx}/mypage" class="link-light text-decoration-none">주문 내역</a></li>
				</ul>
			</div>
			<div class="col-6 col-md-3">
				<h6 class="fw-bold">회원</h6>
				<ul class="list-unstyled small mb-0">
					<li><a href="${ctx}/member/login" class="link-light text-decoration-none">로그인</a></li>
					<li><a href="${ctx}/member/join" class="link-light text-decoration-none">회원가입</a></li>
				</ul>
			</div>
			<div class="col-12 col-md-2">
				<h6 class="fw-bold">고객센터</h6>
				<p class="small text-secondary mb-0">Tomcat 10.1 · MySQL</p>
			</div>
		</div>

		<hr class="border-secondary my-3">

		<div class="d-flex flex-wrap justify-content-between small text-secondary">
			<span>© 2025 Slime Factory. 학습용 프로젝트.</span>
			<span>접속 시간: <fmt:formatDate value="${now}" pattern="yyyy-MM-dd (E) HH:mm:ss" /></span>
		</div>
	</div>
</footer>

</body>
</html>
