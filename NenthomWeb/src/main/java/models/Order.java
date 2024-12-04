package models;

import java.sql.Timestamp;  // Use java.sql.Timestamp
import java.util.List;
import java.math.BigDecimal;

public class Order {
    private int orderID;
    private int userID;
    private BigDecimal totalPrice;
    private String orderStatus;
    private String shippingAddress;
    private Timestamp createdAt;  // Use java.sql.Timestamp
    private String username;
    private List<OrderDetail> orderItems; // Danh sách OrderDetail

    // Getters và setters
    public int getOrderID() { return orderID; }
    public void setOrderID(int orderID) { this.orderID = orderID; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp timestamp) { this.createdAt = timestamp; }  // Corrected to Timestamp

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public List<OrderDetail> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderDetail> orderItems) { this.orderItems = orderItems; }
}
