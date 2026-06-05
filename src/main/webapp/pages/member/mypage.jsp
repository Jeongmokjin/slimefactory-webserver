<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="마이페이지 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<div class="mb-3">
		<h1 class="h4 fw-bold mb-1">마이페이지</h1>
		<p class="text-muted small mb-0">내 정보와 주문 내역을 확인하세요.</p>
	</div>

	<c:if test="${param.updated == '1'}">
		<div class="alert alert-success py-2">회원 정보가 수정되었습니다.</div>
	</c:if>

	<!-- 내 정보 -->
	<div class="card shadow-sm mb-4">
		<div class="card-header bg-light d-flex justify-content-between align-items-center">
			<span class="fw-bold">내 정보</span>
			<a href="${ctx}/member/edit" class="btn btn-outline-secondary btn-sm">정보 수정 · 탈퇴</a>
		</div>
		<div class="card-body">
			<dl class="row mb-0">
				<dt class="col-sm-3">아이디</dt>
				<dd class="col-sm-9"><c:out value="${loginUser.userId}" /></dd>
				<dt class="col-sm-3">이름</dt>
				<dd class="col-sm-9"><c:out value="${loginUser.name}" /></dd>
				<dt class="col-sm-3">이메일</dt>
				<dd class="col-sm-9"><c:out value="${loginUser.email}" /></dd>
				<dt class="col-sm-3">연락처</dt>
				<dd class="col-sm-9"><c:out value="${loginUser.phone}" /></dd>
				<dt class="col-sm-3">등급</dt>
				<dd class="col-sm-9"><span class="badge text-bg-secondary">${loginUser.role}</span></dd>
			</dl>
		</div>
	</div>

	<!-- 주문 내역 -->
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h2 class="h5 fw-bold mb-0">주문 내역</h2>
		<span class="text-muted small">총 ${orders.size()}건</span>
	</div>

	<c:choose>
		<c:when test="${empty orders}">
			<div class="alert alert-secondary text-center py-5">
				<p class="mb-3">아직 주문 내역이 없습니다.</p>
				<a href="${ctx}/products" class="btn btn-outline-primary">쇼핑하러 가기</a>
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach var="o" items="${orders}">
				<div class="card shadow-sm mb-3">
					<div class="card-header bg-light d-flex justify-content-between align-items-center">
						<div>
							<span class="fw-bold">주문번호 #${o.orderId}</span>
							<span class="text-muted small ms-2">
								<fmt:formatDate value="${o.orderDate}" pattern="yyyy-MM-dd HH:mm" />
							</span>
						</div>
						<span class="badge text-bg-secondary">${o.status}</span>
					</div>
					<div class="card-body">
						<p class="small text-muted mb-2">배송지: <c:out value="${o.address}" /></p>
						<div class="table-responsive">
							<table class="table table-bordered align-middle mb-2">
								<thead class="table-light">
									<tr>
										<th>상품</th>
										<th class="text-end">단가(주문시점)</th>
										<th class="text-end">수량</th>
										<th class="text-end">소계</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="it" items="${o.items}">
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
						<div class="text-end">
							<span class="text-muted me-2">합계</span>
							<span class="h5 fw-bold text-primary"><fmt:formatNumber value="${o.totalPrice}" />원</span>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>

</main>

<%@ include file="/pages/common/footer.jsp" %>
