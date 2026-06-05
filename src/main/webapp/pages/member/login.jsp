<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="로그인 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<div class="row justify-content-center">
		<div class="col-12 col-md-6 col-lg-5">
			<div class="card shadow-sm">
				<div class="card-body p-4">
					<h1 class="h4 fw-bold text-center mb-4">로그인</h1>

					<c:if test="${param.joined == '1'}">
						<div class="alert alert-success py-2">회원가입이 완료되었습니다. 로그인해 주세요.</div>
					</c:if>
					<c:if test="${not empty error}">
						<div class="alert alert-danger py-2">${error}</div>
					</c:if>

					<form action="${ctx}/member/login" method="post">
						<input type="hidden" name="redirect" value="<c:out value='${param.redirect}'/>">
						<div class="mb-3">
							<label class="form-label">아이디</label>
							<input type="text" name="userId" class="form-control" required
							       value="<c:out value='${userId}'/>" autofocus>
						</div>
						<div class="mb-3">
							<label class="form-label">비밀번호</label>
							<input type="password" name="password" class="form-control" required>
						</div>
						<div class="d-grid">
							<button type="submit" class="btn btn-primary">로그인</button>
						</div>
					</form>

					<p class="text-center text-muted small mt-3 mb-0">
						아직 회원이 아니신가요?
						<a href="${ctx}/member/join" class="fw-semibold">회원가입</a>
					</p>
				</div>
			</div>
		</div>
	</div>

</main>

<%@ include file="/pages/common/footer.jsp" %>
