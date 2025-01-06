package quantri.com.entity;

public class Taikhoan {
	 public int idtaikhoan ;
	 public String username,password,address;
	 public String 	email,sdt,role;
	public Taikhoan() {
		super();
	}
	
	public Taikhoan(int idtaikhoan) {
		super();
		this.idtaikhoan = idtaikhoan;
	}

	public Taikhoan(String username, String password, String address, String email, String sdt, String role) {
		super();
		this.username = username;
		this.password = password;
		this.address = address;
		this.email = email;
		this.sdt = sdt;
		this.role = role;
	}
	public Taikhoan(int idtaikhoan, String username, String password, String address, String email, String sdt,
			String role) {
		super();
		this.idtaikhoan = idtaikhoan;
		this.username = username;
		this.password = password;
		this.address = address;
		this.email = email;
		this.sdt = sdt;
		this.role = role;
	}
	
	public Taikhoan(int idtaikhoan, String username, String password, String role) {
		super();
		this.idtaikhoan = idtaikhoan;
		this.username = username;
		this.password = password;
		this.role = role;
	}
	
	public Taikhoan(int idtaikhoan, String username, String address, String email, String sdt) {
		super();
		this.idtaikhoan = idtaikhoan;
		this.username = username;
		this.address = address;
		this.email = email;
		this.sdt = sdt;
	}

	public int getIdtaikhoan() {
		return idtaikhoan;
	}
	public void setIdtaikhoan(int idtaikhoan) {
		this.idtaikhoan = idtaikhoan;
	}
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSdt() {
		return sdt;
	}
	public void setSdt(String sdt) {
		this.sdt = sdt;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	 

}
