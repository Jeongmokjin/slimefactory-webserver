<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="주문서 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<div class="mb-3">
		<h1 class="h4 fw-bold mb-1">주문서 작성</h1>
		<p class="text-muted small mb-0">배송지를 입력하고 주문을 확정하세요.</p>
	</div>

	<c:if test="${param.error == 'address'}">
		<div class="alert alert-danger">배송지를 입력해 주세요.</div>
	</c:if>

	<div class="row g-4">
		<!-- 주문 상품 요약 -->
		<div class="col-12 col-lg-7">
			<div class="card shadow-sm">
				<div class="card-header bg-light fw-bold">주문 상품</div>
				<div class="card-body p-0">
					<table class="table table-bordered mb-0 align-middle">
						<thead class="table-light">
							<tr>
								<th>상품</th>
								<th class="text-end">단가</th>
								<th class="text-end">수량</th>
								<th class="text-end">소계</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="c" items="${items}">
								<tr>
									<td><c:out value="${c.productName}" /></td>
									<td class="text-end"><fmt:formatNumber value="${c.price}" />원</td>
									<td class="text-end">${c.quantity}</td>
									<td class="text-end"><fmt:formatNumber value="${c.subtotal}" />원</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
							<tr class="table-light">
								<td colspan="3" class="text-end fw-bold">합계</td>
								<td class="text-end fw-bold text-primary"><fmt:formatNumber value="${total}" />원</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>

		<!-- 배송 정보 -->
		<div class="col-12 col-lg-5">
			<div class="card shadow-sm">
				<div class="card-header bg-light fw-bold">배송 정보</div>
				<div class="card-body">
					<form action="${ctx}/order/place" method="post">
						<div class="mb-3">
							<label class="form-label">주문자</label>
							<input type="text" class="form-control" value="<c:out value='${loginUser.name}'/>" disabled>
						</div>
						<div class="mb-3">
							<label class="form-label">연락처</label>
							<input type="text" class="form-control" value="<c:out value='${loginUser.phone}'/>" disabled>
						</div>
						<div class="mb-3">
							<label class="form-label">배송지 <span class="text-danger">*</span></label>
							<input type="text" name="address" class="form-control" required
							       placeholder="받으실 주소를 입력하세요">
						</div>
						<div class="d-grid gap-2">
							<button type="submit" class="btn btn-success btn-lg">
								<fmt:formatNumber value="${total}" />원 주문 확정
							</button>
							<a href="${ctx}/cart" class="btn btn-outline-secondary">장바구니로</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</main>

<%@ include file="/pages/common/footer.jsp" %>
