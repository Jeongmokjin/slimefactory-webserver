package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Cart;
import util.DBUtil;

public class CartDao {

	// 사용자의 장바구니 목록(상품 정보 조인)
	public List<Cart> findByUser(String userId) {
		String sql = "SELECT c.cart_id, c.user_id, c.product_id, c.quantity, c.created_at, "
				+ "       p.name, p.price, p.image_url, p.stock "
				+ "FROM cart c JOIN product p ON c.product_id = p.product_id "
				+ "WHERE c.user_id = ? ORDER BY c.created_at DESC, c.cart_id DESC";
		List<Cart> list = new ArrayList<>();
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Cart c = new Cart();
					c.setCartId(rs.getLong("cart_id"));
					c.setUserId(rs.getString("user_id"));
					c.setProductId(rs.getLong("product_id"));
					c.setQuantity(rs.getInt("quantity"));
					c.setCreatedAt(rs.getTimestamp("created_at"));
					c.setProductName(rs.getString("name"));
					c.setPrice(rs.getInt("price"));
					c.setImageUrl(rs.getString("image_url"));
					c.setStock(rs.getInt("stock"));
					list.add(c);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("장바구니 조회 실패: " + userId, e);
		}
		return list;
	}

	// 장바구니 목록 추가 + 담기
	//UNIQUE 제약 조건 때문에 중복 에러(DUPLICATE KEY)가 터지면, 멈추지 말고(ON)
	//기존에 있던 그 줄의 수량(quantity)에다가 방금 내가 새로 담은 수량만큼 더하기(+)해서 수정(UPDATE)
	public void addOrIncrease(String userId, long productId, int quantity) {
		String sql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?) "
				+ "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			ps.setLong(2, productId);
			ps.setInt(3, quantity);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("장바구니 담기 실패", e);
		}
	}

	// 수량 변경(1 이상)
	public void updateQuantity(String userId, long productId, int quantity) {
		String sql = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, quantity);
			ps.setString(2, userId);
			ps.setLong(3, productId);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("장바구니 수량 변경 실패", e);
		}
	}

	// 장바구니 항목 1건 삭제. 
	public void delete(String userId, long productId) {
		String sql = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			ps.setLong(2, productId);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("장바구니 삭제 실패", e);
		}
	}

	// 사용자의 장바구니 비우기(트랜젝션 적용), 주문 완료되면 비우는 상황
	public void clear(Connection conn, String userId) throws SQLException {
		String sql = "DELETE FROM cart WHERE user_id = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			ps.executeUpdate();
		}
	}

	// 사용자의 장바구니 비우기(독립 실행)
	public void clear(String userId) {
		try (Connection conn = DBUtil.getConnection()) {
			clear(conn, userId);
		} catch (SQLException e) {
			throw new RuntimeException("장바구니 비우기 실패: " + userId, e);
		}
	}
}
