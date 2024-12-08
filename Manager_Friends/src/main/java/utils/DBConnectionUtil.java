package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionUtil {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/manager_friends";
    private static final String USER = "root";
    private static final String PASSWORD = "Dcmkok123";

    public static Connection getConnection() {
        try {
            // Đăng ký driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
            System.out.println("Kết nối thành công!");
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy driver JDBC: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối tới cơ sở dữ liệu: " + e.getMessage());
        }
        return null;
    }
}
