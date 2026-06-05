package dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

/**
 * 주문(헤더) DTO — DB {@code order} 테이블과 1:1 매핑. (order 는 예약어 → 쿼리에서 백틱)
 *
 * <pre>
 * order_id BIGINT PK / user_id VARCHAR(100) FK
 * status ENUM('ORDERED','SHIPPED','DONE') / total_price INT
 * address VARCHAR(1000) / order_date DATETIME
 * </pre>
 */
public class Order implements Serializable {

	private static final long serialVersionUID = 1L;

	private long orderId;         // order_id
	private String userId;        // user_id
	private String status;        // status
	private int totalPrice;       // total_price
	private String address;       // address
	private Timestamp orderDate;  // order_date

	// ----- 표시용 필드: 주문 상세 목록(order_item) -----
	private List<OrderItem> items;

	public Order() {
	}

	public long getOrderId() {
		return orderId;
	}

	public void setOrderId(long orderId) {
		this.orderId = orderId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Timestamp getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}

	public List<OrderItem> getItems() {
		return items;
	}

	public void setItems(List<OrderItem> items) {
		this.items = items;
	}
}
