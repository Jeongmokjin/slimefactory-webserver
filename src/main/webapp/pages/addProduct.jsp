<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="adminAuth.jsp" %>
<%
	request.setAttribute("pageTitle", "상품 등록 - 슬라임 팩토리");
%>
<%@ include file="header.jsp" %>

<main class="container">

	<div class="page-head">
		<h1>상품 등록 ✏️</h1>
		<p class="sub">관리자 전용 — 새로운 슬라임을 등록합니다.</p>
	</div>

	<!-- 입력값은 processAddProduct.jsp 에서 ProductRepository 에 추가된다. -->
	<form class="shipping-form" action="<%= ctx %>/pages/processAddProduct.jsp" method="post">

		<div class="form-row">
			<label>상품 코드</label>
			<input type="text" name="productId" class="form-input" placeholder="SLM09" required>
		</div>

		<div class="form-row">
			<label>상품명</label>
			<input type="text" name="name" class="form-input" placeholder="말랑 베이직 슬라임" required>
		</div>

		<div class="form-row">
			<label>가격(원)</label>
			<input type="number" name="unitPrice" class="form-input" placeholder="6900" min="0" required>
		</div>

		<div class="form-row">
			<label>분류</label>
			<input type="text" name="category" class="form-input" placeholder="기본슬라임 / 클리어 / 버터 / 글리터" required>
		</div>

		<div class="form-row">
			<label>설명</label>
			<input type="text" name="description" class="form-input" placeholder="상품 설명을 입력하세요">
		</div>

		<div class="form-row">
			<label>재고 수량</label>
			<input type="number" name="unitsInStock" class="form-input" placeholder="100" min="0">
		</div>

		<div class="form-row">
			<label>출시일 <span class="form-hint">(yyyy/mm/dd)</span></label>
			<input type="text" name="releaseDate" class="form-input" placeholder="2026/06/01">
		</div>

		<div class="form-row">
			<label>상태</label>
			<input type="text" name="condition" class="form-input" placeholder="신상품 / 기본">
		</div>

		<div class="form-row">
			<label>이모지 <span class="form-hint">(사진 대체)</span></label>
			<input type="text" name="emoji" class="form-input" placeholder="🟢">
		</div>

		<div class="form-row">
			<label>배경색 <span class="form-hint">(hex)</span></label>
			<input type="text" name="tint" class="form-input" placeholder="#eafff5">
		</div>

		<div class="form-row">
			<label>배지</label>
			<input type="text" name="badge" class="form-input" placeholder="NEW / SALE / 없으면 비움">
		</div>

		<div class="form-actions">
			<a href="<%= ctx %>/pages/main.jsp" class="btn btn-secondary">취소</a>
			<button type="submit" class="btn btn-primary">등록</button>
		</div>
	</form>

</main>

<%@ include file="footer.jsp" %>
