package dao;

import java.util.ArrayList;

import dto.Product;

/**
 * 슬라임 상품 데이터 접근 클래스(DAO).
 * 싱글턴으로 상품 목록을 보관하고, 목록/단건 조회 메서드를 제공한다.
 */
public class ProductRepository {

	private ArrayList<Product> listOfProducts = new ArrayList<Product>();
	private static ProductRepository instance = new ProductRepository();

	public static ProductRepository getInstance() {
		return instance;
	}

	public ProductRepository() {
		Product p1 = new Product("SLM01", "말랑 베이직 슬라임", 6900);
		p1.setDescription("가장 기본이 되는 쫀득한 베이직 슬라임. 손에 달라붙지 않고 부드럽게 늘어나 처음 슬라임을 만지는 분께 딱 좋아요.");
		p1.setCategory("기본슬라임");
		p1.setUnitsInStock(120);
		p1.setReleaseDate("2025/03/01");
		p1.setCondition("기본");
		p1.setFilename("slm01.png");
		p1.setBadge("");
		p1.setEmoji("🟢");
		p1.setTint("#eafff5");

		Product p2 = new Product("SLM02", "크리스탈 클리어 슬라임", 8900);
		p2.setDescription("유리처럼 투명하게 비치는 클리어 슬라임. 톡톡 터지는 청량한 소리와 맑은 질감이 매력 포인트예요.");
		p2.setCategory("클리어");
		p2.setUnitsInStock(80);
		p2.setReleaseDate("2025/05/10");
		p2.setCondition("신상품");
		p2.setFilename("slm02.png");
		p2.setBadge("NEW");
		p2.setEmoji("💧");
		p2.setTint("#e3f6ff");

		Product p3 = new Product("SLM03", "버터 카라멜 슬라임", 9500);
		p3.setDescription("진한 카라멜 향이 솔솔, 꾸덕꾸덕 부드럽게 펴 발리는 버터 슬라임. 손도장이 예쁘게 찍혀요.");
		p3.setCategory("버터");
		p3.setUnitsInStock(60);
		p3.setReleaseDate("2025/02/14");
		p3.setCondition("기본");
		p3.setFilename("slm03.png");
		p3.setBadge("SALE");
		p3.setEmoji("🧈");
		p3.setTint("#fff4e0");

		Product p4 = new Product("SLM04", "스타더스트 글리터 슬라임", 11000);
		p4.setDescription("은하수를 담은 듯 반짝이는 글리터가 가득. 빛에 비추면 보라빛으로 일렁이는 프리미엄 슬라임이에요.");
		p4.setCategory("글리터");
		p4.setUnitsInStock(45);
		p4.setReleaseDate("2025/05/20");
		p4.setCondition("신상품");
		p4.setFilename("slm04.png");
		p4.setBadge("NEW");
		p4.setEmoji("✨");
		p4.setTint("#f3e9ff");

		Product p5 = new Product("SLM05", "민트 소다 슬라임", 7500);
		p5.setDescription("청량한 민트색에 작은 거품 비즈가 콕콕. 만질 때마다 시원한 소다 느낌이 나는 인기 슬라임.");
		p5.setCategory("기본슬라임");
		p5.setUnitsInStock(95);
		p5.setReleaseDate("2025/04/02");
		p5.setCondition("기본");
		p5.setFilename("slm05.png");
		p5.setBadge("");
		p5.setEmoji("🍬");
		p5.setTint("#eafff5");

		Product p6 = new Product("SLM06", "베리 핑크 클라우드 슬라임", 8200);
		p6.setDescription("구름처럼 폭신폭신한 클라우드 슬라임. 달콤한 베리향과 사랑스러운 핑크빛이 기분까지 말랑하게.");
		p6.setCategory("기본슬라임");
		p6.setUnitsInStock(70);
		p6.setReleaseDate("2025/04/18");
		p6.setCondition("기본");
		p6.setFilename("slm06.png");
		p6.setBadge("SALE");
		p6.setEmoji("🍭");
		p6.setTint("#ffe9f6");

		Product p7 = new Product("SLM07", "레몬 버터 슬라임", 9500);
		p7.setDescription("상큼한 레몬향이 가득한 노란 버터 슬라임. 꾸덕한 텍스처에 기분 좋은 향까지 더했어요.");
		p7.setCategory("버터");
		p7.setUnitsInStock(55);
		p7.setReleaseDate("2025/03/22");
		p7.setCondition("기본");
		p7.setFilename("slm07.png");
		p7.setBadge("");
		p7.setEmoji("🍋");
		p7.setTint("#fffbe0");

		Product p8 = new Product("SLM08", "오로라 클리어 글리터 슬라임", 12500);
		p8.setDescription("투명한 클리어 베이스 위에 오로라 글리터가 흩날리는 한정판. 각도에 따라 색이 변하는 마법 같은 슬라임.");
		p8.setCategory("글리터");
		p8.setUnitsInStock(30);
		p8.setReleaseDate("2025/05/28");
		p8.setCondition("신상품");
		p8.setFilename("slm08.png");
		p8.setBadge("NEW");
		p8.setEmoji("🌈");
		p8.setTint("#e9f0ff");

		listOfProducts.add(p1);
		listOfProducts.add(p2);
		listOfProducts.add(p3);
		listOfProducts.add(p4);
		listOfProducts.add(p5);
		listOfProducts.add(p6);
		listOfProducts.add(p7);
		listOfProducts.add(p8);
	}

	/** 전체 상품 목록을 반환한다. */
	public ArrayList<Product> getAllProducts() {
		return listOfProducts;
	}

	/** 상품 ID로 단건 상품을 조회한다. 없으면 null. */
	public Product getProductById(String productId) {
		Product productById = null;
		for (int i = 0; i < listOfProducts.size(); i++) {
			Product product = listOfProducts.get(i);
			if (product != null && product.getProductId() != null
					&& product.getProductId().equals(productId)) {
				productById = product;
				break;
			}
		}
		return productById;
	}

	/** 신규 상품을 추가한다. (상품 등록 기능에서 사용) */
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
}
