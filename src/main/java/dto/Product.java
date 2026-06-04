package dto;

import java.io.Serializable;

/**
 * 슬라임 상품 자바빈즈(JavaBeans).
 * 상품 데이터를 담는 DTO로, ProductRepository(DAO)에서 사용한다.
 */
public class Product implements Serializable {

	private static final long serialVersionUID = 1L;

	private String productId;     // 상품 ID
	private String name;          // 상품명
	private int unitPrice;        // 가격
	private String description;   // 설명
	private String category;      // 분류 (기본/클리어/버터/글리터)
	private long unitsInStock;    // 재고 개수
	private String releaseDate;   // 출시일
	private String condition;     // 상태 (신상품/기본)
	private String filename;      // 이미지 파일명
	private String badge;         // 배지 (NEW / SALE / 없으면 빈 문자열)
	private String emoji;         // 사진 대체용 이모지(이미지 없을 때 플레이스홀더)
	private String tint;          // 사진판 배경 그라데이션 색상(hex)
	private int quantity;         // 장바구니 수량

	public Product() {
		super();
	}

	public Product(String productId, String name, int unitPrice) {
		this.productId = productId;
		this.name = name;
		this.unitPrice = unitPrice;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public long getUnitsInStock() {
		return unitsInStock;
	}

	public void setUnitsInStock(long unitsInStock) {
		this.unitsInStock = unitsInStock;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getBadge() {
		return badge;
	}

	public void setBadge(String badge) {
		this.badge = badge;
	}

	public String getEmoji() {
		return emoji;
	}

	public void setEmoji(String emoji) {
		this.emoji = emoji;
	}

	public String getTint() {
		return tint;
	}

	public void setTint(String tint) {
		this.tint = tint;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
