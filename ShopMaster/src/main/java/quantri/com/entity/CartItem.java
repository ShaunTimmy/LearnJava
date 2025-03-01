package quantri.com.entity;

public class CartItem {
	public int iditem;
	public Cart cart;
	public Sanpham sanpham;
	public int slg;
	public CartItem() {
		super();
	}
	public CartItem(Cart cart, Sanpham sanpham, int slg) {
		super();
		this.cart = cart;
		this.sanpham = sanpham;
		this.slg = slg;
	}
	public CartItem(int iditem, Cart cart, Sanpham sanpham, int slg) {
		super();
		this.iditem = iditem;
		this.cart = cart;
		this.sanpham = sanpham;
		this.slg = slg;
	}
	
	public CartItem(int iditem, int slg) {
		super();
		this.iditem = iditem;
		this.slg = slg;
	}
	public int getIditem() {
		return iditem;
	}
	public void setIditem(int iditem) {
		this.iditem = iditem;
	}
	public Cart getCart() {
		return cart;
	}
	public void setCart(Cart cart) {
		this.cart = cart;
	}
	public Sanpham getSanpham() {
		return sanpham;
	}
	public void setSanpham(Sanpham sanpham) {
		this.sanpham = sanpham;
	}
	public int getSlg() {
		return slg;
	}
	public void setSlg(int slg) {
		this.slg = slg;
	}
	
}
