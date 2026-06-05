<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="장바구니 - 슬라임 팩토리" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<div class="mb-3">
		<h1 class="h4 fw-bold mb-1">장바구니</h1>
		<p class="text-muted small mb-0">담은 슬라임을 확인하고 주문하세요.</p>
	</div>

	<c:if test="${param['empty'] == '1'}">
		<div class="alert alert-danger">장바구니가 비어 있습니다.</div>
	</c:if>
	<c:if test="${not empty param.error}">
		<div class="alert alert-danger"><c:out value="${param.error}" /></div>
	</c:if>

	<c:choose>
		<c:when test="${empty items}">
			<div class="alert alert-secondary text-center py-5">
				<p class="mb-3">장바구니가 비어 있습니다.</p>
				<a href="${ctx}/products" class="btn btn-outline-primary">쇼핑 계속하기</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="table-responsive">
				<table class="table table-bordered align-middle">
					<thead class="table-light">
						<tr>
							<th>상품</th>
							<th class="text-end">단가</th>
							<th class="text-center">수량</th>
							<th class="text-end">소계</th>
							<th class="text-center">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="c" items="${items}">
							<tr>
								<td>
									<div class="d-flex align-items-center gap-3">
										<c:choose>
											<c:when test="${not empty c.imageUrl}">
												<img src="${ctx}/${c.imageUrl}" alt="" width="56" height="56"
												     class="rounded border" style="object-fit:cover;">
											</c:when>
											<c:otherwise>
												<span class="d-inline-flex align-items-center justify-content-center rounded border bg-light text-muted"
												      style="width:56px;height:56px;font-size:.7rem;">없음</span>
											</c:otherwise>
										</c:choose>
										<div>
											<div class="fw-semibold"><c:out value="${c.productName}" /></div>
											<div class="text-muted small">재고 ${c.stock}개</div>
										</div>
									</div>
								</td>
								<td class="text-end"><fmt:formatNumber value="${c.price}" />원</td>
								<td class="text-center">
									<form action="${ctx}/cart" method="post" class="d-flex justify-content-center gap-1">
										<input type="hidden" name="action" value="update">
										<input type="hidden" name="productId" value="${c.productId}">
										<input type="number" name="quantity" value="${c.quantity}" min="1" max="${c.stock}"
										       class="form-control form-control-sm" style="width:72px;">
										<button type="submit" class="btn btn-outline-secondary btn-sm">변경</button>
									</form>
								</td>
								<td class="text-end fw-semibold"><fmt:formatNumber value="${c.subtotal}" />원</td>
								<td class="text-center">
									<form action="${ctx}/cart" method="post">
										<input type="hidden" name="action" value="remove">
										<input type="hidden" name="productId" value="${c.productId}">
										<button type="submit" class="btn btn-danger btn-sm">삭제</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 합계 패널 -->
			<div class="card shadow-sm ms-auto" style="max-width:360px;">
				<div class="card-body">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<span class="text-muted">합계</span>
						<span class="h4 fw-bold mb-0 text-primary"><fmt:formatNumber value="${total}" />원</span>
					</div>
					<div class="d-grid gap-2">
						<a href="${ctx}/order/checkout" class="btn btn-success">주문하기</a>
						<a href="${ctx}/products" class="btn btn-outline-secondary">계속 쇼핑</a>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>

</main>

<%@ include file="/pages/common/footer.jsp" %>
