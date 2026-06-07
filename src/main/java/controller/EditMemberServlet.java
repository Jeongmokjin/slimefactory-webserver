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

// 정보 수정 서블렛
@WebServlet("/member/edit")
public class EditMemberServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final UserDao userDao = new UserDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.getRequestDispatcher("/pages/member/edit.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		String action = req.getParameter("action");

		if ("withdraw".equals(action)) {
			// 탈퇴 = Soft delete. 장바구니 정리 후 세션 종료.
			new dao.CartDao().clear(loginUser.getUserId());
			userDao.softDelete(loginUser.getUserId());
			session.invalidate();
			resp.sendRedirect(req.getContextPath() + "/main?withdraw=1");
			return;
		}

		// 정보수정
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String newPassword = req.getParameter("newPassword");

		User u = new User();
		u.setUserId(loginUser.getUserId());
		u.setName(name != null ? name.trim() : loginUser.getName());
		u.setEmail(email != null ? email.trim() : loginUser.getEmail());
		u.setPhone(phone != null ? phone.trim() : loginUser.getPhone());
		userDao.updateProfile(u);

		if (newPassword != null && !newPassword.isEmpty()) {
			userDao.updatePassword(loginUser.getUserId(), PasswordUtil.hash(newPassword));
		}

		// 세션의 표시정보 갱신
		loginUser.setName(u.getName());
		loginUser.setEmail(u.getEmail());
		loginUser.setPhone(u.getPhone());
		session.setAttribute("loginUser", loginUser);

		resp.sendRedirect(req.getContextPath() + "/mypage?updated=1");
	}
}
