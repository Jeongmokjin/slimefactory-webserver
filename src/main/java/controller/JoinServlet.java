package controller;

import java.io.IOException;
import java.util.regex.Pattern;

import dao.UserDao;
import dto.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.PasswordUtil;

// 회원가입 서블렛, GET: 회원가입 폼, POST: 회원가입 값 검사
@WebServlet("/member/join")
public class JoinServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final UserDao userDao = new UserDao();
	private static final Pattern EMAIL =
			Pattern.compile("^[\\w.+-]+@[\\w.-]+\\.[A-Za-z]{2,}$");

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.getRequestDispatcher("/pages/member/join.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String userId = trim(req.getParameter("userId"));
		String name = trim(req.getParameter("name"));
		String password = req.getParameter("password");
		String passwordConfirm = req.getParameter("passwordConfirm");
		String email = trim(req.getParameter("email"));
		String phone = trim(req.getParameter("phone"));

		String error = validate(userId, name, password, passwordConfirm, email, phone);
		if (error != null) {
			// 입력값 유지 + 에러 메시지 전달
			req.setAttribute("error", error);
			req.setAttribute("userId", userId);
			req.setAttribute("name", name);
			req.setAttribute("email", email);
			req.setAttribute("phone", phone);
			req.getRequestDispatcher("/pages/member/join.jsp").forward(req, resp);
			return;
		}

		User u = new User();
		u.setUserId(userId);
		u.setName(name);
		u.setPassword(PasswordUtil.hash(password)); // 해시 암호화
		u.setEmail(email);
		u.setPhone(phone);
		u.setRole("USER");
		userDao.insert(u);

		// 가입 완료 → 로그인 페이지로
		resp.sendRedirect(req.getContextPath() + "/member/login?joined=1");
	}

	private String validate(String userId, String name, String password,
			String passwordConfirm, String email, String phone) {
		if (isEmpty(userId) || isEmpty(name) || isEmpty(password)
				|| isEmpty(email) || isEmpty(phone)) {
			return "모든 필드를 입력해 주세요.";
		}
		if (!password.equals(passwordConfirm)) {
			return "비밀번호가 일치하지 않습니다.";
		}
		if (password.length() < 4) {
			return "비밀번호는 4자 이상이어야 합니다.";
		}
		if (!EMAIL.matcher(email).matches()) {
			return "이메일 형식이 올바르지 않습니다.";
		}
		if (userDao.existsById(userId)) {
			return "이미 사용 중인 아이디입니다.";
		}
		return null;
	}

	private boolean isEmpty(String s) {
		return s == null || s.isEmpty();
	}

	private String trim(String s) {
		return s == null ? null : s.trim();
	}
}
