<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isErrorPage="true"%>
<%
	String pageTitle = "상품을 찾을 수 없어요 - 슬라임 팩토리";
%>
<%@ include file="header.jsp" %>

<main class="container">
	<section class="error-hero">
		<div class="big">🫠</div>
		<h1>앗, 슬라임이 녹아버렸어요!</h1>
		<p>요청하신 상품을 찾을 수 없습니다. 주소가 바뀌었거나 판매가 종료된 상품일 수 있어요.</p>
		<a href="<%= ctx %>/pages/main.jsp" class="btn btn-primary">전체상품 보러가기</a>
	</section>
</main>

<%@ include file="footer.jsp" %>
