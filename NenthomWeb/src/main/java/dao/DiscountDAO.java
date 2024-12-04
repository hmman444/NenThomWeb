package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import models.Discount;
import services.ConnectionUtil;

public class DiscountDAO {
	private static final String GET_ACTIVE_DISCOUNTS_QUERY = "SELECT * FROM Discounts WHERE IsActive = 1 AND GETDATE() BETWEEN StartDate AND EndDate";

	// Get list of active discounts
	public List<Discount> getActiveDiscounts() {
		List<Discount> activeDiscounts = new ArrayList<>();

		try (Connection conn = ConnectionUtil.DB();
				PreparedStatement ps = conn.prepareStatement(GET_ACTIVE_DISCOUNTS_QUERY);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				int discountID = rs.getInt("DiscountID");
				String discountName = rs.getString("DiscountName");
				String discountType = rs.getString("DiscountType");
				double discountValue = rs.getDouble("DiscountValue");
				Date startDate = rs.getDate("StartDate");
				Date endDate = rs.getDate("EndDate");
				boolean isActive = rs.getBoolean("IsActive");

				Discount discount = new Discount(discountID, discountName, discountType, discountValue, startDate,
						endDate, isActive);
				activeDiscounts.add(discount);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return activeDiscounts;
	}
	
	// Get discount by ID
    public Discount getDiscountById(int discountID) {
        Discount discount = null;
        String query = "SELECT * FROM Discounts WHERE DiscountID = ? AND IsActive = 1 AND GETDATE() BETWEEN StartDate AND EndDate";

        try (Connection conn = ConnectionUtil.DB();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, discountID);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String discountName = rs.getString("DiscountName");
                    String discountType = rs.getString("DiscountType");
                    double discountValue = rs.getDouble("DiscountValue");
                    Date startDate = rs.getDate("StartDate");
                    Date endDate = rs.getDate("EndDate");
                    boolean isActive = rs.getBoolean("IsActive");

                    discount = new Discount(discountID, discountName, discountType, discountValue, startDate, endDate, isActive);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return discount;
    }
}
