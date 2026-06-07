<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="${product.name} - 슬라임 팩토리" scope="request" />
<c:set var="activeNav" value="products" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<!-- 브레드크럼 -->
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="${ctx}/main">홈</a></li>
			<li class="breadcrumb-item"><a href="${ctx}/products">전체상품</a></li>
			<li class="breadcrumb-item active"><c:out value="${product.name}" /></li>
		</ol>
	</nav>

	<div class="row g-4">
		<!-- 이미지 -->
		<div class="col-12 col-md-6">
			<c:choose>
				<c:when test="${not empty product.imageUrl}">
					<img src="${ctx}/${product.imageUrl}" class="detail-image rounded-3"
					     alt="<c:out value='${product.name}'/>">
				</c:when>
				<c:otherwise>
					<div class="detail-image no-image rounded-3">이미지 없음</div>
				</c:otherwise>
			</c:choose>
		</div>

		<!-- 정보 패널 -->
		<div class="col-12 col-md-6">
			<span class="badge text-bg-secondary mb-2">SLIME</span>
			<h1 class="h2 fw-bold"><c:out value="${product.name}" /></h1>
			<p class="text-body-secondary"><c:out value="${product.description}" /></p>
			<p class="fw-bold fs-3 text-primary"><fmt:formatNumber value="${product.price}" />원</p>

			<table class="table table-bordered">
				<tbody>
					<tr>
						<th class="table-light" style="width:30%;">상품번호</th>
						<td>#${product.productId}</td>
					</tr>
					<tr>
						<th class="table-light">재고</th>
						<td>
							<c:choose>
								<c:when test="${product.stock <= 0}">
									<span class="badge text-bg-danger">품절</span>
								</c:when>
								<c:when test="${product.stock < 10}">
									<span class="badge text-bg-warning">${product.stock}개 (얼마 안 남았어요!)</span>
								</c:when>
								<c:otherwise>
									<span class="badge text-bg-success">${product.stock}개</span>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th class="table-light">등록일</th>
						<td><fmt:formatDate value="${product.createdAt}" pattern="yyyy-MM-dd" /></td>
					</tr>
				</tbody>
			</table>

			<c:choose>
				<c:when test="${product.stock <= 0}">
					<button class="btn btn-success btn-lg" disabled>품절</button>
				</c:when>
				<c:otherwise>
					<form action="${ctx}/cart/add" method="post" class="row g-2 align-items-end">
						<input type="hidden" name="productId" value="${product.productId}">
						<div class="col-auto">
							<label class="form-label small mb-1">수량</label>
							<input type="number" name="quantity" value="1" min="1" max="${product.stock}"
							       class="form-control" style="width:100px;">
						</div>
						<div class="col-auto">
							<button type="submit" class="btn btn-success btn-lg">장바구니 담기</button>
						</div>
					</form>
				</c:otherwise>
			</c:choose>

			<div class="mt-3 d-flex gap-2">
				<a href="${ctx}/products" class="btn btn-outline-secondary">목록으로</a>
				<c:if test="${loginUser.role == 'ADMIN'}">
					<a href="${ctx}/admin/product/form?id=${product.productId}" class="btn btn-outline-primary">수정</a>
				</c:if>
			</div>
		</div>
	</div>

</main>

<%@ include file="/pages/common/footer.jsp" %>
