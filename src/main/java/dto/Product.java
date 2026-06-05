package dto;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 상품 DTO — DB {@code product} 테이블과 1:1 매핑.
 *
 * <pre>
 * product_id BIGINT PK / name VARCHAR(50) / price INT / description TEXT
 * stock INT / image_url VARCHAR(1000) / created_at DATETIME
 * </pre>
 */
public class Product implements Serializable {

	private static final long serialVersionUID = 1L;

	private long productId;       // product_id (PK, AUTO_INCREMENT)
	private String name;          // name
	private int price;            // price
	private String description;   // description (nullable)
	private int stock;            // stock
	private String imageUrl;      // image_url (nullable)
	private Timestamp createdAt;  // created_at

	public Product() {
	}

	public long getProductId() {
		return productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
}
