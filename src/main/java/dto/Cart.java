package dto;

import java.io.Serializable;
import java.sql.Timestamp;

// 장바구니에 담은 품목 하나를 의미
public class Cart implements Serializable {

	private static final long serialVersionUID = 1L;

	private long cartId;          // 카트 id
	private String userId;        // 사용자 id, 이걸로 한 사용자가 담은 품목을 구별해서 모두 보여줌
	private long productId;       // 담은 제품 id
	private int quantity;         // 수량
	private Timestamp createdAt;  // 장바구니 생성 시간

	// ----- 표시용(조인) 필드: product 테이블에서 가져온 값 -----
	private String productName;   // 상품 이름
	private int price;            // 가격
	private String imageUrl;      // 이미지 url
	private int stock;            // 재고

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

	// 상품당 총 가격 (가격 × 수량)
	public int getSubtotal() {
		return price * quantity;
	}
}
