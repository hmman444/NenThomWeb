package beans;

public class XeHoi {
	String maXH;
	int thuongHieuId;
	float giaBan;
	int namXX;
	ThuongHieu thuongHieu;

	public String getMaXH() {
		return maXH;
	}

	public void setMaXH(String maXH) {
		this.maXH = maXH;
	}

	public int getThuongHieuId() {
		return thuongHieuId;
	}

	public void setThuongHieuId(int thuongHieuId) {
		this.thuongHieuId = thuongHieuId;
	}

	public float getGiaBan() {
		return giaBan;
	}

	public void setGiaBan(float giaBan) {
		this.giaBan = giaBan;
	}

	public int getNamXX() {
		return namXX;
	}

	public void setNamXX(int namXX) {
		this.namXX = namXX;
	}

	public ThuongHieu getThuongHieu() {
		return thuongHieu;
	}

	public void setThuongHieu(ThuongHieu thuongHieu) {
		this.thuongHieu = thuongHieu;
	}

	public XeHoi(String maXH, int thuongHieuId, float giaBan, int namXX, ThuongHieu thuongHieu) {
		this.maXH = maXH;
		this.thuongHieuId = thuongHieuId;
		this.giaBan = giaBan;
		this.namXX = namXX;
		this.thuongHieu = thuongHieu;
	}
}
