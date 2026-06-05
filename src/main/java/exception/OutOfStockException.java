package exception;

/**
 * 주문 확정 시 재고가 부족할 때 던지는 예외.
 * 주문 트랜잭션은 이 예외 발생 시 전체 롤백된다.
 */
public class OutOfStockException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public OutOfStockException(String message) {
		super(message);
	}
}
