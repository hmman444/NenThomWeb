package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductCategoryDAO {
    private Connection connection;

    public ProductCategoryDAO(Connection connection) {
        this.connection = connection;
    }

    // Kiểm tra xem danh mục đã liên kết với sản phẩm chưa
    public boolean isCategoryLinked(int productId, int categoryId) throws SQLException {
        String query = "SELECT 1 FROM ProductCategories WHERE ProductID = ? AND CategoryID = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);
            ps.setInt(2, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Nếu có kết quả, nghĩa là đã liên kết
            }
        }
    }

    // Liên kết danh mục với sản phẩm
    public void linkCategoryToProduct(int productId, int categoryId) throws SQLException {
        String query = "INSERT INTO ProductCategories (ProductID, CategoryID) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);
            ps.setInt(2, categoryId);
            ps.executeUpdate();
        }
    }
}
