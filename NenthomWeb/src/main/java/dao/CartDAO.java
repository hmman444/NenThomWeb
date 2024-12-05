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
	
	// Cập nhật thông tin giỏ hàng của sản phẩm
    public void updateCartItem(Cart cartItem) {
        String sql = "UPDATE cart SET quantity = ? WHERE userId = ? AND productId = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, cartItem.getQuantity());
            statement.setInt(2, cartItem.getUserID());
            statement.setInt(3, cartItem.getProductID());
            int rowsAffected = statement.executeUpdate();
            
            if (rowsAffected == 0) {
                throw new SQLException("Không tìm thấy sản phẩm để cập nhật.");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật giỏ hàng: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Lấy thông tin giỏ hàng của người dùng cho sản phẩm cụ thể
    public Cart getCartItem(int userId, int productId) {
        String sql = "SELECT * FROM cart WHERE userId = ? AND productId = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            statement.setInt(2, productId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    Cart cartItem = new Cart();
                    cartItem.setUserID(rs.getInt("userId"));
                    cartItem.setProductID(rs.getInt("productId"));
                    cartItem.setQuantity(rs.getInt("quantity"));
                    return cartItem;
                } else {
                    System.err.println("Không tìm thấy sản phẩm trong giỏ hàng.");
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy thông tin giỏ hàng: " + e.getMessage());
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy sản phẩm trong giỏ hàng
    }
    
    public void clearCart(int userId) {
        String sql = "DELETE FROM Cart WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        }
        catch (SQLException e) {
            System.err.println("Lỗi khi xóa giỏ hàng: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
