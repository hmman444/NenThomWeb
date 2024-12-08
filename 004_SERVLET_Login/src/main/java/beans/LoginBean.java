package beans;

import java.io.Serializable;

public class LoginBean implements Serializable {
	private static final long serialVersionUID = 1L;
	private String uname;
	private String pw;

	public LoginBean() {

	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}
	
	public boolean checkValidate(String uName, String passWd) {
	    // Sử dụng equals() để so sánh giá trị của chuỗi
	    if (this.uname.equals(uName) && this.pw.equals(passWd)) {
	        return true;
	    }
	    return false;
	}
}
