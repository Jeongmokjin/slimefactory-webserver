<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="슬라임 팩토리 - 전체상품" scope="request" />
<c:set var="activeNav" value="products" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<%@ include file="/pages/common/nav.jsp" %>

	<div class="d-flex justify-content-between align-items-center mb-3">
		<h1 class="h4 fw-bold mb-0">전체상품</h1>
		<span class="text-muted small">총 ${products.size()}개의 슬라임</span>
	</div>

	<c:choose>
		<c:when test="${empty products}">
			<div class="alert alert-secondary text-center py-5">
				아직 등록된 상품이 없습니다.
				<c:if test="${loginUser.role == 'ADMIN'}">
					<div class="mt-3">
						<a href="${ctx}/admin/product/form" class="btn btn-primary">첫 상품 등록하기</a>
					</div>
				</c:if>
			</div>
		</c:when>
		<c:otherwise>
			<div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">
				<c:forEach var="p" items="${products}">
					<div class="col">
						<div class="card h-100 shadow-sm hover-raise">
							<a href="${ctx}/product?id=${p.productId}" class="card-link-reset">
								<c:choose>
									<c:when test="${not empty p.imageUrl}">
										<img src="${ctx}/${p.imageUrl}" class="card-img-top product-thumb"
										     alt="<c:out value='${p.name}'/>">
									</c:when>
									<c:otherwise>
										<div class="no-image">이미지 없음</div>
									</c:otherwise>
								</c:choose>
							</a>
							<div class="card-body d-flex flex-column">
								<a href="${ctx}/product?id=${p.productId}" class="card-link-reset">
									<h2 class="h6 card-title text-truncate mb-1"><c:out value="${p.name}" /></h2>
								</a>
								<p class="mb-1">
									<c:choose>
										<c:when test="${p.stock <= 0}">
											<span class="badge text-bg-danger">품절</span>
										</c:when>
										<c:otherwise>
											<span class="badge text-bg-secondary">재고 ${p.stock}</span>
										</c:otherwise>
									</c:choose>
								</p>
								<p class="fw-bold fs-5 mb-3"><fmt:formatNumber value="${p.price}" />원</p>
								<a href="${ctx}/cart/add?productId=${p.productId}"
								   class="btn btn-success mt-auto ${p.stock <= 0 ? 'disabled' : ''}">
									<fmt:message key="common.add.cart" />
								</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>

</main>

<%@ include file="/pages/common/footer.jsp" %>
