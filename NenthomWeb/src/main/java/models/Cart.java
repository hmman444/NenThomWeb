package models;

import java.sql.Timestamp;

public class Cart {
	private int cartID;
	private int userID;
	private int productID;
	private int quantity;
	private Timestamp createdAt;

	public Cart() {
		
	}
	
	public Cart(int userID, int productID, int quantity) {
		this.userID = userID;
		this.productID = productID;
		this.quantity = quantity;
		this.createdAt = new Timestamp(System.currentTimeMillis());
	}

	public int getCartID() {
		return cartID;
	}

	public void setCartID(int cartID) {
		this.cartID = cartID;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
}
