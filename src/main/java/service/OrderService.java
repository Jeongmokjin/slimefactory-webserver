package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import dao.CartDao;
import dao.OrderDao;
import dao.ProductDao;
import dto.Cart;
import dto.Order;
import dto.OrderItem;
import exception.OutOfStockException;
import util.DBUtil;

/**
 * 주문 서비스. 주문 확정의 전 과정을 <b>하나의 트랜잭션</b>으로 처리한다.
 *
 * <ol>
 *   <li>{@code order} 헤더 insert (총액 = 장바구니 항목 합계)</li>
 *   <li>각 항목 {@code order_item} insert — price 에 <b>주문 시점 단가 스냅샷</b> 저장</li>
 *   <li>{@code product.stock} 차감 — 재고 부족 시 {@link OutOfStockException} → 전체 롤백</li>
 *   <li>주문한 상품들을 장바구니에서 제거</li>
 * </ol>
 */
public class OrderService {

	private final OrderDao orderDao = new OrderDao();
	private final ProductDao productDao = new ProductDao();
	private final CartDao cartDao = new CartDao();

	/**
	 * 장바구니 전체를 주문으로 확정한다.
	 *
	 * @param userId   주문 회원
	 * @param address  배송지
	 * @param cartItems 주문할 장바구니 항목(현재 단가/수량 포함)
	 * @return 생성된 order_id
	 * @throws OutOfStockException 재고 부족 시(롤백됨)
	 * @throws IllegalArgumentException 장바구니가 비었을 때
	 */
	public long placeOrder(String userId, String address, List<Cart> cartItems) {
		if (cartItems == null || cartItems.isEmpty()) {
			throw new IllegalArgumentException("장바구니가 비어 있어 주문할 수 없습니다.");
		}

		// 총액 = 각 항목 (단가 × 수량) 합계
		int total = 0;
		for (Cart c : cartItems) {
			total += c.getPrice() * c.getQuantity();
		}

		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false); // 트랜잭션 시작

			// 1) 주문 헤더
			Order order = new Order();
			order.setUserId(userId);
			order.setTotalPrice(total);
			order.setAddress(address);
			long orderId = orderDao.insertOrder(conn, order);

			// 2~3) 항목 insert + 재고 차감
			for (Cart c : cartItems) {
				OrderItem item = new OrderItem(c.getProductId(), c.getQuantity(), c.getPrice());
				orderDao.insertOrderItem(conn, orderId, item);

				int updated = productDao.decreaseStock(conn, c.getProductId(), c.getQuantity());
				if (updated == 0) {
					throw new OutOfStockException(
							"'" + c.getProductName() + "' 재고가 부족합니다.");
				}
			}

			// 4) 장바구니 비우기
			cartDao.clear(conn, userId);

			conn.commit(); // 모두 성공 → 확정
			return orderId;

		} catch (OutOfStockException e) {
			rollback(conn);
			throw e; // 재고 부족은 그대로 전달
		} catch (SQLException e) {
			rollback(conn);
			throw new RuntimeException("주문 처리 실패", e);
		} finally {
			close(conn);
		}
	}

	private void rollback(Connection conn) {
		if (conn != null) {
			try {
				conn.rollback();
			} catch (SQLException ignore) {
				// 롤백 실패는 무시(원래 예외를 우선)
			}
		}
	}

	private void close(Connection conn) {
		if (conn != null) {
			try {
				conn.setAutoCommit(true);
				conn.close();
			} catch (SQLException ignore) {
			}
		}
	}
}
