package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import models.Product;

public class ProductDAO {
	private Connection connection;

	public ProductDAO(Connection connection) {
		this.connection = connection;
	}

	public List<Product> getAllProducts() {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT ProductID, Name, Description, Price, Stock, ImageBase64 FROM Products";

		try (Statement statement = connection.createStatement(); ResultSet resultSet = statement.executeQuery(sql)) {

			while (resultSet.next()) {
				int productID = resultSet.getInt("ProductID");
				String name = resultSet.getString("Name");
				String description = resultSet.getString("Description");
				double price = resultSet.getDouble("Price");
				int stock = resultSet.getInt("Stock");
				String imageBase64 = resultSet.getString("ImageBase64");

				Product product = new Product(productID, name, description, price, stock, imageBase64);
				products.add(product);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return products;
	}
	
	// Lấy thông tin sản phẩm theo ID
    public Product getProductById(int productId) {
        Product product = null;
        String sql = "SELECT ProductID, Name, Description, Price, Stock, ImageBase64 FROM Products WHERE ProductID = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, productId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("ProductID");
                String name = resultSet.getString("Name");
                String description = resultSet.getString("Description");
                double price = resultSet.getDouble("Price");
                int stock = resultSet.getInt("Stock");
                String imageBase64 = resultSet.getString("ImageBase64");

                product = new Product(id, name, description, price, stock, imageBase64);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }
    
    public List<Product> searchProducts(String searchQuery, String category, String priceRange) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.ProductID, p.Name, p.Description, p.Price, p.Stock, p.ImageBase64 " +
            "FROM Products p " +
            "JOIN ProductCategories pc ON p.ProductID = pc.ProductID " +
            "JOIN Categories c ON pc.CategoryID = c.CategoryID " +
            "WHERE 1=1");

        // Tạo động phần điều kiện tìm kiếm theo searchQuery
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND p.Name LIKE ?");
        }

        // Thêm điều kiện lọc theo category nếu có
        if (category == null || category.isEmpty() || category.equals("all")) {
            // Nếu category là "all" hoặc chuỗi rỗng, nghĩa là không lọc theo danh mục
            sql.append(" AND 1=1");  // Hoặc bỏ qua phần này trong SQL
        } else {
            sql.append(" AND c.CategoryID = ?");
        }

        // Thêm điều kiện lọc theo price range nếu có
        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.equals("1")) {
                sql.append(" AND p.Price < 10");
            } else if (priceRange.equals("2")) {
                sql.append(" AND p.Price BETWEEN 11 AND 25");
            } else if (priceRange.equals("3")) {
                sql.append(" AND p.Price BETWEEN 26 AND 49");
            } else if (priceRange.equals("4")) {
                sql.append(" AND p.Price > 50");
            }
        }

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            // Set tham số cho searchQuery
            if (searchQuery != null && !searchQuery.isEmpty()) {
                preparedStatement.setString(paramIndex++, "%" + searchQuery + "%");
            }

            // Set tham số cho category
            if (category != null && !category.isEmpty()) {
                preparedStatement.setString(paramIndex++, category);
            }

            // Execute query và trả về kết quả
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int productID = resultSet.getInt("ProductID");
                    String name = resultSet.getString("Name");
                    String description = resultSet.getString("Description");
                    double price = resultSet.getDouble("Price");
                    int stock = resultSet.getInt("Stock");
                    String imageBase64 = resultSet.getString("ImageBase64");

                    Product product = new Product(productID, name, description, price, stock, imageBase64);
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
