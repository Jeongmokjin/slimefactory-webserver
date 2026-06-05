package controller;

import java.io.IOException;

import dao.ProductDao;
import dto.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * (ADMIN) 상품 등록/수정 폼. id 파라미터가 있으면 수정, 없으면 신규 등록 폼.
 * (AuthFilter /admin/* 보호)
 */
@WebServlet("/admin/product/form")
public class AdminProductFormServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final ProductDao productDao = new ProductDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idParam = req.getParameter("id");
		if (idParam != null && !idParam.isEmpty()) {
			try {
				Product product = productDao.findById(Long.parseLong(idParam));
				req.setAttribute("product", product); // 수정 모드
			} catch (NumberFormatException ignore) {
				// 잘못된 id → 신규 등록 폼으로 처리
			}
		}
		req.getRequestDispatcher("/pages/product/form.jsp").forward(req, resp);
	}
}
