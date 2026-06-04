<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 페이지에서 include 하기 전에 String pageTitle 변수를 선언하면 제목으로 사용됩니다.
	String _title = (pageTitle == null) ? "슬라임 팩토리" : pageTitle;
	String ctx = request.getContextPath();
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
			<a href="#" class="icon-btn" title="장바구니">🛒<span class="cart-count">0</span></a>
			<a href="#" class="btn btn-secondary" style="min-height:40px;padding:8px 18px;">로그인</a>
		</div>
	</div>
</header>
