package services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionUtil {
	public static Connection DB () {
		Connection con = null;
		String username = "2thuancr";
        String password = "Quocthuan1607";
        String nameDatabase ="NenThomDB";
        String nameLap="DESKTOP-F7JV1HP";
        //String nameLap="DESKTOP-LCVENON\\LUAAN";
        String url = "jdbc:sqlserver://"+nameLap+":1433;databaseName="+nameDatabase+";encrypt=false";
        // String url = "jdbc:sqlserver://DESKTOP-F7JV1HP:1433;databaseName=NenThomDB;encrypt=false";
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con = DriverManager.getConnection(url,username,password);
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e);
		}
		return con;
	}
}
