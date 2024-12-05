package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import models.OrderDetail;

public class OrderDetailDAO {
	private Connection connection;

	public OrderDetailDAO(Connection connection) {
		this.connection = connection;
	}

	public void createOrderDetail(OrderDetail orderDetail, int orderID) {
		String sqlInsert = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)";

		try (PreparedStatement preparedStatement = connection.prepareStatement(sqlInsert)) {
			preparedStatement.setInt(1, orderID); 
			preparedStatement.setInt(2, orderDetail.getProductID());
			preparedStatement.setInt(3, orderDetail.getQuantity());
			preparedStatement.setBigDecimal(4, orderDetail.getPrice());

			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Thêm chi tiết đơn hàng thất bại: " + e.getMessage());
		}
	}
}
