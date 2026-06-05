package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * JDBC 연결 유틸리티.
 *
 * <p>슬라임 팩토리는 순수 JDBC만 사용하므로, 모든 DAO는 이 클래스의
 * {@link #getConnection()} 으로 Connection 을 얻어 try-with-resources 로 닫는다.</p>
 *
 * <p><b>※ DB 접속정보 수정 위치 ※</b> — 아래 네 상수를 자신의 환경에 맞게 바꾼다.
 * (현재값: localhost:3306 / slimedb / root / 1234)</p>
 */
public class DBUtil {

	// ===== 여기만 환경에 맞게 수정 =====
	private static final String URL =
			"jdbc:mysql://localhost:3306/slimedb"
			+ "?useSSL=false&serverTimezone=Asia/Seoul&characterEncoding=UTF-8";
	private static final String USER = "root";
	private static final String PASSWORD = "wjdahrwls@1028";
	// ==================================

	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

	static {
		// mysql-connector-j 드라이버를 한 번만 로드한다.
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			throw new ExceptionInInitializerError(
					"MySQL JDBC 드라이버를 찾을 수 없습니다. WEB-INF/lib 의 mysql-connector-j 확인. " + e);
		}
	}

	private DBUtil() {
		// 인스턴스화 금지 (유틸리티 클래스)
	}

	/** 새 DB Connection 을 반환한다. 사용 측에서 반드시 close 할 것(try-with-resources 권장). */
	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}
}
