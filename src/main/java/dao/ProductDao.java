package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.Product;
import util.DBUtil;


public class ProductDao {

	// 전체 상품 목록(최신 등록순).
	public List<Product> findAll() {
		String sql = "SELECT product_id, name, price, description, stock, image_url, created_at "
				+ "FROM product ORDER BY created_at DESC, product_id DESC";
		List<Product> list = new ArrayList<>();
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(map(rs));
			}
		} catch (SQLException e) {
			throw new RuntimeException("상품 목록 조회 실패", e);
		}
		return list;
	}

	// 상품 단건 조회, 없으면 null.
	public Product findById(long productId) {
		String sql = "SELECT product_id, name, price, description, stock, image_url, created_at "
				+ "FROM product WHERE product_id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, productId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return map(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("상품 조회 실패: " + productId, e);
		}
		return null;
	}

	// 신규 상품 등록, 생성된 product_id 반환
	public long insert(Product p) {
		String sql = "INSERT INTO product (name, price, description, stock, image_url) "
				+ "VALUES (?, ?, ?, ?, ?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, p.getName());
			ps.setInt(2, p.getPrice());
			ps.setString(3, p.getDescription());
			ps.setInt(4, p.getStock());
			ps.setString(5, p.getImageUrl());
			ps.executeUpdate();
			try (ResultSet keys = ps.getGeneratedKeys()) {
				if (keys.next()) {
					return keys.getLong(1);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("상품 등록 실패: " + p.getName(), e);
		}
		return 0;
	}

	//상품 수정. image_url 이 null 이면 기존 이미지를 유지(새 이미지 미첨부 시).
	public void update(Product p) {
		StringBuilder sql = new StringBuilder(
				"UPDATE product SET name = ?, price = ?, description = ?, stock = ?");
		boolean hasImage = p.getImageUrl() != null && !p.getImageUrl().isEmpty();
		if (hasImage) {
			sql.append(", image_url = ?");
		}
		sql.append(" WHERE product_id = ?");

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql.toString())) {
			int i = 1;
			ps.setString(i++, p.getName());
			ps.setInt(i++, p.getPrice());
			ps.setString(i++, p.getDescription());
			ps.setInt(i++, p.getStock());
			if (hasImage) {
				ps.setString(i++, p.getImageUrl());
			}
			ps.setLong(i, p.getProductId());
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("상품 수정 실패: " + p.getProductId(), e);
		}
	}

	// 상품 삭제, db에 주문 기록이 있는 상품은 거부됨
	public void delete(long productId) {
		String sql = "DELETE FROM product WHERE product_id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, productId);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("상품 삭제 실패(주문 이력이 있으면 삭제 불가): " + productId, e);
		}
	}


	// 외부 Connection 사용으로 트렌젝션 적용, 성공:1 실패: 0
	public int decreaseStock(Connection conn, long productId, int quantity) throws SQLException {
		String sql = "UPDATE product SET stock = stock - ? "
				+ "WHERE product_id = ? AND stock >= ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, quantity);
			ps.setLong(2, productId);
			ps.setInt(3, quantity);
			return ps.executeUpdate();
		}
	}

	// 단건 조회 결과 데이터 쓰기 편하게 가공
	private Product map(ResultSet rs) throws SQLException {
		Product p = new Product();
		p.setProductId(rs.getLong("product_id"));
		p.setName(rs.getString("name"));
		p.setPrice(rs.getInt("price"));
		p.setDescription(rs.getString("description"));
		p.setStock(rs.getInt("stock"));
		p.setImageUrl(rs.getString("image_url"));
		p.setCreatedAt(rs.getTimestamp("created_at"));
		return p;
	}
}
