package exception;

// 재고 부족시 예외 처리
public class OutOfStockException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public OutOfStockException(String message) {
		super(message);
	}
}
