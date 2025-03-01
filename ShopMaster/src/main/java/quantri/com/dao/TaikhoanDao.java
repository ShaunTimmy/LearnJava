package quantri.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.security.SecureRandom;
import java.util.Random;

import quantri.com.entity.Taikhoan;

public class TaikhoanDao {
	private static final String INSERT_ACCOUNT = "INSERT INTO taikhoan "
			+ "(username, password,address,email,sdt,role) " + "VALUES (?, ?, ?, ?, ?, ?)";
	private static final String SELECT_COUNT_ACCOUNT = "SELECT COUNT(*) FROM taikhoan";
	private static final String SELECT_LIMIT_ACCOUNT = "SELECT * FROM taikhoan ORDER BY idtaikhoan DESC LIMIT ? OFFSET ?";
	private static final String DELETE_ACCOUNT = "DELETE FROM taikhoan WHERE idtaikhoan = ?";
	private static final String SEARCH_ACCOUNT = "SELECT * FROM taikhoan WHERE username LIKE ?";
	private static final String LOGIN_ACCOUNT="SELECT * FROM taikhoan WHERE username = ? AND password = ? ";
	private static final String CHECK_LOGIN="SELECT COUNT(*) FROM taikhoan WHERE username = ?"	;
	private static final String SELECT_ACCOUNT_BY_ID="SELECT * FROM taikhoan WHERE idtaikhoan=?";
	private static final String UPDATE_ACCOUNT="UPDATE taikhoan SET password=? WHERE idtaikhoan=? ";
	private static final String UPDATE_INFOR_ACCOUNT="UPDATE taikhoan SET username=?, address=?"
			+ ",email=?,sdt=?"
			+ " WHERE idtaikhoan=? ";
	 private static final String UPDATE_ACCOUNT_STATUS = "UPDATE taikhoan SET pincode = NULL WHERE  pincode = ?";

	// DANG KY TAI KHOAN
	public void DangKyTaiKhoan(Taikhoan taikhoan) throws SQLException {
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(INSERT_ACCOUNT)) {
			pst.setString(1, taikhoan.getUsername());
			pst.setString(2, taikhoan.getPassword());
			pst.setString(3, taikhoan.getAddress());
			pst.setString(4, taikhoan.getEmail());
			pst.setString(5, taikhoan.getSdt());
			pst.setString(6, taikhoan.getRole());
			pst.executeUpdate();
			
		}
	}
	
	 public boolean verifyPin( String pinCode) throws SQLException {
	        try (Connection conn = DataConnection.getConnection();
	             PreparedStatement pst = conn.prepareStatement(UPDATE_ACCOUNT_STATUS)) {
	            pst.setString(1, pinCode);
	            int updatedRows = pst.executeUpdate();
	            return updatedRows > 0;
	        }
	    }


	// DEM SO LUONG
	public int countTaikhoan() throws SQLException {
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(SELECT_COUNT_ACCOUNT);
				ResultSet rs = pst.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}
		}
		return 0;
	}

	// DANH SACH PHAN TRANG
	public List<Taikhoan> DanhsachPhaTrang(int offset, int limit) throws SQLException {
		List<Taikhoan> danhsachTK = new ArrayList<Taikhoan>();
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(SELECT_LIMIT_ACCOUNT)) {
			pst.setInt(1, limit);
			pst.setInt(2, offset);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Taikhoan taikhoan = new Taikhoan();
				taikhoan.setIdtaikhoan(rs.getInt("idtaikhoan"));
				taikhoan.setUsername(rs.getString("username"));
				taikhoan.setAddress(rs.getString("address"));
				taikhoan.setEmail(rs.getString("email"));
				taikhoan.setSdt(rs.getString("sdt"));
				taikhoan.setRole(rs.getString("role"));
				danhsachTK.add(taikhoan);
			}
		}
		return danhsachTK;
	}

	// XOA
	public void XoaTaikhoan(int idtaikhoan) throws SQLException {
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(DELETE_ACCOUNT)) {
			pst.setInt(1, idtaikhoan);
			pst.executeUpdate();
		}
	}

