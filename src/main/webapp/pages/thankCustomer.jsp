<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%
	request.setAttribute("pageTitle", "주문 완료 - 슬라임 팩토리");
%>
<%@ include file="header.jsp" %>
<%
	// 쿠키에서 주문번호와 배송 희망일을 읽어 화면에 보여준다.
	String shipping_cartId = "";
	String shipping_shippingDate = "";

	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if (n.equals("Shipping_cartId"))       shipping_cartId       = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
			if (n.equals("Shipping_shippingDate")) shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(), "UTF-8");
		}
	}
%>

<main class="container">

	<div class="result-hero ok">
		<div class="big">🎉</div>
		<h1>주문해 주셔서 감사합니다!</h1>
		<p>주문하신 슬라임은 <strong><%= shipping_shippingDate %></strong> 에 배송될 예정이에요.</p>
		<p>주문번호 : <span class="order-no"><%= shipping_cartId %></span></p>
	</div>

	<div style="text-align:center; margin-bottom:48px;">
		<a href="<%= ctx %>/pages/main.jsp" class="btn btn-primary">&laquo; 쇼핑 계속하기</a>
	</div>

</main>

<%@ include file="footer.jsp" %>
<%
	// 주문이 끝났으므로 장바구니(세션)와 배송 정보(쿠키)를 모두 정리한다.
	session.invalidate();

	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if (n.startsWith("Shipping_")) {
				thisCookie.setMaxAge(0);   // 유효기간 0 → 즉시 삭제
				thisCookie.setPath("/");
				response.addCookie(thisCookie);
			}
		}
	}
%>
