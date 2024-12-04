package dao;

import models.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    private Connection connection;

    public CategoryDAO(Connection connection) {
        this.connection = connection;
    }

    // Lấy tất cả các danh mục
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, Name, Description FROM Categories";

        try (Statement statement = connection.createStatement(); 
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                int categoryID = resultSet.getInt("CategoryID");
                String name = resultSet.getString("Name");
                String description = resultSet.getString("Description");

                Category category = new Category(categoryID, name, description);
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
}
