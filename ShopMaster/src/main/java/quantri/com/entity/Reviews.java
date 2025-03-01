package quantri.com.entity;

import java.time.LocalDateTime;

public class Reviews {
	public int idreview;
	public Sanpham sanpham;
	public Taikhoan taikhoan;
	public int ratting;
	public String comments;
	public  LocalDateTime tgian;
	public Reviews() {
		super();
	}
	public Reviews(Sanpham sanpham, Taikhoan taikhoan, int ratting, String comments, LocalDateTime tgian) {
		super();
		this.sanpham = sanpham;
		this.taikhoan = taikhoan;
		this.ratting = ratting;
		this.comments = comments;
		this.tgian = tgian;
	}
	public Reviews(int idreview, Sanpham sanpham, Taikhoan taikhoan, int ratting, String comments,
			LocalDateTime tgian) {
		super();
		this.idreview = idreview;
		this.sanpham = sanpham;
		this.taikhoan = taikhoan;
		this.ratting = ratting;
		this.comments = comments;
		this.tgian = tgian;
	}
	public int getIdreview() {
		return idreview;
	}
	public void setIdreview(int idreview) {
		this.idreview = idreview;
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
	public int getRatting() {
		return ratting;
	}
	public void setRatting(int ratting) {
		this.ratting = ratting;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public LocalDateTime getTgian() {
		return tgian;
	}
	public void setTgian(LocalDateTime tgian) {
		this.tgian = tgian;
	}
	

}
