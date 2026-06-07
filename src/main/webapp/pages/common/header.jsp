<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:if test="${not empty param.lang}">
	<c:set var="lang" value="${param.lang}" scope="session" />
</c:if>
<c:if test="${empty sessionScope.lang}">
	<c:set var="lang" value="ko" scope="session" />
</c:if>
<fmt:setLocale value="${sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<c:set var="ctx" value="${pageContext.request.contextPath}" /> <!-- 경로 생략용 ctx 생성 -->
<c:set var="loginUser" value="${sessionScope.loginUser}" />
<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${empty pageTitle ? '슬라임 팩토리' : pageTitle}</title>
	<link rel="stylesheet" href="${ctx}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctx}/resources/css/slime.css">
</head>
<body class="bg-white">

<header class="border-bottom bg-white">
	<nav class="navbar navbar-expand-lg">
		<div class="container">
			<a class="navbar-brand fw-bold" href="${ctx}/main">슬라임 팩토리</a>

			<ul class="nav nav-pills me-auto mb-0">
				<li class="nav-item">
					<a class="nav-link ${activeNav == 'home' ? 'active' : ''}" href="${ctx}/main">
						<fmt:message key="nav.home" />
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link ${activeNav == 'products' ? 'active' : ''}" href="${ctx}/products">
						<fmt:message key="nav.products" />
					</a>
				</li>
				<c:if test="${loginUser.role == 'ADMIN'}">
					<li class="nav-item">
						<a class="nav-link ${activeNav == 'admin' ? 'active' : ''}" href="${ctx}/admin/product/manage">
							<fmt:message key="nav.admin" />
						</a>
					</li>
				</c:if>
			</ul>

			<div class="d-flex align-items-center gap-2">
				<div class="btn-group btn-group-sm" role="group" aria-label="language">
					<a href="?lang=ko" class="btn ${sessionScope.lang == 'ko' ? 'btn-primary' : 'btn-outline-secondary'}">한</a>
					<a href="?lang=en" class="btn ${sessionScope.lang == 'en' ? 'btn-primary' : 'btn-outline-secondary'}">EN</a>
				</div>

				<a href="${ctx}/cart" class="btn btn-outline-secondary btn-sm">
					🛒 <fmt:message key="common.cart" />
				</a>

				<c:choose>
					<c:when test="${empty loginUser}">
						<a href="${ctx}/member/login" class="btn btn-outline-primary btn-sm">
							<fmt:message key="nav.login" />
						</a>
						<a href="${ctx}/member/join" class="btn btn-primary btn-sm">
							<fmt:message key="nav.join" />
						</a>
					</c:when>
					<c:otherwise>
						<a href="${ctx}/mypage" class="btn btn-link btn-sm text-decoration-none fw-semibold">
							<c:out value="${loginUser.name}" /><fmt:message key="nav.suffix.honorific" />
						</a>
						<a href="${ctx}/member/logout" class="btn btn-outline-secondary btn-sm">
							<fmt:message key="nav.logout" />
						</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</nav>
</header>
