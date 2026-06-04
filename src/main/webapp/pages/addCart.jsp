<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%
	// 장바구니 담기 처리(세션 이용). 상품 ID를 받아 세션 장바구니에 추가한다.
	String ctx = request.getContextPath();
	String id = request.getParameter("id");
	if (id == null || id.trim().equals("")) {
		response.sendRedirect(ctx + "/pages/main.jsp");
		return;
	}

	ProductRepository dao = ProductRepository.getInstance();
	Product product = dao.getProductById(id);
	if (product == null) {
		// 존재하지 않는 상품이면 예외 페이지로 이동
		response.sendRedirect(ctx + "/pages/exceptionNoProduct.jsp");
		return;
	}

	// 세션에 보관된 장바구니를 가져온다. 없으면 새로 만들어 세션에 저장.
	ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
	if (cartList == null) {
		cartList = new ArrayList<Product>();
		session.setAttribute("cartlist", cartList);
	}

	// 이미 담긴 상품이면 수량만 1 증가, 처음 담는 상품이면 새로 추가한다.
	int cnt = 0;
	for (int i = 0; i < cartList.size(); i++) {
		Product goods = cartList.get(i);
		if (goods.getProductId().equals(id)) {
			cnt++;
			goods.setQuantity(goods.getQuantity() + 1);
		}
	}

	if (cnt == 0) {
		product.setQuantity(1);
		cartList.add(product);
	}

	// 담은 뒤 장바구니 페이지로 이동
	response.sendRedirect(ctx + "/pages/cart.jsp");
%>
