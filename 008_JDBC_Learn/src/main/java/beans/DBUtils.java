package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtils {
	public static actBean findUser(Connection conn, String username, String password) throws SQLException{
		String sql = "Select * from Account " + "where username = ? and password = ?";
		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, username);
		pstm.setString(2, password);
		ResultSet rs = pstm.executeQuery();
		while (rs.next()) {
			actBean u = new actBean(username, password);
			return u;
		}
		return null;
	}
}
