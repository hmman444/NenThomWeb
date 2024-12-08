package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dbUtils.connectDB;
import models.ThuongHieu;
import models.XeHoi;

public class XeHoiDao {
	public static List<XeHoi> dachSachXH() {
		List<XeHoi> listXH = new ArrayList<>();
		Connection db = connectDB.DB();
		String sql = "SELECT * FROM XeHoi JOIN ThuongHieu ON XeHoi.thuongHieuId = ThuongHieu.thuongHieuId";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			ResultSet rs = state.executeQuery();
			while (rs.next()) {
				XeHoi xh = new XeHoi();
				xh.setMaXH(rs.getString("maXH"));
				xh.setThuongHieuId(rs.getInt("thuongHieuId"));
				xh.setGiaBan(rs.getFloat("giaban"));
				xh.setNamXX(rs.getInt("namXX"));
				ThuongHieu th = new ThuongHieu();
				th.setThuongHieuId(rs.getInt("thuongHieuId"));
				th.setTenThuongHieu(rs.getString("tenThuongHieu"));
				xh.setThuongHieu(th);
				listXH.add(xh);
			}
			return listXH;
		} catch (Exception e) {
			System.out.println(e);
		}
		return listXH;
	}

	public static List<ThuongHieu> danhSachThuongHieu() {
		List<ThuongHieu> listTH = new ArrayList<>();
		Connection db = connectDB.DB();
		String sql = "SELECT * FROM ThuongHieu";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			ResultSet rs = state.executeQuery();
			while (rs.next()) {
				ThuongHieu th = new ThuongHieu();
				th.setThuongHieuId(rs.getInt("thuongHieuId"));
				th.setTenThuongHieu(rs.getString("tenThuongHieu"));
				listTH.add(th);
			}
			return listTH;
		} catch (Exception e) {
			System.out.println(e);
		}
		return listTH;
	}

	public static List<XeHoi> danhSachXHTheoThuongHieu(int maTH) {
		List<XeHoi> listXH = new ArrayList<>();
		Connection db = connectDB.DB();
		String sql = "SELECT * FROM XeHoi JOIN ThuongHieu ON XeHoi.thuongHieuId = ThuongHieu.thuongHieuId WHERE ThuongHieu.thuongHieuId = ?";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setInt(1, maTH);
			ResultSet rs = state.executeQuery();
			while (rs.next()) {
				XeHoi xh = new XeHoi();
				xh.setMaXH(rs.getString("maXH"));
				xh.setThuongHieuId(rs.getInt("thuongHieuId"));
				xh.setGiaBan(rs.getFloat("giaban"));
				xh.setNamXX(rs.getInt("namXX"));
				ThuongHieu th = new ThuongHieu();
				th.setThuongHieuId(rs.getInt("thuongHieuId"));
				th.setTenThuongHieu(rs.getString("tenThuongHieu"));
				xh.setThuongHieu(th);
				listXH.add(xh);
			}
			return listXH;
		} catch (Exception e) {
			System.out.println(e);
		}
		return listXH;
	}

	public static XeHoi chonXeTheoID(String Ma) {
		XeHoi xh = new XeHoi();
		Connection db = connectDB.DB();
		String sql = "SELECT * FROM XeHoi JOIN ThuongHieu ON XeHoi.thuongHieuId = ThuongHieu.thuongHieuId WHERE maXH = ?";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setString(1, Ma);
			ResultSet rs = state.executeQuery();
			while (rs.next()) {
				xh.setMaXH(rs.getString("maXH"));
				xh.setThuongHieuId(rs.getInt("thuongHieuId"));
				xh.setGiaBan(rs.getFloat("giaban"));
				xh.setNamXX(rs.getInt("namXX"));
				ThuongHieu th = new ThuongHieu();
				th.setThuongHieuId(rs.getInt("thuongHieuId"));
				th.setTenThuongHieu(rs.getString("tenThuongHieu"));
				xh.setThuongHieu(th);
			}
			return xh;
		} catch (Exception e) {
			System.out.println(e);
		}
		return xh;
	}

	public static boolean xoa(String maXH) {
		Connection db = connectDB.DB();
		String sql = "DELETE XeHoi WHERE maXH = ?";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setString(1, maXH);
			state.execute();
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}

	public static boolean sua(int idth, float gia, int namxx, String maXH) {
		Connection db = connectDB.DB();
		String sql = "UPDATE XeHoi SET thuongHieuId=?, giaban=?, namXX=? where maXH = ?";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setInt(1, idth);
			state.setFloat(2, gia);
			state.setInt(3, namxx);
			state.setString(4, maXH);
			state.execute();
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}

	public static boolean them(int idth, float gia, int namxx, String maXH) {
		Connection db = connectDB.DB();
		String sql = "INSERT INTO XeHoi VALUES(?, ?, ?,?);";
		try {
			PreparedStatement state = db.prepareStatement(sql);
			state.setString(1, maXH);
			state.setInt(2, idth);
			state.setFloat(3, gia);
			state.setInt(4, namxx);
			state.execute();
			return true;
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}

}