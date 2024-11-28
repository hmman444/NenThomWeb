package dao;

import models.Cart;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
	private Connection connection;

	public CartDAO(Connection connection) {
		this.connection = connection;
	}

	public void addToCart(Cart cart) {
		String checkSql = "SELECT * FROM Cart WHERE UserID = ? AND ProductID = ?";

		try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
			checkStmt.setInt(1, cart.getUserID());
			checkStmt.setInt(2, cart.getProductID());
			ResultSet rs = checkStmt.executeQuery();

			if (rs.next()) {
				// Nếu sản phẩm đã có trong giỏ, tăng số lượng
				int newQuantity = rs.getInt("Quantity") + cart.getQuantity();
				String updateSql = "UPDATE Cart SET Quantity = ? WHERE UserID = ? AND ProductID = ?";

				try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
					updateStmt.setInt(1, newQuantity);
					updateStmt.setInt(2, cart.getUserID());
					updateStmt.setInt(3, cart.getProductID());
					updateStmt.executeUpdate();
				}
			} else {
				// Nếu sản phẩm chưa có, thêm vào giỏ hàng
				String insertSql = "INSERT INTO Cart (UserID, ProductID, Quantity, CreatedAt) VALUES (?, ?, ?, ?)";

				try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
					insertStmt.setInt(1, cart.getUserID());
					insertStmt.setInt(2, cart.getProductID());
					insertStmt.setInt(3, cart.getQuantity());
					insertStmt.setTimestamp(4, cart.getCreatedAt());
					insertStmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Lấy danh sách các sản phẩm trong giỏ hàng của người dùng
	public List<Cart> getCartItems(int userID) {
		List<Cart> cartItems = new ArrayList<>();
		String selectSql = "SELECT * FROM Cart WHERE UserID = ?";

		try (PreparedStatement selectStmt = connection.prepareStatement(selectSql)) {
			selectStmt.setInt(1, userID);
			ResultSet rs = selectStmt.executeQuery();

			while (rs.next()) {
				int cartID = rs.getInt("CartID");
				int productID = rs.getInt("ProductID");
				int quantity = rs.getInt("Quantity");
				Timestamp createdAt = rs.getTimestamp("CreatedAt");

				Cart cart = new Cart(userID, productID, quantity);
				cart.setCartID(cartID);
				cart.setCreatedAt(createdAt);

				cartItems.add(cart);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cartItems;
	}
}
