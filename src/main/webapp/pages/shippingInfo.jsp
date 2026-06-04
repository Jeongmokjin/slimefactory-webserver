<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setAttribute("pageTitle", "배송 정보 - 슬라임 팩토리");
	String cartId = request.getParameter("cartId");
%>
<%@ include file="header.jsp" %>

<main class="container">

	<div class="page-head">
		<h1>배송 정보 입력 📦</h1>
		<p class="sub">슬라임을 받으실 정보를 입력해 주세요.</p>
	</div>

	<!-- 입력값은 processShippingInfo.jsp 에서 쿠키로 저장된다. -->
	<form class="shipping-form" action="<%= ctx %>/pages/processShippingInfo.jsp" method="post">
		<input type="hidden" name="cartId" value="<%= cartId %>">

		<div class="form-row">
			<label>성명</label>
			<input type="text" name="name" class="form-input" placeholder="홍길동" required>
		</div>

		<div class="form-row">
			<label>연락처</label>
			<input type="text" name="phone" class="form-input" placeholder="010-1234-5678">
		</div>

		<div class="form-row">
			<label>배송 희망일 <span class="form-hint">(yyyy/mm/dd)</span></label>
			<input type="text" name="shippingDate" class="form-input" placeholder="2026/06/10">
		</div>

		<div class="form-row">
			<label>우편번호</label>
			<input type="text" name="zipCode" class="form-input" placeholder="01234">
		</div>

		<div class="form-row">
			<label>주소</label>
			<input type="text" name="addressName" class="form-input" placeholder="서울특별시 ○○구 ○○로 12, 101호">
		</div>

		<div class="form-actions">
			<a href="<%= ctx %>/pages/cart.jsp" class="btn btn-secondary">&laquo; 이전</a>
			<button type="submit" class="btn btn-primary">등록</button>
			<a href="<%= ctx %>/pages/checkOutCancelled.jsp" class="btn btn-secondary">취소</a>
		</div>
	</form>

</main>

<%@ include file="footer.jsp" %>
