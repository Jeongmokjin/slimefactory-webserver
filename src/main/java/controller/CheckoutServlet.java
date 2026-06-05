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

/** 주문서 작성. 장바구니 내용과 총액을 보여준다. (AuthFilter 보호) */
@WebServlet("/order/checkout")
public class CheckoutServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final CartDao cartDao = new CartDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User loginUser = (User) req.getSession().getAttribute("loginUser");
		List<Cart> items = cartDao.findByUser(loginUser.getUserId());

		if (items.isEmpty()) {
			// 빈 장바구니로는 주문서 진입 불가
			resp.sendRedirect(req.getContextPath() + "/cart?empty=1");
			return;
		}

		int total = 0;
		for (Cart c : items) {
			total += c.getSubtotal();
		}
		req.setAttribute("items", items);
		req.setAttribute("total", total);
		req.getRequestDispatcher("/pages/order/checkout.jsp").forward(req, resp);
	}
}
