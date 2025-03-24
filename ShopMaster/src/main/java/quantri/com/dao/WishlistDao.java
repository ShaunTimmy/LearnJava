package quantri.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import quantri.com.entity.Sanpham;
import quantri.com.entity.Taikhoan;
import quantri.com.entity.Wishlist;

public class WishlistDao {
	private static final String INSERT_WishList="INSERT INTO wishlist(idproduct,idtaikhoan)VALUES(?,?) ";
	private static final String SELECT_WISHLIST="SELECT yt.idlist, sp.proName, sp.imgfile,"
			+ "sp.price, tk.idtaikhoan " +
            "FROM wishlist yt " +
            "JOIN sanpham sp ON yt.idproduct = sp.idproduct " +
            "JOIN taikhoan tk ON yt.idtaikhoan = tk.idtaikhoan " +
            "WHERE tk.idtaikhoan = ? ORDER BY yt.idlist DESC LIMIT ? OFFSET ?  ";
	private static final String DELETE_WISHLIST="DELETE  FROM wishlist WHERE idlist = ?";
	private static final String COUNT_LIST="SELECT COUNT(*) FROM wishlist WHERE idtaikhoan = ?";
	private static final String SELECT_WISHLIST_LIMIT = "SELECT * FROM wishlist WHERE idtaikhoan = ? LIMIT ? OFFSET ?";
	//THEM SAN PHAM YEU THICHS
	public boolean ThemDanhSach(Wishlist wishlist) {
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(INSERT_WishList)){
			pst.setInt(1, wishlist.getSanpham().getIdproduct()); // ID sản phẩm
	        pst.setInt(2, wishlist.getTaikhoan().getIdtaikhoan());
			int result=pst.executeUpdate();
			return result >0;
		}
		catch (SQLException e) {
            e.printStackTrace();
            return false;
	}
	}
	//DANH SACH
	public List<Wishlist> DanhsachYeuThich(int idtaikhoan,int offset, int limit){
		List<Wishlist> wishListItem=new ArrayList<Wishlist>();
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(SELECT_WISHLIST)){
			pst.setInt(1, idtaikhoan);
			pst.setInt(2, limit); // Số lượng sản phẩm trên mỗi trang
	        pst.setInt(3, offset); // Vị trí bắt đầu của trang
			ResultSet rs = pst.executeQuery();
			while(rs.next()) {
				Wishlist wishlist=new Wishlist();
				Sanpham sanpham=new Sanpham();
				Taikhoan taikhoan=new Taikhoan();
				wishlist.setIdlist(rs.getInt("idlist"));
				sanpham.setProName(rs.getString("proName"));
				sanpham.setImgfile(rs.getBytes("imgfile"));
				sanpham.setPrice(rs.getInt("price"));
				taikhoan.setIdtaikhoan(rs.getInt("idtaikhoan"));
				wishlist.setSanpham(sanpham);
				wishlist.setTaikhoan(taikhoan);
				// Thêm vào danh sách
	            wishListItem.add(wishlist);
			}
		}
		catch (SQLException e) {
	        e.printStackTrace();
	    }
		return wishListItem;
	}

	//Xoa
	public void XoaDS(int idlist)throws SQLException{
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(DELETE_WISHLIST)){
			pst.setInt(1, idlist);
			pst.executeUpdate();
		}
	}
	//DEM SO LUONG 
	public int SoluongYT(int idtaikhoan)throws SQLException{
		int count=0;
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(COUNT_LIST)){
			pst.setInt(1, idtaikhoan);
			try(ResultSet rs=pst.executeQuery()){
				if(rs.next()) {
					count =rs.getInt(1);
				}
			}
		}
		return count;
	}

	
}
