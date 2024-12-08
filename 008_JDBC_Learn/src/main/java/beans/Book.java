package beans;

public class Book {
	private String code;
	private String description;
	private int price;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	public Book(String code, String description, int price) {
		super();
		setCode(code);
		setDescription(description);
		setPrice(price);
	}
}
