package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.Order;
import dto.OrderItem;
import util.DBUtil;


public class OrderDao {

	// 트랜잭션 전용(외부 Connection)

	// 주문 헤더 insert, 생성된 order_id 반환
	public long insertOrder(Connection conn, Order o) throws SQLException {
		String sql = "INSERT INTO `order` (user_id, status, total_price, address) "
				+ "VALUES (?, 'ORDERED', ?, ?)";
		try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, o.getUserId());
			ps.setInt(2, o.getTotalPrice());
			ps.setString(3, o.getAddress());
			ps.executeUpdate();
			try (ResultSet keys = ps.getGeneratedKeys()) {
				if (keys.next()) {
					return keys.getLong(1);
				}
			}
		}
		throw new SQLException("order_id 생성 실패");
	}

	// 주문 상세 insert, price 에는 주문 시점 단가 스냅샷을 저장
	public void insertOrderItem(Connection conn, long orderId, OrderItem item) throws SQLException {
		String sql = "INSERT INTO order_item (order_id, product_id, quantity, price) "
				+ "VALUES (?, ?, ?, ?)";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, orderId);
			ps.setLong(2, item.getProductId());
			ps.setInt(3, item.getQuantity());
			ps.setInt(4, item.getPrice());
			ps.executeUpdate();
		}
	}

	// 사용자의 주문 목록(최신순)
	public List<Order> findByUser(String userId) {
		String sql = "SELECT order_id, user_id, status, total_price, address, order_date "
				+ "FROM `order` WHERE user_id = ? ORDER BY order_date DESC, order_id DESC";
		List<Order> list = new ArrayList<>();
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(mapOrder(rs));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("주문 목록 조회 실패: " + userId, e);
		}
		return list;
	}

	// 주문 단건 조회(본인 확인 포함), 없으면 null
	public Order findById(long orderId, String userId) {
		String sql = "SELECT order_id, user_id, status, total_price, address, order_date "
				+ "FROM `order` WHERE order_id = ? AND user_id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, orderId);
			ps.setString(2, userId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapOrder(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("주문 조회 실패: " + orderId, e);
		}
		return null;
	}

	// 특정 주문의 상세 항목(상품명 조인)
	public List<OrderItem> findItems(long orderId) {
		String sql = "SELECT oi.order_item_id, oi.order_id, oi.product_id, oi.quantity, oi.price, "
				+ "       p.name AS product_name "
				+ "FROM order_item oi JOIN product p ON oi.product_id = p.product_id "
				+ "WHERE oi.order_id = ? ORDER BY oi.order_item_id";
		List<OrderItem> list = new ArrayList<>();
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, orderId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					OrderItem it = new OrderItem();
					it.setOrderItemId(rs.getLong("order_item_id"));
					it.setOrderId(rs.getLong("order_id"));
					it.setProductId(rs.getLong("product_id"));
					it.setQuantity(rs.getInt("quantity"));
					it.setPrice(rs.getInt("price"));
					it.setProductName(rs.getString("product_name"));
					list.add(it);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("주문 상세 조회 실패: " + orderId, e);
		}
		return list;
	}

	private Order mapOrder(ResultSet rs) throws SQLException {
		Order o = new Order();
		o.setOrderId(rs.getLong("order_id"));
		o.setUserId(rs.getString("user_id"));
		o.setStatus(rs.getString("status"));
		o.setTotalPrice(rs.getInt("total_price"));
		o.setAddress(rs.getString("address"));
		o.setOrderDate(rs.getTimestamp("order_date"));
		return o;
	}
}
