package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import models.TaiKhoan;

public class TaiKhoanDAO {
	private Connection connection;

	public TaiKhoanDAO(Connection connection) {
		this.connection = connection;
	}

	public boolean isUsernameExist(String username) throws SQLException {
		String query = "SELECT * FROM Account WHERE Username = ?";

		try (PreparedStatement stmt = connection.prepareStatement(query)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();

			return rs.next();
		}
	}

	public String getPasswordByUsername(String username) throws SQLException {
		String query = "SELECT Password FROM Account WHERE Username = ?";

		try (PreparedStatement stmt = connection.prepareStatement(query)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getString("Password"); 
			} else {
				return null; 
			}
		}
	}

	public boolean addUser(TaiKhoan taiKhoan) throws SQLException {
	    try {
	        connection.setAutoCommit(false);

	        // Insert vào bảng Account
	        String queryAccount = "INSERT INTO Account (Username, Password) VALUES (?, ?)";
	        try (PreparedStatement stmt = connection.prepareStatement(queryAccount, Statement.RETURN_GENERATED_KEYS)) {
	            stmt.setString(1, taiKhoan.getUsername());
	            stmt.setString(2, taiKhoan.getPassword());

	            int rowsAffected = stmt.executeUpdate();

	            if (rowsAffected > 0) {
	                // Lấy AccountID vừa được insert
	                ResultSet rs = stmt.getGeneratedKeys();
	                if (rs.next()) {
	                    int accountId = rs.getInt(1);

	                    // Insert vào bảng Users
	                    String queryUser = "INSERT INTO Users (AccountID) VALUES (?)";
	                    try (PreparedStatement stmtUser = connection.prepareStatement(queryUser, Statement.RETURN_GENERATED_KEYS)) {
	                        stmtUser.setInt(1, accountId);

	                        int userRowsAffected = stmtUser.executeUpdate();

	                        if (userRowsAffected > 0) {
	                            // Lấy UserID vừa được insert
	                            ResultSet userRs = stmtUser.getGeneratedKeys();
	                            if (userRs.next()) {
	                                int userId = userRs.getInt(1);

	                                // Insert vào bảng UserRole với RoleID = 1 (Khách Hàng)
	                                String queryUserRole = "INSERT INTO UserRole (UserID, RoleID) VALUES (?, ?)";
	                                try (PreparedStatement stmtUserRole = connection.prepareStatement(queryUserRole)) {
	                                    stmtUserRole.setInt(1, userId);
	                                    stmtUserRole.setInt(2, 1); // RoleID = 1 (Khách Hàng)

	                                    int userRoleRowsAffected = stmtUserRole.executeUpdate();

	                                    if (userRoleRowsAffected > 0) {
	                                        connection.commit();
	                                        return true;
	                                    } else {
	                                        connection.rollback();
	                                        return false;
	                                    }
	                                }
	                            }
	                        }
	                    }
	                }
	            }
	        }
	        connection.rollback();
	        return false;
	    } catch (SQLException e) {
	        connection.rollback();
	        throw e;
	    } finally {
	        connection.setAutoCommit(true);
	    }
	}
	
	public String getRoleByUsername(String username) {
	    String query = "SELECT r.Code FROM UserRole ur "
	                 + "JOIN Role r ON ur.RoleID = r.RoleID "
	                 + "JOIN Users u ON ur.UserID = u.UserID "
	                 + "JOIN Account a ON u.AccountID = a.AccountID "
	                 + "WHERE a.Username = ?";
	    
	    try (PreparedStatement stmt = connection.prepareStatement(query)) {
	        stmt.setString(1, username);
	        ResultSet rs = stmt.executeQuery();
	        
	        if (rs.next()) {
	            return rs.getString("Code"); // Trả về vai trò (ví dụ: 'manager' hoặc 'user')
	        } else {
	            return null; // Không tìm thấy vai trò, trả về null
	        }
	    } catch (SQLException e) {
	        // Xử lý ngoại lệ SQL nếu có lỗi xảy ra
	        e.printStackTrace();
	        return null; // Trả về null nếu có lỗi xảy ra
	    }
	}
}
