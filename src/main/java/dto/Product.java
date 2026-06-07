package dto;

import java.io.Serializable;
import java.sql.Timestamp;


public class Product implements Serializable {

	private static final long serialVersionUID = 1L;

	private long productId;       // 상품 id
	private String name;          // 이름
	private int price;            // 가격
	private String description;   // 설명
	private int stock;            // 재고
	private String imageUrl;      // 이미지 url
	private Timestamp createdAt;  // 생성시간

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
