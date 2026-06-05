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

/** 상품 목록. */
@WebServlet("/products")
public class ProductListServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final ProductDao productDao = new ProductDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		List<Product> products = productDao.findAll();
		req.setAttribute("products", products);
		req.getRequestDispatcher("/pages/product/list.jsp").forward(req, resp);
	}
}
