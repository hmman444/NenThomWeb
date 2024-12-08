package beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLServerConnection {
	public static Connection getConnection() throws SQLException {
		String dbDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String dbURL = "jdbc:sqlserver://localhost:1433";
		
		String dbName = "Account";
		String dbUsername = "sa";
		String dbPassword = "1";
		String connectionURL = dbURL + ";databaseName=" + dbName + ";encrypt=true;trutServerCertificate=true";
		Connection conn = null;
		
		try {
			Class.forName(dbDriver);
			conn = DriverManager.getConnection(connectionURL, dbUsername, dbPassword);
			System.out.println("connect successfully!");
		}
		catch (Exception ex)
		{
			System.out.println("Lỗi không tìm thấy Driver!");
		}
		return conn;
	}
}

