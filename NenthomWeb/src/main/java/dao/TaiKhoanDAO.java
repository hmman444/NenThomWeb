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

			String queryAccount = "INSERT INTO Account (Username, Password) VALUES (?, ?)";
			try (PreparedStatement stmt = connection.prepareStatement(queryAccount, Statement.RETURN_GENERATED_KEYS)) {
				stmt.setString(1, taiKhoan.getUsername());
				stmt.setString(2, taiKhoan.getPassword());

				int rowsAffected = stmt.executeUpdate();

				if (rowsAffected > 0) {
					ResultSet rs = stmt.getGeneratedKeys();
					if (rs.next()) {
						int accountId = rs.getInt(1);

						String queryUser = "INSERT INTO Users (AccountID) VALUES (?)";
						try (PreparedStatement stmtUser = connection.prepareStatement(queryUser)) {
							stmtUser.setInt(1, accountId);

							int userRowsAffected = stmtUser.executeUpdate();

							if (userRowsAffected > 0) {
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
			connection.rollback();
			return false;
		} catch (SQLException e) {
			connection.rollback();
			throw e;
		} finally {
			connection.setAutoCommit(true);
		}
	}
}
