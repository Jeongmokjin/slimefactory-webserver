<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%@ include file="adminAuth.jsp" %>
<%
	// 상품 등록 처리(관리자 전용). 입력값으로 Product 를 만들어 저장소에 추가한다.
	request.setCharacterEncoding("UTF-8");
	String ctx = request.getContextPath();

	String productId   = request.getParameter("productId");
	String name        = request.getParameter("name");
	String unitPriceStr = request.getParameter("unitPrice");
	String category    = request.getParameter("category");
	String description = request.getParameter("description");
	String stockStr    = request.getParameter("unitsInStock");
	String releaseDate = request.getParameter("releaseDate");
	String condition   = request.getParameter("condition");
	String emoji       = request.getParameter("emoji");
	String tint        = request.getParameter("tint");
	String badge       = request.getParameter("badge");

	// 숫자 항목은 비어 있으면 0 으로 처리
	int unitPrice = (unitPriceStr == null || unitPriceStr.trim().equals("")) ? 0 : Integer.parseInt(unitPriceStr.trim());
	long unitsInStock = (stockStr == null || stockStr.trim().equals("")) ? 0 : Long.parseLong(stockStr.trim());

	// 비어 있는 표시 항목은 기본값으로 채운다.
	if (emoji == null || emoji.trim().equals("")) emoji = "🫧";
	if (tint == null || tint.trim().equals(""))   tint = "#eafff5";
	if (badge == null) badge = "";

	Product product = new Product();
	product.setProductId(productId);
	product.setName(name);
	product.setUnitPrice(unitPrice);
	product.setCategory(category);
	product.setDescription(description);
	product.setUnitsInStock(unitsInStock);
	product.setReleaseDate(releaseDate);
	product.setCondition(condition);
	product.setEmoji(emoji);
	product.setTint(tint);
	product.setBadge(badge);
	product.setFilename("");

	ProductRepository.getInstance().addProduct(product);

	// 등록 후 상품 목록으로 이동
	response.sendRedirect(ctx + "/pages/main.jsp");
%>
