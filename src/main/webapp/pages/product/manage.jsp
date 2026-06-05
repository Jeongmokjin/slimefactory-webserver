<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="상품 관리 - 슬라임 팩토리" scope="request" />
<c:set var="activeNav" value="admin" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<div class="d-flex justify-content-between align-items-center mb-3">
		<div>
			<h1 class="h4 fw-bold mb-1">상품 관리</h1>
			<p class="text-muted small mb-0">관리자 전용 — 등록 / 수정 / 삭제</p>
		</div>
		<a href="${ctx}/admin/product/form" class="btn btn-primary">+ 새 상품 등록</a>
	</div>

	<c:if test="${param.deleted == '1'}">
		<div class="alert alert-success py-2">상품이 삭제되었습니다.</div>
	</c:if>
	<c:if test="${param.error == 'inuse'}">
		<div class="alert alert-danger py-2">주문 이력이 있는 상품은 삭제할 수 없습니다.</div>
	</c:if>

	<div class="table-responsive">
		<table class="table table-bordered table-hover align-middle">
			<thead class="table-light">
				<tr>
					<th>#</th>
					<th>상품명</th>
					<th class="text-end">가격</th>
					<th class="text-end">재고</th>
					<th class="text-center">관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="p" items="${products}">
					<tr>
						<td>${p.productId}</td>
						<td><c:out value="${p.name}" /></td>
						<td class="text-end"><fmt:formatNumber value="${p.price}" />원</td>
						<td class="text-end">${p.stock}</td>
						<td class="text-center">
							<div class="d-inline-flex gap-1">
								<a href="${ctx}/admin/product/form?id=${p.productId}" class="btn btn-outline-primary btn-sm">수정</a>
								<form action="${ctx}/admin/product/delete" method="post"
								      onsubmit="return confirm('정말 삭제할까요?');">
									<input type="hidden" name="id" value="${p.productId}">
									<button type="submit" class="btn btn-danger btn-sm">삭제</button>
								</form>
							</div>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty products}">
					<tr><td colspan="5" class="text-center text-muted py-4">등록된 상품이 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>

</main>

<%@ include file="/pages/common/footer.jsp" %>
