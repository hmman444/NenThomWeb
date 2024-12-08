package beans;

public class actBean {
	private String username;
	private String password;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public actBean() {
		super();
	}
	
	public actBean(String username, String password) {
		super();
		setUsername(username);
		setPassword(password);
	}

	public Boolean validate()
	{
		if (this.getUsername().equals("nhat") && this.getPassword().equals("1"))
		{
			return true;
		}
		return false;
	}
}
