package dto;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 회원 DTO — DB {@code user} 테이블과 1:1 매핑.
 *
 * <pre>
 * user_id VARCHAR(100) PK / name / password(해시) / email / phone
 * role ENUM('USER','ADMIN') / created_at / deleted_at(NULL=활성)
 * </pre>
 */
public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	private String userId;        // user_id (PK, 로그인 ID)
	private String name;          // name
	private String password;      // password (SHA-256 해시 저장)
	private String email;         // email
	private String phone;         // phone
	private String role;          // role ('USER' | 'ADMIN')
	private Timestamp createdAt;  // created_at
	private Timestamp deletedAt;  // deleted_at (NULL = 활성, 값 = 탈퇴)

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

	/** ADMIN 권한 여부 편의 메서드. */
	public boolean isAdmin() {
		return "ADMIN".equals(role);
	}
}
