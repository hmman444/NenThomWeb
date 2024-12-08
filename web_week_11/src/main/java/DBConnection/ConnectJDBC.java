package DBConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import models.MonHoc;

public class ConnectJDBC {
	private final String serverName = "localhost\\SQLEXPRESS01";
	private final String dbName = "LTWeb_MonHoc";
	private final String portNumber = "1433";
	private final String username = "sa";
	private final String password = "123456";



	public Connection getConnection() throws Exception {
		String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";encrypt=false;databaseName=" + dbName;
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		return DriverManager.getConnection(url, username, password);
	}
	public static void main(String[] args) {
	    ConnectJDBC connectJDBC = new ConnectJDBC();
	    try (Connection conn = connectJDBC.getConnection()) {
	        System.out.println("Kết nối thành công!");

	        String sql = "Select mh.maMH, mh.tenMH, k.tenKhoa, mh.soTC from MonHoc as mh inner join Khoa as k on mh.maKhoa = k.makhoa";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	        	MonHoc mh = new MonHoc();
    			mh.setMaMH(rs.getString("maMH"));
    			mh.setTenMH(rs.getString("tenMH"));
    			mh.setTenKhoa(rs.getString("tenKhoa"));
    			mh.setSoTC(rs.getInt("soTC"));
    			System.out.println("Ma MH: " + mh.getMaMH() + ", Ten MH: " + mh.getTenMH() + ", Ten Khoa: " + mh.getTenKhoa() + ", So Tin chi: " + mh.getSoTC());
	        }
	    } catch (Exception e) {
	        System.out.println("Lỗi kết nối: " + e.getMessage());
	        e.printStackTrace();
	    }
	}
}
