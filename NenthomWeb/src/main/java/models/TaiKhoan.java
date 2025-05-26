package models;

import jakarta.validation.constraints.*;

public class TaiKhoan {
	@Pattern(regexp = "^[a-zA-Z0-9]{5,20}$", message = "Tên đăng nhập chỉ chứa chữ, số và dài 5-20 ký tự")
	private String username;

	@Size(min = 8, message = "Mật khẩu phải ít nhất 8 ký tự")
	@Pattern(regexp = ".*[A-Z].*", message = "Mật khẩu phải chứa ít nhất một chữ in hoa")
	@Pattern(regexp = ".*[a-z].*", message = "Mật khẩu phải chứa ít nhất một chữ thường")
	@Pattern(regexp = ".*\\d.*", message = "Mật khẩu phải chứa ít nhất một chữ số")
	@Pattern(regexp = ".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*", message = "Mật khẩu phải chứa ít nhất một ký tự đặc biệt")
	private String password;

	public TaiKhoan(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
