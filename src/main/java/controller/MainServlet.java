package controller;

import java.io.IOException;
import java.util.List;

import dao.ProductDao;
import dto.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 시작 페이지. 최신 상품을 함께 실어 main.jsp 로 forward 한다.
 * (접속 시간은 footer.jsp 에서 출력)
 */
@WebServlet("/main")
public class MainServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final ProductDao productDao = new ProductDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		List<Product> products = productDao.findAll();
		req.setAttribute("products", products);
		req.getRequestDispatcher("/pages/main.jsp").forward(req, resp);
	}
}
