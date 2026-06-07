<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="회원가입 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<div class="row justify-content-center">
		<div class="col-12 col-md-7 col-lg-6">
			<div class="card shadow-sm">
				<div class="card-body p-4">
					<h1 class="h4 fw-bold mb-1">회원가입</h1>
					<p class="text-muted small mb-4">필수 정보를 입력해 주세요.</p>

					<c:if test="${not empty error}">
						<div class="alert alert-danger py-2">${error}</div>
					</c:if>

					<form action="${ctx}/member/join" method="post">
						<div class="mb-3">
							<label class="form-label">아이디 <span class="text-danger">*</span></label>
							<div class="input-group">
								<input type="text" name="userId" id="userId" class="form-control" required
								       value="<c:out value='${userId}'/>">
								<button type="button" class="btn btn-outline-secondary" onclick="checkId()">중복확인</button>
							</div>
							<div class="form-text" id="idMsg"></div>
						</div>
						<div class="mb-3">
							<label class="form-label">비밀번호 <span class="text-danger">*</span>
								<span class="form-text">(4자 이상)</span></label>
							<input type="password" name="password" class="form-control" required>
						</div>
						<div class="mb-3">
							<label class="form-label">비밀번호 확인 <span class="text-danger">*</span></label>
							<input type="password" name="passwordConfirm" class="form-control" required>
						</div>
						<div class="mb-3">
							<label class="form-label">이름 <span class="text-danger">*</span></label>
							<input type="text" name="name" class="form-control" required
							       value="<c:out value='${name}'/>">
						</div>
						<div class="mb-3">
							<label class="form-label">이메일 <span class="text-danger">*</span></label>
							<input type="email" name="email" class="form-control" required
							       value="<c:out value='${email}'/>">
						</div>
						<div class="mb-3">
							<label class="form-label">연락처 <span class="text-danger">*</span></label>
							<input type="text" name="phone" class="form-control" required
							       placeholder="010-1234-5678" value="<c:out value='${phone}'/>">
						</div>
						<div class="d-grid">
							<button type="submit" class="btn btn-primary">가입하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</main>

<script>
	// 아이디 중복확인(AJAX)
	function checkId() {
		var id = document.getElementById('userId').value.trim();
		var msg = document.getElementById('idMsg');
		if (!id) { msg.textContent = '아이디를 입력하세요.'; msg.className = 'form-text text-danger'; return; }
		fetch('${ctx}/member/check-id?userId=' + encodeURIComponent(id)) // 아이디 체크 서블렛에 요청 날림
			.then(function (r) { return r.text(); })
			.then(function (t) {
				if (t === 'available') { msg.textContent = '사용 가능한 아이디입니다.'; msg.className = 'form-text text-success'; }
				else { msg.textContent = '이미 사용 중인 아이디입니다.'; msg.className = 'form-text text-danger'; }
			});
	}
</script>

<%@ include file="/pages/common/footer.jsp" %>
