package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import beans.ThuongHieu;
import beans.XeHoi;
import service.connectDB;

public class XeHoiDao {
	public static List<XeHoi> DS() {
		List<XeHoi> kq = new ArrayList<XeHoi>();
		Connection db = connectDB.DB();
		String sql="Select * from XeHoi join ThuongHieu on XeHoi.thuongHieuId = ThuongHieu.thuongHieuId";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			ResultSet rs = state.executeQuery();
			while(rs.next()) {
				kq.add(new XeHoi(rs.getString(1), rs.getInt(2), rs.getFloat(3), rs.getInt(4), new ThuongHieu(rs.getInt(5), rs.getString(6))));
			}
			return kq;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return kq;
	}
	
	public static List<XeHoi> DSTheoTH(int maTH) {
		List<XeHoi> kq = new ArrayList<XeHoi>();
		Connection db = connectDB.DB();
		String sql="Select * from XeHoi join ThuongHieu on XeHoi.thuongHieuId = ThuongHieu.thuongHieuId where ThuongHieu.thuongHieuId = ?";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setInt(1, maTH);
			ResultSet rs = state.executeQuery();
			while(rs.next()) {
				kq.add(new XeHoi(rs.getString(1), rs.getInt(2), rs.getFloat(3), rs.getInt(4), new ThuongHieu(rs.getInt(5), rs.getString(6))));
			}
			return kq;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return kq;
	}
	
	public static XeHoi layxe(String Ma) {
		XeHoi kq = null;
		Connection db = connectDB.DB();
		String sql="Select * from XeHoi join ThuongHieu on XeHoi.thuongHieuId = ThuongHieu.thuongHieuId where maXH = ?";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setString(1, Ma);
			ResultSet rs = state.executeQuery();
			while(rs.next()) {
				kq =new XeHoi(rs.getString(1), rs.getInt(2), rs.getFloat(3), rs.getInt(4), new ThuongHieu(rs.getInt(5), rs.getString(6)));
			}
			return kq;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return kq;
	}
	public static List<ThuongHieu> DSThuongHieu() {
		List<ThuongHieu> kq = new ArrayList<ThuongHieu>();
		Connection db = connectDB.DB();
		String sql="Select * from ThuongHieu";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			ResultSet rs = state.executeQuery();
			while(rs.next()) {
				kq.add(new ThuongHieu(rs.getInt(1), rs.getString(2)));
			}
			return kq;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return kq;
	}
	
	public static boolean Sua(int idth, float gia, int namxx, String maXH) {
		Connection db = connectDB.DB();
		String sql="update XeHoi set thuongHieuId=?, giaban=?, namXX=? where maXH = ?";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setInt(1, idth);
			state.setFloat(2, gia);
			state.setInt(3, namxx);
			state.setString(4, maXH);
			state.execute();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	
	public static boolean Them(int idth, float gia, int namxx, String maXH) {
		Connection db = connectDB.DB();
		String sql="insert into XeHoi values(?, ?, ?,?);";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setString(1, maXH);
			state.setInt(2, idth);
			state.setFloat(3, gia);
			state.setInt(4, namxx);
			state.execute();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	
	public static boolean Xoa(String maXH) {
		Connection db = connectDB.DB();
		String sql="Delete XeHoi where maXH = ?";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setString(1, maXH);
			state.execute();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
}
