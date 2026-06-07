package dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;


public class Order implements Serializable {

	private static final long serialVersionUID = 1L;

	private long orderId;         // 주문 id
	private String userId;        // 사용자 id
	private String status;        // 주문 상태
	private int totalPrice;       // 총 금액
	private String address;       // 배송지
	private Timestamp orderDate;  // 주문 날짜

	// 표시용 필드: 주문 상세 목록(order_item)
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
