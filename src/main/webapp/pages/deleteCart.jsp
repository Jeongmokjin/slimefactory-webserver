<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 장바구니 전체 비우기. 세션을 무효화하여 담긴 상품을 모두 삭제한다.
	String ctx = request.getContextPath();
	session.invalidate();
	response.sendRedirect(ctx + "/pages/cart.jsp");
%>
