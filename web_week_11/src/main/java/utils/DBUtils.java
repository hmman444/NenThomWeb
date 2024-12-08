package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.MonHoc;
import models.Khoa;

public class DBUtils {

	public static List<MonHoc> DanhSachMH(Connection conn) throws SQLException {
        List<MonHoc> listMH = new ArrayList<>();
        String sql = "SELECT mh.maMH, mh.tenMH, k.tenKhoa, mh.soTC FROM MonHoc mh " +
                     "INNER JOIN Khoa k ON mh.maKhoa = k.maKhoa";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            MonHoc mh = new MonHoc();
            mh.setMaMH(rs.getString("maMH"));
            mh.setTenMH(rs.getString("tenMH"));
            mh.setTenKhoa(rs.getString("tenKhoa"));
            mh.setSoTC(rs.getInt("soTC"));
            listMH.add(mh);
        }

        return listMH;
    }

    public static List<MonHoc> LocMonHocTheoMa(Connection conn, String maMH) throws SQLException {
        String sql = "SELECT mh.maMH, mh.tenMH, k.tenKhoa, mh.soTC FROM MonHoc mh " +
                     "INNER JOIN Khoa k ON mh.maKhoa = k.maKhoa WHERE mh.maMH like ' ?'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, maMH);

        ResultSet rs = ps.executeQuery();
        List<MonHoc> list = new ArrayList<>();
        while (rs.next()) {
            MonHoc mh = new MonHoc();
            mh.setMaMH(rs.getString("maMH"));
            mh.setTenMH(rs.getString("tenMH"));
            mh.setTenKhoa(rs.getString("tenKhoa"));
            mh.setSoTC(rs.getInt("soTC"));
            list.add(mh);
        }
        return list;
    }

    public static List<Khoa> getAllKhoa(Connection conn) throws SQLException {
        List<Khoa> listKhoa = new ArrayList<>();
        String sql = "SELECT MaKhoa, TenKhoa FROM Khoa";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Khoa khoa = new Khoa();
            khoa.setMaKhoa(rs.getInt("MaKhoa"));
            khoa.setTenKhoa(rs.getString("TenKhoa"));
            listKhoa.add(khoa);
        }

        return listKhoa;
    }
}
