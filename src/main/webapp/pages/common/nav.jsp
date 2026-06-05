<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- 공통 보조 네비게이션(카테고리 바). 상품 목록/메인에서 include. --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<ul class="nav nav-pills border rounded-3 p-2 mb-4 bg-light">
	<li class="nav-item"><a class="nav-link active" href="${ctx}/products">전체</a></li>
	<li class="nav-item"><a class="nav-link link-secondary" href="${ctx}/products">기본슬라임</a></li>
	<li class="nav-item"><a class="nav-link link-secondary" href="${ctx}/products">클리어</a></li>
	<li class="nav-item"><a class="nav-link link-secondary" href="${ctx}/products">버터</a></li>
	<li class="nav-item"><a class="nav-link link-secondary" href="${ctx}/products">글리터</a></li>
</ul>
