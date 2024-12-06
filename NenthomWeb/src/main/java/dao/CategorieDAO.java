package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import models.Categorie;

public class CategorieDAO {

	private Connection connection;

	public CategorieDAO(Connection connection) {
		this.connection = connection;
	}

	public List<Categorie> getAllCategories() {
		List<Categorie> categories = new ArrayList<>();
		String query = "SELECT * FROM Categories";

		try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

			while (rs.next()) {
				int categoryID = rs.getInt("CategoryID");
				String name = rs.getString("Name");
				String description = rs.getString("Description");

				Categorie categorie = new Categorie(categoryID, name, description);
				categories.add(categorie);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return categories;
	}
	
	public boolean addCategory(Categorie category) {
		boolean isAdded = false;
		String sql = "INSERT INTO Categories (Name, Description) VALUES (?, ?)";

		try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setString(1, category.getName());
			preparedStatement.setString(2, category.getDescription());

			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				System.out.println("Category added successfully.");
				isAdded = true;
			} else {
				System.out.println("Failed to add category.");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isAdded;
	}

	// Sửa danh mục
	public boolean updateCategory(Categorie category) {
		boolean isUpdated = false;
		String sql = "UPDATE Categories SET Name = ?, Description = ? WHERE CategoryID = ?";

		try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setString(1, category.getName());
			preparedStatement.setString(2, category.getDescription());
			preparedStatement.setInt(3, category.getCategoryID());

			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				System.out.println("Category updated successfully.");
				isUpdated = true;
			} else {
				System.out.println("No category found with the given ID.");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isUpdated;
	}
	
	public boolean deleteCategory(int categoryId) {
        boolean isDeleted = false;
        String sql = "DELETE FROM Categories WHERE CategoryID = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
	        preparedStatement.setInt(1, categoryId);

	        int rowsAffected = preparedStatement.executeUpdate();
	        if (rowsAffected > 0) {
	            System.out.println("Category deleted successfully.");
	        } else {
	            System.out.println("No category found with the given name.");
	        }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isDeleted;
    }
	
	public Categorie getCategoryByID(int categoryID) throws SQLException {
        Categorie category = null;
        String sql = "SELECT * FROM Categories WHERE CategoryID = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, categoryID);

            // Thực hiện truy vấn
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                // Nếu tìm thấy danh mục, tạo đối tượng Categorie
                category = new Categorie(
                        resultSet.getInt("CategoryID"),
                        resultSet.getString("Name"),
                        resultSet.getString("Description")
                );
            }
        }

        return category;
    }
	

}
