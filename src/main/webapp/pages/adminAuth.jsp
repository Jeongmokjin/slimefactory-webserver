<%
	// ===== 관리자 권한 검사 (관리자 전용 페이지 맨 위에서 include) =====
	// 세션의 role 이 "ADMIN" 이 아니면 로그인 페이지로 보낸다.
	// (header.jsp 보다 먼저 include 되어야 출력 전에 리다이렉트가 가능하다.)
	Object _role = session.getAttribute("role");
	if (!"ADMIN".equals(_role)) {
		String _ctx = request.getContextPath();
		// 로그인 후 원래 가려던 페이지로 돌아오도록 redirect 파라미터에 담아 전달
		String _target = request.getRequestURI();
		if (request.getQueryString() != null) {
			_target = _target + "?" + request.getQueryString();
		}
		response.sendRedirect(_ctx + "/pages/login.jsp?error=auth&redirect="
				+ java.net.URLEncoder.encode(_target, "UTF-8"));
		return;
	}
%>
