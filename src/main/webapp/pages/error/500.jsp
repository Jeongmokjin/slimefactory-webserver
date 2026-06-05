<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="문제가 발생했습니다 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-5">
	<div class="text-center py-5">
		<h1 class="display-4 fw-bold">500</h1>
		<p class="h5 mb-2">서버에 문제가 발생했습니다</p>
		<p class="text-muted">잠시 후 다시 시도해 주세요. 문제가 계속되면 관리자에게 알려주세요.</p>
		<a href="${ctx}/main" class="btn btn-primary mt-2">홈으로 돌아가기</a>
	</div>
</main>

<%@ include file="/pages/common/footer.jsp" %>
