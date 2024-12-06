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
    
    private static final String ADD_DISCOUNT_QUERY = "INSERT INTO Discounts (DiscountName, DiscountType, DiscountValue, StartDate, EndDate, IsActive) VALUES (?, ?, ?, ?, ?, 1)";
    private static final String UPDATE_DISCOUNT_QUERY = "UPDATE Discounts SET DiscountName = ?, DiscountType = ?, DiscountValue = ?, StartDate = ?, EndDate = ? WHERE DiscountID = ?";
    private static final String DELETE_DISCOUNT_QUERY = "DELETE FROM Discounts WHERE DiscountID = ?";

    // Add a new discount
    public boolean addDiscount(Discount discount) {
        try (Connection conn = ConnectionUtil.DB();
             PreparedStatement ps = conn.prepareStatement(ADD_DISCOUNT_QUERY)) {
            ps.setString(1, discount.getDiscountName());
            ps.setString(2, discount.getDiscountType());
            ps.setDouble(3, discount.getDiscountValue());
            ps.setDate(4, discount.getStartDate());
            ps.setDate(5, discount.getEndDate());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update an existing discount
    public boolean updateDiscount(Discount discount) {
        try (Connection conn = ConnectionUtil.DB();
             PreparedStatement ps = conn.prepareStatement(UPDATE_DISCOUNT_QUERY)) {
            ps.setString(1, discount.getDiscountName());
            ps.setString(2, discount.getDiscountType());
            ps.setDouble(3, discount.getDiscountValue());
            ps.setDate(4, discount.getStartDate());
            ps.setDate(5, discount.getEndDate());
            ps.setInt(6, discount.getDiscountID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete a discount by ID
    public boolean deleteDiscount(int discountID) {
        try (Connection conn = ConnectionUtil.DB();
             PreparedStatement ps = conn.prepareStatement(DELETE_DISCOUNT_QUERY)) {
            ps.setInt(1, discountID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
