package controller;

import java.io.IOException;
import java.util.List;

import dao.CartDao;
import dto.Cart;
import dto.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// 장바구니 서블렛, GET: 장바구니 목록 얻기, POST: 수량 변경 or 삭제
@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final CartDao cartDao = new CartDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User loginUser = (User) req.getSession().getAttribute("loginUser");
		List<Cart> items = cartDao.findByUser(loginUser.getUserId());

		int total = 0;
		for (Cart c : items) {
			total += c.getSubtotal();
		}
		req.setAttribute("items", items);
		req.setAttribute("total", total);
		req.getRequestDispatcher("/pages/cart/cart.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User loginUser = (User) req.getSession().getAttribute("loginUser");
		String action = req.getParameter("action");
		long productId = parseLong(req.getParameter("productId"));

		if (productId > 0 && "update".equals(action)) {
			int qty = parseQty(req.getParameter("quantity"));
			cartDao.updateQuantity(loginUser.getUserId(), productId, qty);
		} else if (productId > 0 && "remove".equals(action)) {
			cartDao.delete(loginUser.getUserId(), productId);
		}
		resp.sendRedirect(req.getContextPath() + "/cart");
	}

	private long parseLong(String s) {
		try {
			return Long.parseLong(s);
		} catch (NumberFormatException e) {
			return 0;
		}
	}

	private int parseQty(String s) {
		try {
			int q = Integer.parseInt(s);
			return q < 1 ? 1 : q;
		} catch (NumberFormatException e) {
			return 1;
		}
	}
}
