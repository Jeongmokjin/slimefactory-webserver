<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 메인 페이지 = 상품 목록 페이지. 앱 루트 접속 시 목록으로 이동.
	response.sendRedirect(request.getContextPath() + "/pages/main.jsp");
%>
