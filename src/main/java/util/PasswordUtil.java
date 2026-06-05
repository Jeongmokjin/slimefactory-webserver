package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 비밀번호 해시 유틸리티.
 *
 * <p>평문 저장 금지 원칙에 따라 비밀번호는 항상 해시하여 저장한다.
 * 학습용 단순 구현으로 <b>SHA-256 + 고정 솔트</b>를 사용한다.</p>
 *
 * <p><b>※ 운영 환경 권장 ※</b> — 실제 서비스라면 BCrypt/Argon2 등
 * 솔트가 내장된 적응형 해시를 사용해야 한다. (이 위치를 교체하면 됨)</p>
 */
public class PasswordUtil {

	// 학습용 고정 솔트. 운영에서는 사용자별 랜덤 솔트를 별도 저장해야 한다.
	private static final String SALT = "slime-factory-2025";

	private PasswordUtil() {
	}

	/** 평문 비밀번호를 SHA-256 16진 문자열로 해시한다. */
	public static String hash(String plain) {
		if (plain == null) {
			plain = "";
		}
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] digest = md.digest((SALT + plain).getBytes(StandardCharsets.UTF_8));
			StringBuilder sb = new StringBuilder(digest.length * 2);
			for (byte b : digest) {
				sb.append(Character.forDigit((b >> 4) & 0xF, 16));
				sb.append(Character.forDigit(b & 0xF, 16));
			}
			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			throw new IllegalStateException("SHA-256 미지원 환경", e);
		}
	}

	/** 평문이 저장된 해시와 일치하는지 확인한다. */
	public static boolean matches(String plain, String hashed) {
		return hashed != null && hashed.equals(hash(plain));
	}
}
