package dto;

import java.io.Serializable;
import java.sql.Timestamp;


public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	private String userId;        // 유저 id
	private String name;          // 이름
	private String password;      // 비번(해시된 값)
	private String email;         // 이메일
	private String phone;         // 전번
	private String role;          // 권한
	private Timestamp createdAt;  // 가입 시점
	private Timestamp deletedAt;  // 탈퇴 시점(NULL = 아직 미탈톼)

	public User() {
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getDeletedAt() {
		return deletedAt;
	}

	public void setDeletedAt(Timestamp deletedAt) {
		this.deletedAt = deletedAt;
	}

	public boolean isAdmin() {
		return "ADMIN".equals(role);
	}
}
