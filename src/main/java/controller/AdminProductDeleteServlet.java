package controller;

import java.io.IOException;

import dao.ProductDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** (ADMIN) 상품 삭제 → 관리 목록으로. (AuthFilter /admin/* 보호) */
@WebServlet("/admin/product/delete")
public class AdminProductDeleteServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final ProductDao productDao = new ProductDao();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String idParam = req.getParameter("id");
		try {
			productDao.delete(Long.parseLong(idParam));
			resp.sendRedirect(req.getContextPath() + "/admin/product/manage?deleted=1");
		} catch (NumberFormatException e) {
			resp.sendRedirect(req.getContextPath() + "/admin/product/manage");
		} catch (RuntimeException e) {
			// 주문 이력(FK RESTRICT) 등으로 삭제 불가
			resp.sendRedirect(req.getContextPath() + "/admin/product/manage?error=inuse");
		}
	}
}
