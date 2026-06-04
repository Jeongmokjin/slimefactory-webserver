<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setAttribute("pageTitle", "주문 취소 - 슬라임 팩토리");
%>
<%@ include file="header.jsp" %>

<main class="container">

	<div class="result-hero cancel">
		<div class="big">🫠</div>
		<h1>주문이 취소되었어요</h1>
		<p>장바구니에 담긴 슬라임은 그대로 남아 있으니 언제든 다시 주문하실 수 있어요.</p>
	</div>

	<div style="text-align:center; margin-bottom:48px;">
		<a href="<%= ctx %>/pages/cart.jsp" class="btn btn-secondary">장바구니로</a>
		<a href="<%= ctx %>/pages/main.jsp" class="btn btn-primary">쇼핑 계속하기</a>
	</div>

</main>

<%@ include file="footer.jsp" %>
