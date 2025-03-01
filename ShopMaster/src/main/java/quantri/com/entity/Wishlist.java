package quantri.com.entity;

public class Wishlist {
	public int idlist;
	public Sanpham sanpham;
	public Taikhoan taikhoan;
	public Wishlist() {
		super();
	}
	public Wishlist(int idlist, Sanpham sanpham, Taikhoan taikhoan) {
		super();
		this.idlist = idlist;
		this.sanpham = sanpham;
		this.taikhoan = taikhoan;
	}
	public int getIdlist() {
		return idlist;
	}
	public void setIdlist(int idlist) {
		this.idlist = idlist;
	}
	public Sanpham getSanpham() {
		return sanpham;
	}
	public void setSanpham(Sanpham sanpham) {
		this.sanpham = sanpham;
	}
	public Taikhoan getTaikhoan() {
		return taikhoan;
	}
	public void setTaikhoan(Taikhoan taikhoan) {
		this.taikhoan = taikhoan;
	}
	

}
