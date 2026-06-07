<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:useBean id="nowMain" class="java.util.Date" />
<c:set var="pageTitle" value="슬라임 팩토리 - 홈" scope="request" />
<c:set var="activeNav" value="home" scope="request" />
<%@ include file="/pages/common/header.jsp" %>

<main class="container py-4">

	<!-- 탈퇴 완료 -->
	<c:if test="${param.withdraw == '1'}">
		<div class="alert alert-success">회원 탈퇴가 완료되었습니다. 이용해 주셔서 감사합니다.</div>
	</c:if>

	<!-- 점보트론(히어로) -->
	<section class="p-5 mb-4 bg-light border rounded-3">
		<div class="container-fluid py-2">
			<h1 class="display-5 fw-bold">슬라임 팩토리에 오신 것을 환영합니다</h1>
			<p class="lead col-md-8">
				말랑말랑 쫀득한 슬라임을 한자리에. 캔디톤 신상부터 베스트셀러까지 만나보세요.
			</p>
			<a href="${ctx}/products" class="btn btn-primary btn-lg">전체 상품 보기</a>
			<p class="text-muted small mt-3 mb-0">
				현재 접속 시간: <fmt:formatDate value="${nowMain}" pattern="yyyy-MM-dd (E) HH:mm:ss" />
			</p>
		</div>
	</section>

	<!-- 보조 카테고리 네비 -->
	<%@ include file="/pages/common/nav.jsp" %>

	<!-- 상품 목록 -->
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h2 class="h4 fw-bold mb-0">전체상품</h2>
		<span class="text-muted small">총 ${products.size()}개의 슬라임</span>
	</div>

	<c:choose>
		<c:when test="${empty products}">
			<div class="alert alert-secondary text-center py-5">아직 등록된 상품이 없습니다.</div>
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
									<h3 class="h6 card-title text-truncate mb-1"><c:out value="${p.name}" /></h3>
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
