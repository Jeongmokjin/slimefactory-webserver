package controller;

import java.io.IOException;

import dao.CartDao;
import dao.ProductDao;
import dto.Product;
import dto.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 장바구니 담기. (AuthFilter 로 로그인 보호 — 미로그인 시 로그인 후 복귀)
 * 같은 상품 재담기 시 CartDao 가 수량을 증가시킨다.
 */
@WebServlet("/cart/add")
public class CartAddServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final CartDao cartDao = new CartDao();
	private final ProductDao productDao = new ProductDao();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		handle(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// 상품 상세/목록에서 링크(GET)로도 담을 수 있도록 허용
		handle(req, resp);
	}

	private void handle(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		User loginUser = (User) req.getSession().getAttribute("loginUser");

		long productId;
		try {
			productId = Long.parseLong(req.getParameter("productId"));
		} catch (NumberFormatException e) {
			resp.sendRedirect(req.getContextPath() + "/products");
			return;
		}

		int qty = parseQty(req.getParameter("quantity"));

		Product p = productDao.findById(productId);
		if (p == null) {
			resp.sendRedirect(req.getContextPath() + "/products");
			return;
		}

		cartDao.addOrIncrease(loginUser.getUserId(), productId, qty);
		resp.sendRedirect(req.getContextPath() + "/cart");
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
