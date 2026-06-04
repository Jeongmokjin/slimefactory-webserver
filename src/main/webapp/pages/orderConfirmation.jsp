<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="dto.Product" %>
<%
	request.setAttribute("pageTitle", "주문 확인 - 슬라임 팩토리");
%>
<%@ include file="header.jsp" %>
<%
	// 쿠키에 저장된 배송 정보를 읽어온다.
	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_phone = "";
	String shipping_shippingDate = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";

	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if (n.equals("Shipping_cartId"))       shipping_cartId       = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			if (n.equals("Shipping_name"))         shipping_name         = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			if (n.equals("Shipping_phone"))        shipping_phone        = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			if (n.equals("Shipping_shippingDate")) shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			if (n.equals("Shipping_zipCode"))      shipping_zipCode      = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			if (n.equals("Shipping_addressName"))  shipping_addressName  = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
		}
	}

	// 세션의 장바구니 목록을 가져온다.
	ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
	if (cartList == null) {
		cartList = new ArrayList<Product>();
	}
%>

<main class="container">

	<div class="page-head">
		<h1>주문 확인 🧾</h1>
		<p class="sub">아래 내용으로 주문하시겠어요?</p>
	</div>

	<div class="receipt">
		<!-- 배송 정보 (쿠키에서 읽은 값) -->
		<div class="receipt-head">
			<div>
				<h4>배송지</h4>
				<p>성명 : <%= shipping_name %></p>
				<p>연락처 : <%= shipping_phone %></p>
				<p>주소 : (<%= shipping_zipCode %>) <%= shipping_addressName %></p>
			</div>
			<div>
				<h4>배송 정보</h4>
				<p>배송 희망일 : <%= shipping_shippingDate %></p>
				<p>주문번호 : <%= shipping_cartId %></p>
			</div>
		</div>

		<!-- 주문 상품 목록 (세션 장바구니) -->
		<table class="order-table">
			<thead>
				<tr>
					<th>상품</th>
					<th class="center">수량</th>
					<th class="num">가격</th>
					<th class="num">소계</th>
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
					<td><%= product.getEmoji() %> <%= product.getName() %></td>
					<td class="center"><%= product.getQuantity() %></td>
					<td class="num"><%= String.format("%,d", product.getUnitPrice()) %>원</td>
					<td class="num"><%= String.format("%,d", total) %>원</td>
				</tr>
			<%
				}
			%>
			</tbody>
			<tfoot>
				<tr>
					<td>총액</td>
					<td></td>
					<td></td>
					<td class="num cart-total-price"><%= String.format("%,d", sum) %>원</td>
				</tr>
			</tfoot>
		</table>
	</div>

	<div class="form-actions">
		<a href="<%= ctx %>/pages/shippingInfo.jsp?cartId=<%= shipping_cartId %>" class="btn btn-secondary">&laquo; 이전</a>
		<a href="<%= ctx %>/pages/thankCustomer.jsp" class="btn btn-primary">주문 완료</a>
		<a href="<%= ctx %>/pages/checkOutCancelled.jsp" class="btn btn-secondary">취소</a>
	</div>

</main>

<%@ include file="footer.jsp" %>
