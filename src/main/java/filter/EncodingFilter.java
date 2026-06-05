package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;

/**
 * 모든 요청/응답 인코딩을 UTF-8 로 강제하는 필터.
 *
 * <p>한글 파라미터 깨짐 방지. 가장 먼저 적용되도록 모든 경로(/*)에 매핑한다.</p>
 */
@WebFilter(filterName = "EncodingFilter", urlPatterns = "/*")
public class EncodingFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// 멀티파트(파일 업로드) 요청은 cos/commons-fileupload 가 자체 인코딩을 처리하므로
		// setCharacterEncoding 이 무의미하지만, 일반 요청에는 반드시 필요하다.
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		chain.doFilter(request, response);
	}
}
