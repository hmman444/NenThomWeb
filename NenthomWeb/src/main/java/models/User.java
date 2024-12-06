package models;

public class User {
	private int userId;
	private int accountId;
	private String email;
	private String phoneNumber;
	private String address;

	public User() {

	}

	public User(int userId, int accountId, String email, String phoneNumber, String address) {
		this.userId = userId;
		this.accountId = accountId;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.address = address;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getAccountId() {
		return accountId;
	}

	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
}
