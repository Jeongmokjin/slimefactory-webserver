package filter;

import java.io.IOException;

import dto.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 인증/인가 필터.
 *
 * <ul>
 *   <li><b>/admin/*</b> — 로그인 + ADMIN 권한 필요. (미인증→로그인, 권한부족→403)</li>
 *   <li><b>/mypage, /member/edit, /member/logout, /cart, /cart/*, /order/*</b>
 *       — 로그인(USER) 필요. (미인증→로그인 페이지로 리다이렉트)</li>
 * </ul>
 *
 * <p>로그인 사용자는 세션 속성 {@code loginUser}(User) 로 식별한다.</p>
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {
		"/admin/*",
		"/mypage",
		"/member/edit",
		"/member/logout",
		"/cart",
		"/cart/*",
		"/order/*"
})
public class AuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		String ctx = request.getContextPath();
		String path = request.getRequestURI().substring(ctx.length()); // 컨텍스트 제외 경로

		HttpSession session = request.getSession(false);
		User loginUser = (session != null) ? (User) session.getAttribute("loginUser") : null;

		// 1) 로그인 여부 확인
		if (loginUser == null) {
			// 로그인 후 원래 가려던 곳으로 되돌아오도록 redirect 파라미터 전달
			String target = request.getRequestURI();
			if (request.getQueryString() != null) {
				target += "?" + request.getQueryString();
			}
			response.sendRedirect(ctx + "/member/login?redirect="
					+ java.net.URLEncoder.encode(target, "UTF-8"));
			return;
		}

		// 2) /admin/* 은 ADMIN 권한까지 확인
		if (path.startsWith("/admin/") && !"ADMIN".equals(loginUser.getRole())) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN,
					"관리자 권한이 필요합니다.");
			return;
		}

		chain.doFilter(req, res);
	}
}
