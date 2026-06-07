package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import dao.CartDao;
import dao.OrderDao;
import dto.Cart;
import dto.Order;
import dto.User;
import exception.OutOfStockException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.OrderService;

// 주문 서블렛
@WebServlet("/order/place")
public class PlaceOrderServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final CartDao cartDao = new CartDao();
	private final OrderDao orderDao = new OrderDao();
	private final OrderService orderService = new OrderService();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		String address = req.getParameter("address");
		if (address == null || address.trim().isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/order/checkout?error=address");
			return;
		}

		List<Cart> items = cartDao.findByUser(loginUser.getUserId());
		if (items.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/cart?empty=1");
			return;
		}

		long orderId;
		try {
			orderId = orderService.placeOrder(loginUser.getUserId(), address.trim(), items);
		} catch (OutOfStockException e) {
			// 재고 부족 → 롤백됨. 장바구니로 돌려보내며 사유 전달.
			String msg = URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8);
			resp.sendRedirect(req.getContextPath() + "/cart?error=" + msg);
			return;
		}

		// 최근 주문번호 쿠키 기록(7일)
		Cookie cookie = new Cookie("lastOrderId", String.valueOf(orderId));
		cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
		cookie.setMaxAge(7 * 24 * 60 * 60);
		resp.addCookie(cookie);

		// 완료 페이지에 주문 정보 전달
		Order order = orderDao.findById(orderId, loginUser.getUserId());
		order.setItems(orderDao.findItems(orderId));
		req.setAttribute("order", order);
		req.getRequestDispatcher("/pages/order/complete.jsp").forward(req, resp);
	}
}
