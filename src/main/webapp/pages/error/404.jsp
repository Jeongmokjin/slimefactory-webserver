<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="페이지를 찾을 수 없습니다 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-5">
	<div class="text-center py-5">
		<h1 class="display-4 fw-bold">404</h1>
		<p class="h5 mb-2">페이지를 찾을 수 없습니다</p>
		<p class="text-muted">요청하신 페이지가 사라졌거나 주소가 잘못되었습니다.</p>
		<a href="${ctx}/main" class="btn btn-primary mt-2">홈으로 돌아가기</a>
	</div>
</main>

<%@ include file="/pages/common/footer.jsp" %>
