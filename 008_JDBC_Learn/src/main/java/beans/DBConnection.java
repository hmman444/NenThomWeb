package beans;

import java.sql.Connection;

public class DBConnection {
	public static Connection getConnection() {
		throws ClassNotFoundException, SQLException;
		{
			return SQLServerConnection.getConnection();
		}
	}
}
