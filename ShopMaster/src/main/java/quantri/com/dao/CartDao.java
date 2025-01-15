package quantri.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import quantri.com.entity.CartItem;
import quantri.com.entity.Sanpham;
import quantri.com.entity.Taikhoan;

public class CartDao {
	private static final String INSERT_CART="INSERT INTO cart(idtaikhoan,tgian) VALUES(?,?)";
	private static final String GET_CART_BY_ID="SELECT idcart FROM cart WHERE idtaikhoan = ? ORDER BY tgian ASC LIMIT 1";
	private static final String SELECT_CART="SELECT ci.iditem,gh.idcart ,sp.idproduct, sp.proName,sp.imgfile, sp.price ,ci.slg,gh.tgian "
			+ "FROM cartitem ci JOIN sanpham sp ON ci.idproduct=sp.idproduct "
			+ "JOIN cart gh ON ci.idcart=gh.idcart "
			+ "WHERE ci.idcart=? ORDER BY ci.iditem DESC";
	private static final String COUNT_LIST="SELECT SUM(ci.slg) AS totalQuantity "
			+ "FROM cartitem ci JOIN cart gh ON ci.idcart = gh.idcart WHERE ci.idcart=?";
	private static final String DELETE_CART_SQL = "DELETE FROM cartitem WHERE iditem = ?";
	private static final String QUANTITY_CART="SELECT * FROM cartitem WHERE iditem = ?";
	//THEM GIỎ HÀNG
	public int createCart(Taikhoan taikhoan) throws SQLException {
	    try (Connection conn = DataConnection.getConnection();
	         PreparedStatement pst = conn.prepareStatement(INSERT_CART, PreparedStatement.RETURN_GENERATED_KEYS)) {

	        // Gán giá trị cho các tham số
	        pst.setInt(1, taikhoan.idtaikhoan);
	        pst.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis())); // Gán thời gian hiện tại

	        // Thực thi lệnh INSERT
	        int affectedRows = pst.executeUpdate();

	        // Kiểm tra nếu lệnh INSERT thành công
	        if (affectedRows > 0) {
	            // Lấy giá trị auto-increment của cột idcart
	            try (ResultSet rs = pst.getGeneratedKeys()) {
	                if (rs.next()) {
	                    return rs.getInt(1); // Trả về idcart
	                }
	            }
	        }
	    }
	    return -1; // Trả về -1 nếu không thêm được giỏ hàng
	}
	 // Thêm sản phẩm vào giỏ hàng
	public boolean addCartItem(int idcart, int idproduct, int slg)throws SQLException{
		 String sql = "INSERT INTO cartitem (idcart, idproduct, slg) VALUES (?, ?, ?) "
                 + "ON DUPLICATE KEY UPDATE slg = slg + ?";
		 try(Connection conn=DataConnection.getConnection();
				 PreparedStatement pst=conn.prepareStatement(sql)){
			 pst.setInt(1, idcart);
			 pst.setInt(2, idproduct);
			 pst.setInt(3, slg);
			 pst.setInt(4, slg);
			 return pst.executeUpdate()>0;
		 }
	}
	//KIỂM TRA TT CUA TAI KHOAN
	public Integer getCartByUserId( int idtaikhoan) throws SQLException{
		try(Connection conn=DataConnection.getConnection();
				 PreparedStatement pst=conn.prepareStatement(GET_CART_BY_ID)){
			pst.setInt(1, idtaikhoan);
			try(ResultSet rs=pst.executeQuery()){
				if(rs.next()) {
					return rs.getInt("idcart");
				}
			}
		}
		return null;
	}
 //DANH SACH GIO HANG
	public List<CartItem> DanhsachGH(int idcart) throws SQLException{
		List<CartItem> items=new ArrayList<CartItem>();
		try(Connection conn=DataConnection.getConnection();
				 PreparedStatement pst=conn.prepareStatement(SELECT_CART)){
			pst.setInt(1, idcart);
			try(ResultSet rs=pst.executeQuery()){
				while(rs.next())
				{
					Sanpham sanpham=new Sanpham();
					sanpham.idproduct=rs.getInt("idproduct");
					sanpham.proName=rs.getString("proName");
					sanpham.price=rs.getInt("price");
					sanpham.imgfile=rs.getBytes("imgfile");
					CartItem item=new CartItem();
					item.setIditem(rs.getInt("iditem"));
					item.setSanpham(sanpham);
					item.setSlg(rs.getInt("slg"));
					items.add(item);
				}
			}
		}
		return items;
	}
	
	//DEM SO LUONG 
	public int SoluongGH(int idcart)throws SQLException{
		int totalQuantity = 0;
		try(Connection conn=DataConnection.getConnection();
				 PreparedStatement pst=conn.prepareStatement(COUNT_LIST)){
					 pst.setInt(1, idcart);
					 ResultSet rs=pst.executeQuery();
					 if(rs.next()) {
						 totalQuantity=rs.getInt("totalQuantity");
					 }
				 }
		return totalQuantity;
	}
	
	//XOA
	public boolean XoaGH(int iditem)throws SQLException {
		try(Connection conn=DataConnection.getConnection();
				 PreparedStatement pst=conn.prepareStatement(DELETE_CART_SQL)){
			if(conn !=null) {
				pst.setInt(1, iditem);
				return pst.executeUpdate() > 0;
			}
		} catch (SQLException e) {
			throw new SQLException("Lỗi khi xóa giỏ hàng : " + e.getMessage());
	}
		return false;
	}
	
	//XOA GH SAU KHI ĐAT HANG
	public void clearCart( int idcart )throws SQLException{
		String sql="DELETE FROM cartitem WHERE idcart =?";
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(sql)){
			if(conn !=null) {
				pst.setInt(1, idcart);
				pst.executeUpdate();
			}
		}
	}
	
	//Lay Thong Tin Cua GH
	public CartItem getCartItemById(int iditem) throws SQLException{
		try(Connection conn=DataConnection.getConnection();
				 PreparedStatement pst=conn.prepareStatement(QUANTITY_CART)){
			pst.setInt(1, iditem);
			ResultSet rs=pst.executeQuery();
			if(rs.next()) {
				int slg=rs.getInt("slg");
				return new CartItem(iditem, slg);
			}
		}
		return null;
	}
	//Cap nhat Slg
	public boolean updateCartItem(CartItem cartItem) throws SQLException {
	    String sql = "UPDATE cartitem SET slg = ? WHERE iditem = ?";
	    try (Connection conn = DataConnection.getConnection();
	         PreparedStatement pst = conn.prepareStatement(sql)) {
	        pst.setInt(1, cartItem.getSlg());
	        pst.setInt(2, cartItem.getIditem());
	        return pst.executeUpdate() > 0;
	    }
	}

}
