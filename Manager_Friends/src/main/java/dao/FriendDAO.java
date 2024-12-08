package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import models.Friend;
import utils.DBConnectionUtil;

public class FriendDAO {
	public List<Friend> getAllFriends() {
        List<Friend> friends = new ArrayList<>();
        String sql = "SELECT * FROM friends";
        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
            	Friend friend = new Friend();
            	friend.setId(rs.getInt("id"));
            	friend.setName(rs.getString("name"));
            	friend.setEmail(rs.getString("email"));
            	friend.setNumberphone(rs.getString("phone"));
            	friends.add(friend);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friends;
    }

    public void addFriend(String name, String email, String phone) {
        String sql = "INSERT INTO friends (name, email, phone) VALUES (?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
