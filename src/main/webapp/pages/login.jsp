<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setAttribute("pageTitle", "로그인 - 슬라임 팩토리");
	String error = request.getParameter("error");
	// 로그인 성공 후 돌아갈 페이지(관리자 페이지 접근 시 adminAuth 가 넣어줌)
	String redirect = request.getParameter("redirect");
	if (redirect == null) redirect = "";
%>
<%@ include file="header.jsp" %>

<main class="container">

	<div class="page-head">
		<h1>로그인 🔑</h1>
		<p class="sub">관리자 계정으로 로그인하면 상품을 등록할 수 있어요.</p>
	</div>

	<%
		if ("auth".equals(error)) {
	%>
		<div class="form-error">관리자만 접근할 수 있는 페이지예요. 먼저 로그인해 주세요.</div>
	<%
		} else if (error != null) {
	%>
		<div class="form-error">아이디 또는 비밀번호가 올바르지 않아요.</div>
	<%
		}
	%>

	<!-- 입력값은 loginProcess.jsp 에서 검증한다. -->
	<form class="shipping-form auth-form" action="<%= ctx %>/pages/loginProcess.jsp" method="post">
		<input type="hidden" name="redirect" value="<%= redirect %>">

		<div class="form-row">
			<label>아이디</label>
			<input type="text" name="id" class="form-input" placeholder="admin" autofocus required>
		</div>

		<div class="form-row">
			<label>비밀번호</label>
			<input type="password" name="password" class="form-input" placeholder="••••" required>
		</div>

		<div class="form-actions">
			<button type="submit" class="btn btn-primary btn-block">로그인</button>
		</div>

		<p class="form-hint" style="margin-top:14px; display:block;">임시 관리자 계정 — 아이디: admin / 비밀번호: 1234</p>
	</form>

</main>

<%@ include file="footer.jsp" %>
