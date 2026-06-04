<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그아웃. 로그인 정보만 제거하고 장바구니(cartlist)는 그대로 둔다.
	String ctx = request.getContextPath();
	session.removeAttribute("loginId");
	session.removeAttribute("role");
	response.sendRedirect(ctx + "/pages/main.jsp");
%>
