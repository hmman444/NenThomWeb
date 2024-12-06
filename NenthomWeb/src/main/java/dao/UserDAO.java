package dao;

import models.User;
import java.sql.*;

public class UserDAO {
	private Connection connection;

	public UserDAO(Connection connection) {
		this.connection = connection;
	}

	// Lấy thông tin người dùng theo userId
	public User getUserById(int userId) {
		String selectSql = "SELECT * FROM Users WHERE UserId = ?";
		User user = null;

		try (PreparedStatement selectStmt = connection.prepareStatement(selectSql)) {
			selectStmt.setInt(1, userId);
			ResultSet rs = selectStmt.executeQuery();

			if (rs.next()) {
				int accountId = rs.getInt("AccountId");
				String email = rs.getString("Email");
				String phoneNumber = rs.getString("PhoneNumber");
				String address = rs.getString("Address");

				user = new User(userId, accountId, email, phoneNumber, address);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}

	// Thêm người dùng mới
	public void addUser(User user) {
		String insertSql = "INSERT INTO Users (UserId, AccountId, Email, PhoneNumber, Address) VALUES (?, ?, ?, ?, ?)";

		try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
			insertStmt.setInt(1, user.getUserId());
			insertStmt.setInt(2, user.getAccountId());
			insertStmt.setString(3, user.getEmail());
			insertStmt.setString(4, user.getPhoneNumber());
			insertStmt.setString(5, user.getAddress());
			insertStmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Cập nhật thông tin người dùng
	public boolean updateUser(User user) {
	    String updateSql = "UPDATE Users SET Email = ?, PhoneNumber = ?, Address = ? WHERE UserId = ?";

	    try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
	        updateStmt.setString(1, user.getEmail());
	        updateStmt.setString(2, user.getPhoneNumber());
	        updateStmt.setString(3, user.getAddress());
	        updateStmt.setInt(4, user.getUserId());

	        int rowsUpdated = updateStmt.executeUpdate();
	        return rowsUpdated > 0; // Trả về true nếu có ít nhất một dòng được cập nhật
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false; // Trả về false nếu có lỗi xảy ra
	    }
	}

	// Xóa người dùng
	public void deleteUser(int userId) {
		String deleteSql = "DELETE FROM Users WHERE UserId = ?";

		try (PreparedStatement deleteStmt = connection.prepareStatement(deleteSql)) {
			deleteStmt.setInt(1, userId);
			deleteStmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int getUserIDByUsername(String username) throws SQLException {
	    String query = "SELECT u.UserID FROM Users u " +
	                   "JOIN Account a ON u.AccountID = a.AccountID " +
	                   "WHERE a.Username = ?";

	    try (PreparedStatement stmt = connection.prepareStatement(query)) {
	        stmt.setString(1, username);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt("UserID");
	        } else {
	            throw new SQLException("Không tìm thấy UserID cho username: " + username);
	        }
	    }
	}
}
