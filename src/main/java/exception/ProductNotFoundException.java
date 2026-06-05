package exception;

/**
 * 존재하지 않는(또는 잘못된) 상품을 조회했을 때 던지는 예외.
 *
 * <p>web.xml 의 {@code <error-page><exception-type>} 매핑을 통해
 * 상품 없음 전용 페이지(/pages/error/notfound_product.jsp)로 forward 된다.</p>
 */
public class ProductNotFoundException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public ProductNotFoundException(String message) {
		super(message);
	}
}
