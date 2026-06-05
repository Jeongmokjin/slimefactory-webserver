package dto;

import java.io.Serializable;

/**
 * 주문 상세 DTO — DB {@code order_item} 테이블과 1:1 매핑.
 *
 * <pre>
 * order_item_id BIGINT PK / order_id FK / product_id FK
 * quantity INT / price INT (주문 시점 가격 스냅샷)
 * </pre>
 */
public class OrderItem implements Serializable {

	private static final long serialVersionUID = 1L;

	private long orderItemId;     // order_item_id
	private long orderId;         // order_id
	private long productId;       // product_id
	private int quantity;         // quantity
	private int price;            // price (주문 시점 단가 스냅샷)

	// ----- 표시용(조인) 필드 -----
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

	/** 항목 소계(스냅샷 단가 × 수량). */
	public int getSubtotal() {
		return price * quantity;
	}
}
