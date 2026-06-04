<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%@ page errorPage="exceptionNoProduct.jsp" %>
<%
	// 상품 ID로 단건 조회. 없으면 예외 페이지로 이동.
	String id = request.getParameter("id");
	ProductRepository dao = ProductRepository.getInstance();
	Product product = dao.getProductById(id);
	if (product == null) {
		throw new Exception("해당 상품을 찾을 수 없습니다. (id=" + id + ")");
	}
	String pageTitle = product.getName() + " - 슬라임 팩토리";
%>
<%@ include file="header.jsp" %>

<main class="container">

	<!-- 브레드크럼 -->
	<nav class="breadcrumb">
		<a href="<%= ctx %>/pages/main.jsp">전체상품</a> &nbsp;›&nbsp;
		<%= product.getCategory() %> &nbsp;›&nbsp;
		<span style="color:var(--body-strong);"><%= product.getName() %></span>
	</nav>

	<section class="detail">
		<!-- 상품 이미지 -->
		<div class="detail-photo" style="background:linear-gradient(135deg, <%= product.getTint() %>, #ffffff);">
			<span><%= product.getEmoji() %></span>
		</div>

		<!-- 상품 정보 -->
		<div>
			<span class="detail-cat"><%= product.getCategory() %></span>
			<h1><%= product.getName() %></h1>
			<p class="desc"><%= product.getDescription() %></p>
			<p class="price"><%= String.format("%,d", product.getUnitPrice()) %>원</p>

			<table class="meta-table">
				<tr>
					<th>상품코드</th>
					<td><%= product.getProductId() %></td>
				</tr>
				<tr>
					<th>분류</th>
					<td><%= product.getCategory() %></td>
				</tr>
				<tr>
					<th>출시일</th>
					<td><%= product.getReleaseDate() %></td>
				</tr>
				<tr>
					<th>상태</th>
					<td><%= product.getCondition() %></td>
				</tr>
				<tr>
					<th>재고</th>
					<td>
						<%
							long stock = product.getUnitsInStock();
							if (stock <= 40) {
						%>
							<span class="stock-low"><%= stock %>개 (품절임박)</span>
						<%
							} else {
						%>
							<span class="stock-ok"><%= stock %>개</span>
						<%
							}
						%>
					</td>
				</tr>
			</table>

			<div class="detail-actions">
				<a href="#" class="btn btn-primary">담기</a>
				<a href="#" class="btn btn-secondary">찜하기</a>
				<a href="<%= ctx %>/pages/main.jsp" class="btn btn-secondary">목록으로</a>
			</div>
		</div>
	</section>

</main>

<%@ include file="footer.jsp" %>
