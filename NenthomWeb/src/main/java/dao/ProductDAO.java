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
	
	public void addProduct(Product product) {
	    String sqlInsert = "INSERT INTO Products (Name, Description, Price, Stock, ImageBase64) VALUES (?, ?, ?, ?, ?)";

	    try (PreparedStatement preparedStatement = connection.prepareStatement(sqlInsert)) {
	        preparedStatement.setString(1, product.getName());
	        preparedStatement.setString(2, product.getDescription());
	        preparedStatement.setDouble(3, product.getPrice());
	        preparedStatement.setInt(4, product.getStock());
	        preparedStatement.setString(5, product.getImageBase64());

	        preparedStatement.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.println("Thêm thất bại");
	    }
	}

	public boolean updateProductByName(Product product) {
	    String sqlUpdate = "UPDATE Products SET Description = ?, Price = ?, Stock = ?, ImageBase64 = ? WHERE Name = ?";

	    try (PreparedStatement preparedStatement = connection.prepareStatement(sqlUpdate)) {
	        preparedStatement.setString(1, product.getDescription());
	        preparedStatement.setDouble(2, product.getPrice());
	        preparedStatement.setInt(3, product.getStock());
	        preparedStatement.setString(4, product.getImageBase64());
	        preparedStatement.setString(5, product.getName());

	        int rowsAffected = preparedStatement.executeUpdate();
	        return rowsAffected > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	public Product getProductByName(String name) {
	    Product product = null;
	    String sql = "SELECT ProductID, Name, Description, Price, Stock, ImageBase64 FROM Products WHERE Name = ?";

	    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
	        preparedStatement.setString(1, name);
	        try (ResultSet resultSet = preparedStatement.executeQuery()) {
	            if (resultSet.next()) {
	                int productID = resultSet.getInt("ProductID");
	                String description = resultSet.getString("Description");
	                double price = resultSet.getDouble("Price");
	                int stock = resultSet.getInt("Stock");
	                String imageBase64 = resultSet.getString("ImageBase64");

	                product = new Product(productID, name, description, price, stock, imageBase64);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return product;
	}

	public void deleteProductByName(String productName) {
	    String sql = "DELETE FROM Products WHERE Name = ?";

	    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
	        preparedStatement.setString(1, productName);  // Tên sản phẩm cần xóa

	        int rowsAffected = preparedStatement.executeUpdate();
	        if (rowsAffected > 0) {
	            System.out.println("Product deleted successfully.");
	        } else {
	            System.out.println("No product found with the given name.");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
}
