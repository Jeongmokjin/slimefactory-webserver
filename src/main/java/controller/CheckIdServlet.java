package controller;

import java.io.IOException;

import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 아이디 중복확인(AJAX). 응답 본문: "available" 또는 "taken".
 */
@WebServlet("/member/check-id")
public class CheckIdServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final UserDao userDao = new UserDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String userId = req.getParameter("userId");
		resp.setContentType("text/plain; charset=UTF-8");
		boolean taken = userId != null && !userId.trim().isEmpty()
				&& userDao.existsById(userId.trim());
		resp.getWriter().write(taken ? "taken" : "available");
	}
}
