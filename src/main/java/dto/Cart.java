package dto;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 장바구니 항목 DTO — DB {@code cart} 테이블과 1:1 매핑.
 *
 * <pre>
 * cart_id BIGINT PK / user_id VARCHAR(100) FK / product_id BIGINT FK
 * quantity INT / created_at DATETIME
 * UNIQUE(user_id, product_id) — 같은 상품 재담기 시 수량 증가
 * </pre>
 *
 * <p>장바구니 화면 표시를 위해 조인된 상품 정보(name/price/imageUrl/stock)를
 * 함께 담는 보조 필드를 둔다. (테이블에는 없는 표시용 값)</p>
 */
public class Cart implements Serializable {

	private static final long serialVersionUID = 1L;

	private long cartId;          // cart_id
	private String userId;        // user_id
	private long productId;       // product_id
	private int quantity;         // quantity
	private Timestamp createdAt;  // created_at

	// ----- 표시용(조인) 필드: product 테이블에서 가져온 값 -----
	private String productName;   // 상품명
	private int price;            // 단가
	private String imageUrl;      // 이미지
	private int stock;            // 현재 재고

	public Cart() {
	}

	public long getCartId() {
		return cartId;
	}

	public void setCartId(long cartId) {
		this.cartId = cartId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	/** 항목 소계(단가 × 수량). */
	public int getSubtotal() {
		return price * quantity;
	}
}
