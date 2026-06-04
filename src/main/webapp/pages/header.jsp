<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%
	// 페이지에서 include 하기 전에 request 속성 "pageTitle"을 지정하면 제목으로 사용됩니다.
	Object _pageTitle = request.getAttribute("pageTitle");
	String _title = (_pageTitle == null) ? "슬라임 팩토리" : _pageTitle.toString();
	String ctx = request.getContextPath();

	// 세션 장바구니에 담긴 상품 종류 수(장바구니 배지 표시용)
	ArrayList<Product> _cartList = (ArrayList<Product>) session.getAttribute("cartlist");
	int _cartCount = (_cartList == null) ? 0 : _cartList.size();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= _title %></title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@500;600;700;800&family=Noto+Sans+KR:wght@500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%= ctx %>/resources/css/slime.css">
</head>
<body>
<!-- ===================== 머리글(Header) ===================== -->
<header class="top-nav">
	<div class="container nav-inner">
		<a href="<%= ctx %>/pages/main.jsp" class="brand">
			<span class="brand-blob"></span>
			슬라임 팩토리
		</a>
		<ul class="nav-links">
			<li><a href="<%= ctx %>/pages/main.jsp">전체상품</a></li>
			<li><a href="<%= ctx %>/pages/main.jsp?cat=신상">신상</a></li>
			<li><a href="<%= ctx %>/pages/main.jsp?cat=베스트">베스트</a></li>
			<li><a href="<%= ctx %>/pages/main.jsp?cat=이벤트">이벤트</a></li>
		</ul>
		<div class="nav-right">
			<a href="<%= ctx %>/pages/cart.jsp" class="icon-btn" title="장바구니">🛒<span class="cart-count"><%= _cartCount %></span></a>
			<a href="#" class="btn btn-secondary" style="min-height:40px;padding:8px 18px;">로그인</a>
		</div>
	</div>
</header>