// Tim kiem
	public List<Taikhoan> searchAccount(String keyword) throws SQLException {
		List<Taikhoan> listAccount = new ArrayList<Taikhoan>();
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(SEARCH_ACCOUNT)) {
			String searchKeyword = "%" + keyword + "%";
			pst.setString(1, searchKeyword);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				Taikhoan taikhoan = new Taikhoan();
				taikhoan.setIdtaikhoan(rs.getInt("idtaikhoan"));
				taikhoan.setUsername(rs.getString("username"));
				taikhoan.setAddress(rs.getString("address"));
				taikhoan.setEmail(rs.getString("email"));
				taikhoan.setSdt(rs.getString("sdt"));
				taikhoan.setRole(rs.getString("role"));
				listAccount.add(taikhoan);
			}
		}
		return listAccount;
	}
	// Login
	public Taikhoan validateTaikhoan(String username, String password) {
	    Taikhoan taikhoan = null;
	   
	    
	    try (Connection conn = DataConnection.getConnection();
	         PreparedStatement pst = conn.prepareStatement(LOGIN_ACCOUNT)) {
	        
	        // Set các tham số vào câu lệnh PreparedStatement
	        pst.setString(1, username);
	        pst.setString(2, password);
	    

	        // Thực thi truy vấn
	        ResultSet rs = pst.executeQuery();

	        // Kiểm tra nếu có dữ liệu trả về
	        if (rs.next()) {
	            taikhoan = new Taikhoan(
	                rs.getInt("idtaikhoan"),
	                rs.getString("username"),
	                rs.getString("password"),
	                rs.getString("role")
	                
	            );
	        }
	    } catch (SQLException e) {
	        // In ra thông báo lỗi chi tiết để dễ dàng debug
	        e.printStackTrace();
	    }
	    
	    return taikhoan; // Nếu không tìm thấy tài khoản hợp lệ, trả về null
	}
	
	
	//phuong thuc ktra username Admin
	public boolean isUsernameExists(String username) {
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(CHECK_LOGIN)){
			pst.setString(1, username);
			ResultSet rs=pst.executeQuery();
			if(rs.next()) {
    			int count=rs.getInt(1);
    			return count >0;
    		}
		}catch (Exception e) {
			// TODO: handle exception
    		e.printStackTrace();
	}
		return false;
	}
	
	//Khạch hang dang nhap 
			public Taikhoan validateTaikhoanKH(String email,String password) {
			    Taikhoan taikhoan = null;
			   String sql="SELECT * FROM taikhoan WHERE  email = ? AND password = ?";
			    try (Connection conn = DataConnection.getConnection();
			         PreparedStatement pst = conn.prepareStatement(sql)) {
			        
			        // Set các tham số vào câu lệnh PreparedStatement
			        pst.setString(1, email);
			        pst.setString(2, password);
			    

			        // Thực thi truy vấn
			        ResultSet rs = pst.executeQuery();

			        // Kiểm tra nếu có dữ liệu trả về
			        if (rs.next()) {
			            taikhoan = new Taikhoan(
			                rs.getInt("idtaikhoan"),
			                rs.getString("username"),
			                rs.getString("email"),
			                rs.getString("password"),
			                rs.getString("role")
			                
			            );
			        }
			    } catch (SQLException e) {
			        // In ra thông báo lỗi chi tiết để dễ dàng debug
			        e.printStackTrace();
			    }
			    
			    return taikhoan; // Nếu không tìm thấy tài khoản hợp lệ, trả về null
			}
		
	//phuong thuc ktra login khach hang
			public boolean isEmailExists(String email) {
				String sql="SELECT COUNT(*) FROM taikhoan WHERE email = ?";
				try(Connection conn=DataConnection.getConnection();
						PreparedStatement pst=conn.prepareStatement(sql)){
					pst.setString(1, email);
					ResultSet rs=pst.executeQuery();
					if(rs.next()) {
		    			int count=rs.getInt(1);
		    			return count >0;
		    		}
				}catch (Exception e) {
					// TODO: handle exception
		    		e.printStackTrace();
			}
				return false;
			}
	
	
	
	// Lấy tài khoản theo ID
	public  Taikhoan ThongTinTK(int idtaikhoan) {
		Taikhoan tk=null;
		 try(Connection connection=DataConnection.getConnection();
				 PreparedStatement pst=connection.prepareStatement(SELECT_ACCOUNT_BY_ID)){
			 pst.setInt(1, idtaikhoan);
			 ResultSet rs=pst.executeQuery();
			 if(rs.next()) {
				 String username = rs.getString("username");       
				    String address = rs.getString("address"); 
				    String password=rs.getString("password");
				    String email = rs.getString("email");         
				    String sdt = rs.getString("sdt"); 
				  tk= new Taikhoan(idtaikhoan, username, password, address, email, sdt);
			 }
		 }catch (Exception e) {
			// TODO: handle exception
			 e.printStackTrace();
		 }
		 return tk; 
		
	}
	// CAP NHAT MAT KHAU
	public boolean CapnhatMatkhau(Taikhoan tkhoan) throws SQLException{
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(UPDATE_ACCOUNT)) {
			if(conn !=null) {
				pst.setString(1, tkhoan.getPassword());
				pst.setInt(2, tkhoan.getIdtaikhoan());
				return pst.executeUpdate()>0;
			}
		} catch (SQLException e) {
			throw new SQLException("Lỗi khi cập nhật mật khẩu: " + e.getMessage());
		}
		return false;
	}
	//CAP NHAT THONG TIN 
	public boolean CapnhatTT(Taikhoan tk)throws SQLException{
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(UPDATE_INFOR_ACCOUNT)){
			if(conn !=null) {
				pst.setString(1, tk.getUsername());
				pst.setString(2,tk.getAddress());
				pst.setString(3, tk.getEmail());
				pst.setString(4, tk.getSdt());
				pst.setInt(5, tk.getIdtaikhoan());
				return pst.executeUpdate()>0;
			}
		}catch (SQLException e) {
			throw new SQLException("Lỗi khi cập nhật mật khẩu: " + e.getMessage());
		}
		return false;
	}

	
}