package models;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;

public class Product {
	private int productID;
	private String name;
	private String description;
	private double price;
	private int stock;
	private String imageBase64;

	public Product(int productID, String name, String description, double price, int stock, String imageBase64) {
		this.productID = productID;
		this.name = name;
		this.description = description;
		this.price = price;
		this.stock = stock;
		this.imageBase64 = imageBase64;
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getImageBase64() {
		return imageBase64;
	}

	public void setImageBase64(String imageBase64) {
		this.imageBase64 = imageBase64;
	}
	
	public String encodeImageToBase64(String imagePath) {
	    File file = new File(imagePath);
	    try (FileInputStream fileInputStream = new FileInputStream(file)) {
	        byte[] imageBytes = new byte[(int) file.length()];
	        fileInputStream.read(imageBytes);
	        
	        // Chuyển đổi byte[] thành Base64
	        return Base64.getEncoder().encodeToString(imageBytes);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	public boolean decodeBase64ToImage(String base64String, String imagePath) {
	    try {
	        // Chuyển chuỗi Base64 thành mảng byte
	        byte[] imageBytes = Base64.getDecoder().decode(base64String);

	        // Ghi mảng byte vào tệp hình ảnh
	        try (FileOutputStream fileOutputStream = new FileOutputStream(new File(imagePath))) {
	            fileOutputStream.write(imageBytes);
	        }
	        return true;
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
}
