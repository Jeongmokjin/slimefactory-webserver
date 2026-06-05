<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="주문 완료 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<!-- 완료 알림 -->
	<div class="alert alert-success text-center py-4">
		<h1 class="h4 fw-bold">주문이 완료되었습니다</h1>
		<p class="mb-1">주문번호 <span class="fw-bold">#${order.orderId}</span></p>
		<p class="mb-1"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm" /></p>
		<p class="small text-muted mb-0">최근 주문번호는 쿠키에 기록되었습니다.</p>
	</div>

	<!-- 영수증 -->
	<div class="card shadow-sm">
		<div class="card-header bg-light d-flex justify-content-between align-items-center">
			<span class="fw-bold">주문 내역</span>
			<span class="badge text-bg-secondary">${order.status}</span>
		</div>
		<div class="card-body">
			<div class="row mb-3">
				<div class="col-md-8">
					<h2 class="h6 fw-bold">배송지</h2>
					<p class="mb-0"><c:out value="${order.address}" /></p>
				</div>
				<div class="col-md-4 text-md-end">
					<h2 class="h6 fw-bold">결제 금액</h2>
					<p class="h4 fw-bold text-primary mb-0"><fmt:formatNumber value="${order.totalPrice}" />원</p>
				</div>
			</div>

			<div class="table-responsive">
				<table class="table table-bordered align-middle mb-0">
					<thead class="table-light">
						<tr>
							<th>상품</th>
							<th class="text-end">단가</th>
							<th class="text-end">수량</th>
							<th class="text-end">소계</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="it" items="${order.items}">
							<tr>
								<td><c:out value="${it.productName}" /></td>
								<td class="text-end"><fmt:formatNumber value="${it.price}" />원</td>
								<td class="text-end">${it.quantity}</td>
								<td class="text-end"><fmt:formatNumber value="${it.subtotal}" />원</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="d-flex gap-2 mt-4">
		<a href="${ctx}/mypage" class="btn btn-primary">주문 내역 보기</a>
		<a href="${ctx}/products" class="btn btn-outline-secondary">계속 쇼핑</a>
	</div>

</main>

<%@ include file="/pages/common/footer.jsp" %>
