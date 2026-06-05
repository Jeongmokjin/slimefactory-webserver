package controller;

import java.io.File;
import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.ProductDao;
import dto.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * (ADMIN) 상품 저장 — 등록/수정 + 이미지 업로드. (AuthFilter /admin/* 보호)
 *
 * <p>cos {@link MultipartRequest} 로 multipart/form-data 를 파싱한다.
 * 업로드 이미지는 {@code webapp/resources/uploads} 아래에 저장하고,
 * DB 에는 상대경로(resources/uploads/파일명)를 image_url 로 저장한다.</p>
 */
@WebServlet("/admin/product/save")
public class AdminProductSaveServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final int MAX_SIZE = 10 * 1024 * 1024; // 10MB
	private static final String UPLOAD_DIR = "resources/uploads";

	private final ProductDao productDao = new ProductDao();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// 업로드 디렉토리(없으면 생성)
		String saveDir = getServletContext().getRealPath("/" + UPLOAD_DIR);
		File dir = new File(saveDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		// multipart 파싱 (UTF-8, 동일 파일명 충돌 시 자동 리네임)
		MultipartRequest multi = new MultipartRequest(
				req, saveDir, MAX_SIZE, "UTF-8", new DefaultFileRenamePolicy());

		String idParam = multi.getParameter("productId");
		String name = trim(multi.getParameter("name"));
		String priceStr = multi.getParameter("price");
		String stockStr = multi.getParameter("stock");
		String description = multi.getParameter("description");

		// 유효성 검사
		String error = validate(name, priceStr, stockStr);
		if (error != null) {
			req.setAttribute("error", error);
			req.getRequestDispatcher("/pages/product/form.jsp").forward(req, resp);
			return;
		}

		Product p = new Product();
		p.setName(name);
		p.setPrice(Integer.parseInt(priceStr));
		p.setStock(Integer.parseInt(stockStr));
		p.setDescription(description);

		// 업로드 파일명(없으면 null → 기존 이미지 유지)
		String uploaded = multi.getFilesystemName("image");
		if (uploaded != null) {
			p.setImageUrl(UPLOAD_DIR + "/" + uploaded);
		}

		boolean isUpdate = idParam != null && !idParam.isEmpty();
		if (isUpdate) {
			p.setProductId(Long.parseLong(idParam));
			productDao.update(p);
		} else {
			productDao.insert(p);
		}

		// 등록/수정 후 목록으로 리다이렉트
		resp.sendRedirect(req.getContextPath() + "/products");
	}

	private String validate(String name, String priceStr, String stockStr) {
		if (name == null || name.isEmpty()) {
			return "상품명을 입력해 주세요.";
		}
		int price;
		int stock;
		try {
			price = Integer.parseInt(priceStr);
			stock = Integer.parseInt(stockStr);
		} catch (NumberFormatException e) {
			return "가격과 재고는 숫자로 입력해 주세요.";
		}
		if (price < 0 || stock < 0) {
			return "가격과 재고는 0 이상이어야 합니다.";
		}
		return null;
	}

	private String trim(String s) {
		return s == null ? null : s.trim();
	}
}
