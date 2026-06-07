package controller;

import java.io.IOException;

import dao.UserDao;
import dto.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.PasswordUtil;

// 로그인 서블렛
@WebServlet("/member/login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final UserDao userDao = new UserDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.getRequestDispatcher("/pages/member/login.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String userId = req.getParameter("userId");
		String password = req.getParameter("password");
		String redirect = req.getParameter("redirect");

		User user = (userId == null) ? null : userDao.findById(userId.trim());
		if (user == null || !PasswordUtil.matches(password, user.getPassword())) {
			req.setAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
			req.setAttribute("userId", userId);
			req.setAttribute("redirect", redirect);
			req.getRequestDispatcher("/pages/member/login.jsp").forward(req, resp);
			return;
		}

		// 로그인 시 기존 세션 무효화 후 새 세션 발급
		HttpSession old = req.getSession(false);
		if (old != null) {
			old.invalidate();
		}
		HttpSession session = req.getSession(true);
		user.setPassword(null); // 세션에는 비번 보관 X
		session.setAttribute("loginUser", user);

		// 이전에 가려던 곳으로 가거나 메인으로
		String safe = req.getContextPath() + "/main";
		if (redirect != null && redirect.startsWith(req.getContextPath() + "/")) {
			safe = redirect;
		}
		resp.sendRedirect(safe);
	}
}
