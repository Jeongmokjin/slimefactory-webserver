package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.User;
import util.DBUtil;


public class UserDao {

	// 활성 회원 단건 조회, 없으면 null.
	public User findById(String userId) {
		String sql = "SELECT user_id, name, password, email, phone, role, created_at, deleted_at "
				+ "FROM `user` WHERE user_id = ? AND deleted_at IS NULL";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return map(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("회원 조회 실패: " + userId, e);
		}
		return null;
	}

	// 활성 회원 ID 중복 확인
	public boolean existsById(String userId) {
		String sql = "SELECT 1 FROM `user` WHERE user_id = ? AND deleted_at IS NULL";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		} catch (SQLException e) {
			throw new RuntimeException("ID 중복확인 실패: " + userId, e);
		}
	}

	// 신규 회원 등록
	public void insert(User u) {
		String sql = "INSERT INTO `user` (user_id, name, password, email, phone, role) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, u.getUserId());
			ps.setString(2, u.getName());
			ps.setString(3, u.getPassword());
			ps.setString(4, u.getEmail());
			ps.setString(5, u.getPhone());
			ps.setString(6, (u.getRole() == null || u.getRole().isEmpty()) ? "USER" : u.getRole());
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("회원 등록 실패: " + u.getUserId(), e);
		}
	}

	// 회원 정보 수정(이름/이메일/연락처)
	public void updateProfile(User u) {
		String sql = "UPDATE `user` SET name = ?, email = ?, phone = ? "
				+ "WHERE user_id = ? AND deleted_at IS NULL";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, u.getName());
			ps.setString(2, u.getEmail());
			ps.setString(3, u.getPhone());
			ps.setString(4, u.getUserId());
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("회원 정보 수정 실패: " + u.getUserId(), e);
		}
	}

	// 비밀번호 변경
	public void updatePassword(String userId, String hashedPassword) {
		String sql = "UPDATE `user` SET password = ? WHERE user_id = ? AND deleted_at IS NULL";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, hashedPassword);
			ps.setString(2, userId);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("비밀번호 변경 실패: " + userId, e);
		}
	}

	// 회원 탈퇴(Soft delete)
	public void softDelete(String userId) {
		String sql = "UPDATE `user` SET deleted_at = NOW() "
				+ "WHERE user_id = ? AND deleted_at IS NULL";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, userId);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("회원 탈퇴 실패: " + userId, e);
		}
	}

	// 유저 조회 결과 데이터 가공
	private User map(ResultSet rs) throws SQLException {
		User u = new User();
		u.setUserId(rs.getString("user_id"));
		u.setName(rs.getString("name"));
		u.setPassword(rs.getString("password"));
		u.setEmail(rs.getString("email"));
		u.setPhone(rs.getString("phone"));
		u.setRole(rs.getString("role"));
		u.setCreatedAt(rs.getTimestamp("created_at"));
		u.setDeletedAt(rs.getTimestamp("deleted_at"));
		return u;
	}
}
