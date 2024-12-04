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
}
