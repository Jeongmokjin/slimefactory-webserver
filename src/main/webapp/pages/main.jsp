<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%
	String pageTitle = "슬라임 팩토리 - 전체상품";
%>
<%@ include file="header.jsp" %>
<%
	// 자바빈즈(DAO)에서 상품 목록을 가져온다.
	ProductRepository dao = ProductRepository.getInstance();
	ArrayList<Product> listOfProducts = dao.getAllProducts();
%>

<main class="container">

	<!-- 히어로 밴드 -->
	<section class="hero-band">
		<div>
			<h1>슬라임 팩토리에<br>놀러와! 🫧</h1>
			<p>말랑말랑 쫀득한 슬라임을 한자리에. 오늘의 캔디톤 신상부터 베스트셀러까지 만나보세요.</p>
			<a href="#product-list" class="btn btn-primary">구경하러 가기</a>
		</div>
		<div class="hero-blob">🟢</div>
	</section>

	<!-- 카테고리 필터 (UI) -->
	<div class="category-bar">
		<button class="category-pill active">전체</button>
		<button class="category-pill">기본슬라임</button>
		<button class="category-pill">클리어</button>
		<button class="category-pill">버터</button>
		<button class="category-pill">글리터</button>
	</div>

	<!-- 상품 목록 -->
	<section id="product-list">
		<div class="section-head">
			<h2>전체상품</h2>
			<span class="count">총 <%= listOfProducts.size() %>개의 슬라임</span>
		</div>

		<div class="product-grid">
		<%
			for (int i = 0; i < listOfProducts.size(); i++) {
				Product product = listOfProducts.get(i);
		%>
			<!-- 상품 카드: 클릭하면 상세 페이지(product.jsp)로 이동 -->
			<article class="product-card">
				<a href="<%= ctx %>/pages/product.jsp?id=<%= product.getProductId() %>">
					<div class="card-photo" style="background:linear-gradient(135deg, <%= product.getTint() %>, #ffffff);">
						<%
							String badge = product.getBadge();
							if ("SALE".equals(badge)) {
						%>
							<span class="badge badge-sale">SALE</span>
						<%
							} else if ("NEW".equals(badge)) {
						%>
							<span class="badge badge-new">NEW</span>
						<%
							}
						%>
						<span><%= product.getEmoji() %></span>
					</div>
				</a>
				<p class="card-cat"><%= product.getCategory() %></p>
				<a href="<%= ctx %>/pages/product.jsp?id=<%= product.getProductId() %>">
					<h3 class="card-name"><%= product.getName() %></h3>
				</a>
				<p class="card-price"><%= String.format("%,d", product.getUnitPrice()) %>원</p>
				<div class="card-actions">
					<a href="<%= ctx %>/pages/product.jsp?id=<%= product.getProductId() %>"
					   class="btn btn-primary btn-block">담기</a>
				</div>
			</article>
		<%
			}
		%>
		</div>
	</section>

</main>

<%@ include file="footer.jsp" %>
