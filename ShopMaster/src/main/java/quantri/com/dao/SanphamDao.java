package quantri.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.crypto.Data;

import quantri.com.entity.Sanpham;

public class SanphamDao {
	private static final String INSERT_PRODUCT_SQL = "INSERT INTO sanpham"
			+ " (proName, description, imgfile, price ,stock,thoigianGH,theloai) " + "VALUES (?, ?, ?, ?, ?, ?,?)";
	private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM sanpham  ORDER BY idproduct DESC";
	private static final String DELETE_PRODUCT_SQL = "DELETE FROM sanpham WHERE idproduct = ?";
	private static final String SELECT_PRODUCT_BY_ID = "SELECT * FROM sanpham WHERE idproduct = ?";
	private static final String UPDATE_PRODUCT_SQL = "UPDATE sanpham SET proName = ?, description = ?, imgfile = ?, price= ?, stock = ?, thoigianGH = ?,theloai=? WHERE idproduct = ?";
	private static final String SELECT_COUNT_PRODUCT = "SELECT COUNT(*) FROM sanpham ";
	private static final String SELECT_LIMIT_PRODUCT = "SELECT * FROM sanpham  ORDER BY idproduct DESC LIMIT ? OFFSET ?";
	private static final String SEARCH_PRODUCT="SELECT * FROM sanpham  WHERE proName LIKE ? ";
	private static final String SELECT_PRODUCT_BY_CATEGORY = "SELECT * FROM sanpham WHERE theloai = ? ORDER BY idproduct DESC LIMIT ? OFFSET ?";
	private static final String SELECT_COUNT_PRODUCT_BY_CATEGORY=" SELECT COUNT(*) FROM Sanpham WHERE theloai = ?";
	private static final String SELECT_PRODUCT="SELECT * FROM sanpham ORDER BY idproduct DESC  LIMIT 3  ";
	// Them
	public void ThemSP(Sanpham sp) throws SQLException {
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(INSERT_PRODUCT_SQL)) {
			if (conn != null) {
				pst.setString(1, sp.getProName());
				pst.setString(2, sp.getDescription());
				pst.setBytes(3, sp.getImgfile());
				pst.setInt(4, sp.getPrice());
				pst.setInt(5, sp.getStock());
				pst.setString(6, sp.getThoigianGH());
				pst.setString(7, sp.getTheloai());
				int result = pst.executeUpdate();
				if (result > 0) {
					System.out.println("Thêm sản phẩm thành công.");

				} else {
					System.out.println("Thêm sản phẩm thất bại.");
				}
			}
		} catch (SQLException e) {
			throw new SQLException("Lỗi khi thêm sản phẩm: " + e.getMessage());
		}
	}

	// Lấy danh sách Sản Phẩm Giới Thiệu
	public List<Sanpham> selectProductIntro() {
		List<Sanpham> sanphamList = new ArrayList<Sanpham>();
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(SELECT_PRODUCT);
				ResultSet rs = pst.executeQuery()) {
			while (rs.next()) {
				int idproduct = rs.getInt("idproduct");
				String proName = rs.getString("proName");
				String description = rs.getString("description");
				byte[] imgfile = rs.getBytes("imgfile");
				int price = rs.getInt("price");
				int stock = rs.getInt("stock");
				String thoigianGH = rs.getString("thoigianGH");
				String theloai=rs.getString("theloai");
				sanphamList.add(new Sanpham(idproduct, proName, description, imgfile, price, stock, thoigianGH, theloai));

			}
		} catch (SQLException e) {
			System.err.println("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
		}
		return sanphamList;
	}

	// Xoas
	public boolean XoaTT(int idproduct) throws SQLException {
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(DELETE_PRODUCT_SQL)) {
			if (conn != null) {
				pst.setInt(1, idproduct);
				return pst.executeUpdate() > 0;
			}
		} catch (SQLException e) {
			throw new SQLException("Lỗi khi xóa sản phẩm: " + e.getMessage());
		}
		return false;
	}

	// lay theo id
	public Sanpham LaySpTheoID(int idproduct) {
		Sanpham sanpham = null;
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(SELECT_PRODUCT_BY_ID)) {
			if (conn != null) {
				pst.setInt(1, idproduct);
				try (ResultSet rs = pst.executeQuery()) {
					if (rs.next()) {
						String proName = rs.getString("proName");
						String description = rs.getString("description");
						byte[] imgfile = rs.getBytes("imgfile");
						int price = rs.getInt("price");
						int stock = rs.getInt("stock");
						String thoigianGH = rs.getString("thoigianGH");
						String theloai=rs.getString("theloai");
						sanpham = new Sanpham(proName, description, imgfile, price, stock, thoigianGH, theloai);
					}
				}
			}
		} catch (SQLException e) {
			System.err.println("Lỗi khi lấy sản phẩm theo ID: " + e.getMessage());
		}
		return sanpham;
	}

	// Cap nhat
	public boolean CapnhatSP(Sanpham sanpham) throws SQLException {
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(UPDATE_PRODUCT_SQL)) {
			if (conn != null) {
				pst.setString(1, sanpham.getProName());
				pst.setString(2, sanpham.getDescription());
				pst.setBytes(3, sanpham.getImgfile());
				pst.setInt(4, sanpham.getPrice());
				pst.setInt(5, sanpham.getStock());
				pst.setString(6, sanpham.getThoigianGH());
				pst.setString(7, sanpham.getTheloai());
				pst.setInt(8, sanpham.getIdproduct());
				return pst.executeUpdate() > 0;

			}
		} catch (SQLException e) {
			throw new SQLException("Lỗi khi cập nhật sản phẩm: " + e.getMessage());
		}
		return false;
	}

	// DEM SO LUONG
	public int CountPrdouduct()throws SQLException{
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(SELECT_COUNT_PRODUCT);
				ResultSet rs=pst.executeQuery()){
			if(rs.next()) {
				return rs.getInt(1);
			}
		}
		return 0;
	}
	// Lấy danh sách theo phân trang
	public List<Sanpham> DanhsachPhanTrang(int offset, int limit)throws SQLException {
		List<Sanpham> listSanpham=new ArrayList<Sanpham>();
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(SELECT_LIMIT_PRODUCT)){
			pst.setInt(1, limit);// Số lượng sản phẩm trên mỗi trang
			 pst.setInt(2, offset);// Vị trí bắt đầu của trang
			 ResultSet rs=pst.executeQuery();
			 while(rs.next()) {
				 Sanpham sanpham=new Sanpham();
				 sanpham.setIdproduct(rs.getInt("idproduct"));
				 sanpham.setProName(rs.getString("proName"));
				 sanpham.setImgfile(rs.getBytes("imgfile"));
				 sanpham.setPrice(rs.getInt("price"));
				 sanpham.setStock(rs.getInt("stock"));
				 sanpham.setThoigianGH(rs.getString("thoigianGH"));
				 sanpham.setTheloai(rs.getString("theloai"));
				 listSanpham.add(sanpham);
			 }
		}
		return listSanpham;
		
	}
	//// Lấy danh sách theo phân trang phía khách hàng 
	public List<Sanpham> SanphamPhanTrang(int offset, int limit)throws SQLException {
		List<Sanpham> listSanpham=new ArrayList<Sanpham>();
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(SELECT_LIMIT_PRODUCT)){
			pst.setInt(1, limit);// Số lượng sản phẩm trên mỗi trang
			 pst.setInt(2, offset);// Vị trí bắt đầu của trang
			 ResultSet rs=pst.executeQuery();
			 while(rs.next()) {
				 Sanpham sanpham=new Sanpham();
				 sanpham.setIdproduct(rs.getInt("idproduct"));
				 sanpham.setProName(rs.getString("proName"));
				 sanpham.setImgfile(rs.getBytes("imgfile"));
				 sanpham.setPrice(rs.getInt("price"));
				 listSanpham.add(sanpham);
			 }
		}
		return listSanpham;
		
	}
	
	//Tim kiem ben admin
	public List<Sanpham> searchProduct(String keyword) throws SQLException{
		String SEARCH_PRODUCT_ADMIN="SELECT * FROM sanpham  WHERE proName LIKE ? OR theloai LIKE ?";
		List<Sanpham> product=new ArrayList<Sanpham>();
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(SEARCH_PRODUCT_ADMIN)){
			String searchKeyword = "%" + keyword + "%";
			pst.setString(1, searchKeyword);
			pst.setString(2, searchKeyword); // Thêm tìm kiếm cho theloai
			ResultSet rs=pst.executeQuery();
			while (rs.next()) {
				Sanpham sanpham=new Sanpham();
				 sanpham.setIdproduct(rs.getInt("idproduct"));
				 sanpham.setProName(rs.getString("proName"));
				 sanpham.setImgfile(rs.getBytes("imgfile"));
				 sanpham.setPrice(rs.getInt("price"));
				 sanpham.setStock(rs.getInt("stock"));
				 sanpham.setThoigianGH(rs.getString("thoigianGH"));
				 sanpham.setTheloai(rs.getString("theloai"));
				 product.add(sanpham);
				
			}
		}
		return product;
	}
	//Tim kiem theo danh muc
	public List<Sanpham> ProuctByCate(String danhmuc) throws SQLException{
		String sql="SELECT * FROM sanpham WHERE theloai LIKE ?";
		List<Sanpham> product=new ArrayList<Sanpham>();
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(sql)){
			String searchCate = "%" + danhmuc + "%";
			pst.setString(1, searchCate);
			ResultSet rs=pst.executeQuery();
			while (rs.next()) {
				Sanpham sanpham=new Sanpham();
				 sanpham.setIdproduct(rs.getInt("idproduct"));
				 sanpham.setProName(rs.getString("proName"));
				 sanpham.setImgfile(rs.getBytes("imgfile"));
				 sanpham.setPrice(rs.getInt("price"));
				 sanpham.setStock(rs.getInt("stock"));
				 sanpham.setThoigianGH(rs.getString("thoigianGH"));
				 sanpham.setTheloai(rs.getString("theloai"));
				 product.add(sanpham);
				
			}
		}
		return product;
		}
		
	
	
	//Tim kiem ben khạch hang
		public List<Sanpham> CustomersearchProduct(String keyword) throws SQLException{
			List<Sanpham> product=new ArrayList<Sanpham>();
			try(Connection conn=DataConnection.getConnection();
					PreparedStatement pst=conn.prepareStatement(SEARCH_PRODUCT)){
				String searchKeyword = "%" + keyword + "%";
				pst.setString(1, searchKeyword);
				ResultSet rs=pst.executeQuery();
				while (rs.next()) {
					Sanpham sanpham=new Sanpham();
					 sanpham.setIdproduct(rs.getInt("idproduct"));
					 sanpham.setProName(rs.getString("proName"));
					 sanpham.setImgfile(rs.getBytes("imgfile"));
					 sanpham.setPrice(rs.getInt("price"));
					 product.add(sanpham);
					
				}
			}
			return product;
		}
	// Đém sản phẩm theo the loại 
	public int getTotalProductsByCategory(String theloai) throws SQLException {
	    int total = 0;
	    String countQuery = "SELECT COUNT(*) FROM Sanpham WHERE theloai = ?";
	    try (Connection conn = DataConnection.getConnection();
	         PreparedStatement pst = conn.prepareStatement(countQuery)) {
	        pst.setString(1, theloai);
	        try (ResultSet rs = pst.executeQuery()) {
	            if (rs.next()) {
	                total = rs.getInt(1);
	            }
	        }
	    }
	    return total;
	}
	//Lay san pham theo the loai
	public List<Sanpham> getSanphamByTheloai(String theloai,int page, int pageSize) throws SQLException{
		List<Sanpham> product=new ArrayList<Sanpham>();
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(SELECT_PRODUCT_BY_CATEGORY)){
			pst.setString(1, theloai);
			pst.setInt(2, pageSize);
			pst.setInt(3, (page-1)*pageSize);
			try(ResultSet rs=pst.executeQuery()){
				while(rs.next()) {
					Sanpham sanpham=new Sanpham();
					 sanpham.setIdproduct(rs.getInt("idproduct"));
					 sanpham.setProName(rs.getString("proName"));
					 sanpham.setImgfile(rs.getBytes("imgfile"));
					 sanpham.setPrice(rs.getInt("price"));
					 sanpham.setStock(rs.getInt("stock"));
					 sanpham.setThoigianGH(rs.getString("thoigianGH"));
					 sanpham.setTheloai(rs.getString("theloai"));
					 product.add(sanpham);
				}
			}
		}
		catch (SQLException e) {
	        throw new SQLException("Lỗi khi lấy sản phẩm theo thể loại: " + e.getMessage());
	    }
		return product;
	}
	

	
}
