<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%
	request.setAttribute("pageTitle", "장바구니 - 슬라임 팩토리");
%>
<%@ include file="header.jsp" %>
<%
	// 세션에 보관된 장바구니 목록을 가져온다.
	String cartId = session.getId();
	ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
	if (cartList == null) {
		cartList = new ArrayList<Product>();
	}
%>

<main class="container">

	<div class="page-head">
		<h1>장바구니 🛒</h1>
		<p class="sub">담아 둔 말랑이들을 확인하고 주문해 보세요.</p>
	</div>

	<%
		if (cartList.isEmpty()) {
	%>
		<!-- 장바구니가 비어있을 때 -->
		<div class="empty-cart">
			<div class="big">🫧</div>
			<p>장바구니가 비어 있어요. 마음에 드는 슬라임을 담아 보세요!</p>
			<a href="<%= ctx %>/pages/main.jsp" class="btn btn-primary">상품 구경하러 가기</a>
		</div>
	<%
		} else {
	%>
		<!-- 상단 도구 모음: 전체 비우기 / 주문하기 -->
		<div class="cart-toolbar">
			<a href="<%= ctx %>/pages/deleteCart.jsp?cartId=<%= cartId %>" class="btn btn-danger btn-sm">장바구니 비우기</a>
			<a href="<%= ctx %>/pages/shippingInfo.jsp?cartId=<%= cartId %>" class="btn btn-primary btn-sm">주문하기 &raquo;</a>
		</div>

		<table class="cart-table">
			<thead>
				<tr>
					<th>상품</th>
					<th class="num">가격</th>
					<th class="center">수량</th>
					<th class="num">소계</th>
					<th class="center">비고</th>
				</tr>
			</thead>
			<tbody>
			<%
				int sum = 0;
				for (int i = 0; i < cartList.size(); i++) {
					Product product = cartList.get(i);
					int total = product.getUnitPrice() * product.getQuantity();
					sum = sum + total;
			%>
				<tr>
					<td>
						<div class="cart-item">
							<span class="cart-thumb" style="background:linear-gradient(135deg, <%= product.getTint() %>, #ffffff);"><%= product.getEmoji() %></span>
							<span>
								<span class="nm"><%= product.getName() %></span><br>
								<span class="cat"><%= product.getProductId() %> · <%= product.getCategory() %></span>
							</span>
						</div>
					</td>
					<td class="num"><%= String.format("%,d", product.getUnitPrice()) %>원</td>
					<td class="center"><%= product.getQuantity() %></td>
					<td class="num"><%= String.format("%,d", total) %>원</td>
					<td class="center">
						<a href="<%= ctx %>/pages/removeCart.jsp?id=<%= product.getProductId() %>" class="link-remove">삭제</a>
					</td>
				</tr>
			<%
				}
			%>
			</tbody>
			<tfoot>
				<tr>
					<td>총 합계</td>
					<td></td>
					<td></td>
					<td class="num cart-total-price"><%= String.format("%,d", sum) %>원</td>
					<td></td>
				</tr>
			</tfoot>
		</table>

		<a href="<%= ctx %>/pages/main.jsp" class="btn btn-secondary">&laquo; 쇼핑 계속하기</a>
	<%
		}
	%>

</main>

<%@ include file="footer.jsp" %>
