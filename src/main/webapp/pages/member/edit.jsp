<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="정보 수정 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<div class="row justify-content-center">
		<div class="col-12 col-md-7 col-lg-6">
			<div class="mb-3">
				<h1 class="h4 fw-bold mb-1">정보 수정 · 탈퇴</h1>
				<p class="text-muted small mb-0">변경할 정보를 입력하세요. 아이디는 변경할 수 없습니다.</p>
			</div>

			<!-- 정보 수정 -->
			<div class="card shadow-sm mb-4">
				<div class="card-header bg-light fw-bold">정보 수정</div>
				<div class="card-body">
					<form action="${ctx}/member/edit" method="post">
						<input type="hidden" name="action" value="update">
						<div class="mb-3">
							<label class="form-label">아이디</label>
							<input type="text" class="form-control" value="<c:out value='${loginUser.userId}'/>" disabled>
						</div>
						<div class="mb-3">
							<label class="form-label">이름</label>
							<input type="text" name="name" class="form-control" required
							       value="<c:out value='${loginUser.name}'/>">
						</div>
						<div class="mb-3">
							<label class="form-label">이메일</label>
							<input type="email" name="email" class="form-control" required
							       value="<c:out value='${loginUser.email}'/>">
						</div>
						<div class="mb-3">
							<label class="form-label">연락처</label>
							<input type="text" name="phone" class="form-control" required
							       value="<c:out value='${loginUser.phone}'/>">
						</div>
						<div class="mb-3">
							<label class="form-label">새 비밀번호 <span class="form-text">(변경할 때만 입력)</span></label>
							<input type="password" name="newPassword" class="form-control" placeholder="비워두면 유지">
						</div>
						<div class="d-flex gap-2">
							<button type="submit" class="btn btn-primary">수정 저장</button>
							<a href="${ctx}/mypage" class="btn btn-outline-secondary">취소</a>
						</div>
					</form>
				</div>
			</div>

			<!-- 탈퇴 -->
			<div class="card border-danger shadow-sm">
				<div class="card-header bg-danger-subtle text-danger-emphasis fw-bold">회원 탈퇴</div>
				<div class="card-body">
					<p class="small text-muted">
						탈퇴 시 계정은 비활성화되며(소프트 삭제) 장바구니가 정리됩니다. 주문 내역은 보존됩니다.
					</p>
					<form action="${ctx}/member/edit" method="post"
					      onsubmit="return confirm('정말 탈퇴하시겠어요? 되돌릴 수 없습니다.');">
						<input type="hidden" name="action" value="withdraw">
						<button type="submit" class="btn btn-danger">회원 탈퇴</button>
					</form>
				</div>
			</div>
		</div>
	</div>

</main>

<%@ include file="/pages/common/footer.jsp" %>
