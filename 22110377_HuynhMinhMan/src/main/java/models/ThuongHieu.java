package models;

public class ThuongHieu {
	int thuongHieuId;
	String tenThuongHieu;

	public ThuongHieu() {

	}

	public ThuongHieu(int thuongHieuId, String tenThuongHieu) {
		this.thuongHieuId = thuongHieuId;
		this.tenThuongHieu = tenThuongHieu;
	}

	public int getThuongHieuId() {
		return thuongHieuId;
	}

	public void setThuongHieuId(int thuongHieuId) {
		this.thuongHieuId = thuongHieuId;
	}

	public String getTenThuongHieu() {
		return tenThuongHieu;
	}

	public void setTenThuongHieu(String tenThuongHieu) {
		this.tenThuongHieu = tenThuongHieu;
	}

}
