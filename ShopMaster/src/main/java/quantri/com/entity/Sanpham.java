package quantri.com.entity;

public class Sanpham {
	public int idproduct ;
	public String  proName;
	public String  description;
	public byte[] imgfile;
	public int price;
	public int stock;
	public String thoigianGH;
	public String theloai;
	public Sanpham() {
		super();
	}


	public Sanpham(int idproduct) {
		super();
		this.idproduct = idproduct;
	}

	public Sanpham(String proName, String description, byte[] imgfile, int price, int stock, String thoigianGH,
			String theloai) {
		super();
		this.proName = proName;
		this.description = description;
		this.imgfile = imgfile;
		this.price = price;
		this.stock = stock;
		this.thoigianGH = thoigianGH;
		this.theloai = theloai;
	}


	public Sanpham(int idproduct, String proName, String description, byte[] imgfile, int price, int stock,
			String thoigianGH, String theloai) {
		super();
		this.idproduct = idproduct;
		this.proName = proName;
		this.description = description;
		this.imgfile = imgfile;
		this.price = price;
		this.stock = stock;
		this.thoigianGH = thoigianGH;
		this.theloai = theloai;
	}


	public int getIdproduct() {
		return idproduct;
	}
	public void setIdproduct(int idproduct) {
		this.idproduct = idproduct;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public byte[] getImgfile() {
		return imgfile;
	}
	public void setImgfile(byte[] imgfile) {
		this.imgfile = imgfile;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getThoigianGH() {
		return thoigianGH;
	}

	public void setThoigianGH(String thoigianGH) {
		this.thoigianGH = thoigianGH;
	}


	public String getTheloai() {
		return theloai;
	}


	public void setTheloai(String theloai) {
		this.theloai = theloai;
	}
	
	
	

}
