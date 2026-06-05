package controller;

import java.io.IOException;

import dao.ProductDao;
import dto.Product;
import exception.ProductNotFoundException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 상품 상세. id 파라미터가 없거나 존재하지 않는 상품이면
 * {@link ProductNotFoundException} → web.xml 매핑으로 상품없음 페이지로 forward.
 */
@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final ProductDao productDao = new ProductDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idParam = req.getParameter("id");
		long id;
		try {
			id = Long.parseLong(idParam);
		} catch (NumberFormatException e) {
			throw new ProductNotFoundException("잘못된 상품 번호: " + idParam);
		}

		Product product = productDao.findById(id);
		if (product == null) {
			throw new ProductNotFoundException("존재하지 않는 상품: " + id);
		}

		req.setAttribute("product", product);
		req.getRequestDispatcher("/pages/product/detail.jsp").forward(req, resp);
	}
}
