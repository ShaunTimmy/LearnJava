package quantri.com.entity;
import java.time.LocalDateTime;
public class Cart {
	public int idcart;
	public Taikhoan taikhoan;
	public LocalDateTime tgian;
	public Cart() {
		super();
	}
	public Cart(Taikhoan taikhoan, LocalDateTime tgian) {
		super();
		this.taikhoan = taikhoan;
		this.tgian = tgian;
	}
	public Cart(int idcart, Taikhoan taikhoan, LocalDateTime tgian) {
		super();
		this.idcart = idcart;
		this.taikhoan = taikhoan;
		this.tgian = tgian;
	}
	public int getIdcart() {
		return idcart;
	}
	public void setIdcart(int idcart) {
		this.idcart = idcart;
	}
	public Taikhoan getTaikhoan() {
		return taikhoan;
	}
	public void setTaikhoan(Taikhoan taikhoan) {
		this.taikhoan = taikhoan;
	}
	public LocalDateTime getTgian() {
		return tgian;
	}
	public void setTgian(LocalDateTime tgian) {
		this.tgian = tgian;
	}
	
	
}
