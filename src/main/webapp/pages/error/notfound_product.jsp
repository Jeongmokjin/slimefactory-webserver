<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="상품을 찾을 수 없습니다 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-5">
	<div class="text-center py-5">
		<h1 class="h3 fw-bold mb-2">상품을 찾을 수 없습니다</h1>
		<p class="text-muted">요청하신 상품이 존재하지 않거나 삭제되었습니다.</p>
		<a href="${ctx}/products" class="btn btn-primary mt-2">전체 상품 보기</a>
	</div>
</main>

<%@ include file="/pages/common/footer.jsp" %>
