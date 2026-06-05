package controller;

import java.io.IOException;
import java.util.List;

import dao.OrderDao;
import dto.Order;
import dto.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** 내 정보 + 주문내역. (AuthFilter 로 로그인 보호) */
@WebServlet("/mypage")
public class MyPageServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final OrderDao orderDao = new OrderDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User loginUser = (User) req.getSession().getAttribute("loginUser");

		List<Order> orders = orderDao.findByUser(loginUser.getUserId());
		// 각 주문의 상세 항목을 함께 로딩
		for (Order o : orders) {
			o.setItems(orderDao.findItems(o.getOrderId()));
		}
		req.setAttribute("orders", orders);
		req.getRequestDispatcher("/pages/member/mypage.jsp").forward(req, resp);
	}
}
