package quantri.com.entity;

import java.time.LocalDateTime;

public class Orders {
	public int idorder;
	public String codeorder;
	public Taikhoan taikhoan;
	public Sanpham sanpham;
	public int quantity;
	public LocalDateTime orderdate;
	public String statu;
	public int totalprice;
	
	public Orders() {
		super();
	}


	public Orders(int idorder, String codeorder, Taikhoan taikhoan, Sanpham sanpham, int quantity,
			LocalDateTime orderdate, String statu, int totalprice) {
		super();
		this.idorder = idorder;
		this.codeorder = codeorder;
		this.taikhoan = taikhoan;
		this.sanpham = sanpham;
		this.quantity = quantity;
		this.orderdate = orderdate;
		this.statu = statu;
		this.totalprice = totalprice;
	}


	public Orders(String codeorder, Taikhoan taikhoan, Sanpham sanpham, int quantity, LocalDateTime orderdate,
			String statu, int totalprice) {
		super();
		this.codeorder = codeorder;
		this.taikhoan = taikhoan;
		this.sanpham = sanpham;
		this.quantity = quantity;
		this.orderdate = orderdate;
		this.statu = statu;
		this.totalprice = totalprice;
	}


	public Orders(int idorder, String codeorder, Taikhoan taikhoan) {
		super();
		this.idorder = idorder;
		this.codeorder = codeorder;
		this.taikhoan = taikhoan;
	}

	

	public Orders(int idorder, String statu) {
		super();
		this.idorder = idorder;
		this.statu = statu;
	}


	public int getIdorder() {
		return idorder;
	}

	public void setIdorder(int idorder) {
		this.idorder = idorder;
	}

	public Taikhoan getTaikhoan() {
		return taikhoan;
	}

	public void setTaikhoan(Taikhoan taikhoan) {
		this.taikhoan = taikhoan;
	}

	public Sanpham getSanpham() {
		return sanpham;
	}

	public void setSanpham(Sanpham sanpham) {
		this.sanpham = sanpham;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public LocalDateTime getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(LocalDateTime orderdate) {
		this.orderdate = orderdate;
	}

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
	}

	public int getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}


	public String getCodeorder() {
		return codeorder;
	}


	public void setCodeorder(String codeorder) {
		this.codeorder = codeorder;
	}


	
	



}
