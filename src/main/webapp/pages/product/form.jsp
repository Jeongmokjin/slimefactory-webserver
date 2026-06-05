<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="edit" value="${not empty product}" />
<c:set var="pageTitle" value="${edit ? '상품 수정' : '상품 등록'} - 슬라임 팩토리" scope="request" />
<c:set var="activeNav" value="admin" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<div class="row justify-content-center">
		<div class="col-12 col-md-8 col-lg-7">
			<div class="mb-3">
				<h1 class="h4 fw-bold mb-1">${edit ? '상품 수정' : '상품 등록'}</h1>
				<p class="text-muted small mb-0">관리자 전용 — 이미지와 함께 상품 정보를 입력하세요.</p>
			</div>

			<c:if test="${not empty error}">
				<div class="alert alert-danger py-2">${error}</div>
			</c:if>

			<div class="card shadow-sm">
				<div class="card-body">
					<%-- 이미지 업로드를 위해 multipart/form-data --%>
					<form action="${ctx}/admin/product/save" method="post" enctype="multipart/form-data">
						<c:if test="${edit}">
							<input type="hidden" name="productId" value="${product.productId}">
						</c:if>

						<div class="mb-3">
							<label class="form-label">상품명 <span class="text-danger">*</span></label>
							<input type="text" name="name" class="form-control" required
							       value="<c:out value='${product.name}'/>">
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label class="form-label">가격(원) <span class="text-danger">*</span></label>
								<input type="number" name="price" class="form-control" min="0" required
								       value="${product.price}">
							</div>
							<div class="col-md-6 mb-3">
								<label class="form-label">재고 <span class="text-danger">*</span></label>
								<input type="number" name="stock" class="form-control" min="0" required
								       value="${product.stock}">
							</div>
						</div>
						<div class="mb-3">
							<label class="form-label">상세 설명</label>
							<textarea name="description" class="form-control" rows="5"><c:out value="${product.description}" /></textarea>
						</div>
						<div class="mb-3">
							<label class="form-label">상품 이미지
								<span class="form-text">(수정 시 미첨부하면 기존 이미지 유지)</span></label>
							<input type="file" name="image" class="form-control" accept="image/*">
							<c:if test="${edit and not empty product.imageUrl}">
								<div class="form-text">현재 이미지: ${product.imageUrl}</div>
							</c:if>
						</div>

						<div class="d-flex gap-2">
							<button type="submit" class="btn btn-primary">${edit ? '수정 저장' : '상품 등록'}</button>
							<a href="${ctx}/admin/product/manage" class="btn btn-outline-secondary">취소</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</main>

<%@ include file="/pages/common/footer.jsp" %>
