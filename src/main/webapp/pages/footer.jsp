<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
	String _ctx = request.getContextPath();
	SimpleDateFormat _sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
	String _now = _sdf.format(new Date());
%>
<!-- ===================== 바닥글(Footer) ===================== -->
<footer class="site-footer">
	<div class="container">
		<div class="footer-cols">
			<div>
				<div class="footer-brand"><span class="brand-blob"></span>슬라임 팩토리</div>
				<p style="font-size:14px;color:var(--muted);max-width:280px;margin:0;">
					말랑말랑 쫀득한 슬라임을 만나는 가장 즐거운 방법.<br>
					매일매일 새로운 캔디톤 슬라임이 입고됩니다.
				</p>
			</div>
			<div>
				<h4>상품</h4>
				<ul>
					<li><a href="<%= _ctx %>/pages/main.jsp">전체상품</a></li>
					<li><a href="<%= _ctx %>/pages/main.jsp">신상품</a></li>
					<li><a href="<%= _ctx %>/pages/main.jsp">베스트</a></li>
				</ul>
			</div>
			<div>
				<h4>고객센터</h4>
				<ul>
					<li>1234-5678</li>
					<li>평일 10:00~18:00</li>
					<li>주말/공휴일 휴무</li>
				</ul>
			</div>
			<div>
				<h4>회사</h4>
				<ul>
					<li><a href="#">회사 소개</a></li>
					<li><a href="#">이용약관</a></li>
					<li><a href="#">개인정보처리방침</a></li>
				</ul>
			</div>
		</div>
		<div class="footer-bottom">
			<span>&copy; 2026 Slime Factory · 팀 나무목</span>
			<span>현재 접속 시간 : <%= _now %></span>
		</div>
	</div>
</footer>
</body>
</html>
