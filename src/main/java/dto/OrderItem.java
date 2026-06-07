package dto;

import java.io.Serializable;

public class OrderItem implements Serializable {

	private static final long serialVersionUID = 1L;

	private long orderItemId;     // 주문 상세 품목 id
	private long orderId;         // 주문 id
	private long productId;       // 상품 id
	private int quantity;         // 주문 수량
	private int price;            // 가격 (주문 시점 가격)

	// 표시용(조인) 필드 
	private String productName;   // 상품명

	public OrderItem() {
	}

	public OrderItem(long productId, int quantity, int price) {
		this.productId = productId;
		this.quantity = quantity;
		this.price = price;
	}

	public long getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(long orderItemId) {
		this.orderItemId = orderItemId;
	}

	public long getOrderId() {
		return orderId;
	}

	public void setOrderId(long orderId) {
		this.orderId = orderId;
	}

	public long getProductId() {
		return productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	// 항목 소계(주문시 가격 × 수량)
	public int getSubtotal() {
		return price * quantity;
	}
}
