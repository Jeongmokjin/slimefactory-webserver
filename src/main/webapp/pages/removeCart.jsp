<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%
	// 장바구니에서 상품 한 건 빼기(세션 이용).
	String ctx = request.getContextPath();
	String id = request.getParameter("id");
	if (id == null || id.trim().equals("")) {
		response.sendRedirect(ctx + "/pages/cart.jsp");
		return;
	}

	ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
	if (cartList != null) {
		for (int i = 0; i < cartList.size(); i++) {
			Product goods = cartList.get(i);
			if (goods.getProductId().equals(id)) {
				cartList.remove(goods);
				break;
			}
		}
	}

	response.sendRedirect(ctx + "/pages/cart.jsp");
%>
