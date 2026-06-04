<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// 배송 정보 처리(쿠키 이용). 폼으로 받은 배송 정보를 쿠키에 저장한다.
	request.setCharacterEncoding("UTF-8");
	String ctx = request.getContextPath();

	// 한글이 깨지지 않도록 URL 인코딩하여 쿠키에 담는다.
	Cookie cartId       = new Cookie("Shipping_cartId",       URLEncoder.encode(emptyIfNull(request.getParameter("cartId")),       "UTF-8"));
	Cookie name         = new Cookie("Shipping_name",         URLEncoder.encode(emptyIfNull(request.getParameter("name")),         "UTF-8"));
	Cookie phone        = new Cookie("Shipping_phone",        URLEncoder.encode(emptyIfNull(request.getParameter("phone")),        "UTF-8"));
	Cookie shippingDate = new Cookie("Shipping_shippingDate", URLEncoder.encode(emptyIfNull(request.getParameter("shippingDate")), "UTF-8"));
	Cookie zipCode      = new Cookie("Shipping_zipCode",      URLEncoder.encode(emptyIfNull(request.getParameter("zipCode")),      "UTF-8"));
	Cookie addressName  = new Cookie("Shipping_addressName",  URLEncoder.encode(emptyIfNull(request.getParameter("addressName")),  "UTF-8"));

	// 쿠키 유효기간: 1일
	int maxAge = 24 * 60 * 60;
	cartId.setMaxAge(maxAge);
	name.setMaxAge(maxAge);
	phone.setMaxAge(maxAge);
	shippingDate.setMaxAge(maxAge);
	zipCode.setMaxAge(maxAge);
	addressName.setMaxAge(maxAge);

	response.addCookie(cartId);
	response.addCookie(name);
	response.addCookie(phone);
	response.addCookie(shippingDate);
	response.addCookie(zipCode);
	response.addCookie(addressName);

	response.sendRedirect(ctx + "/pages/orderConfirmation.jsp");
%>
<%!
	// null 파라미터를 빈 문자열로 바꿔주는 도우미 메서드
	private String emptyIfNull(String value) {
		return (value == null) ? "" : value;
	}
%>
