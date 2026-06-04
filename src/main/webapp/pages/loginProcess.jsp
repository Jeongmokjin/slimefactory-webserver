<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 처리. 임시 관리자 계정(admin / 1234)만 허용한다.
	request.setCharacterEncoding("UTF-8");
	String ctx = request.getContextPath();

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String redirect = request.getParameter("redirect");

	// 임시 계정 정보 (추후 회원 DB 연동 시 이 부분을 교체)
	final String ADMIN_ID = "admin";
	final String ADMIN_PW = "1234";

	if (ADMIN_ID.equals(id) && ADMIN_PW.equals(password)) {
		// 인증 성공: 세션에 로그인 정보와 권한(role)을 저장
		session.setAttribute("loginId", id);
		session.setAttribute("role", "ADMIN");

		// 로그인 전 가려던 페이지가 있으면 그곳으로, 없으면 메인으로 이동
		if (redirect != null && redirect.startsWith(ctx + "/")) {
			response.sendRedirect(redirect);
		} else {
			response.sendRedirect(ctx + "/pages/main.jsp");
		}
	} else {
		// 인증 실패
		response.sendRedirect(ctx + "/pages/login.jsp?error=1");
	}
%>
