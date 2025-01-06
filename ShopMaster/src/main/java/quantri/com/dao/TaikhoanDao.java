package quantri.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import quantri.com.entity.Taikhoan;

public class TaikhoanDao {
	private static final String INSERT_ACCOUNT = "INSERT INTO taikhoan "
			+ "(username, password,address,email,sdt,role) " + "VALUES (?, ?, ?, ?, ?, ?)";
	private static final String SELECT_COUNT_ACCOUNT = "SELECT COUNT(*) FROM taikhoan";
	private static final String SELECT_LIMIT_ACCOUNT = "SELECT * FROM taikhoan ORDER BY idtaikhoan DESC LIMIT ? OFFSET ?";
	private static final String DELETE_ACCOUNT = "DELETE FROM taikhoan WHERE idtaikhoan = ?";
	private static final String SEARCH_ACCOUNT = "SELECT * FROM taikhoan WHERE username LIKE ?";
	private static final String LOGIN_ACCOUNT="SELECT * FROM taikhoan WHERE username = ? AND password = ?";
	private static final String CHECK_LOGIN="SELECT COUNT(*) FROM taikhoan WHERE username = ?"	;
	private static final String SELECT_ACCOUNT_BY_ID="SELECT * FROM taikhoan WHERE idtaikhoan=?";
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
	//Login
	public Taikhoan validateTaikhoan(String username,String password ) {
		Taikhoan taikhoan=null;
		try(Connection conn=DataConnection.getConnection();
				PreparedStatement pst=conn.prepareStatement(LOGIN_ACCOUNT)){
			pst.setString(1, username);
			pst.setString(2, password);
			 ResultSet rs=pst.executeQuery();
			 if(rs.next()) {
				 taikhoan=new Taikhoan(rs.getInt("idtaikhoan"), 
						 rs.getString("username"), 
						 rs.getString("password"),
						 rs.getString("role"));
			 }
		}catch (Exception e) {
			// TODO: handle exception
			 e.printStackTrace();
	}
		return taikhoan;
	}
	
	//phuong thuc ktra username
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
				    String email = rs.getString("email");         
				    String sdt = rs.getString("sdt"); 
				  tk= new Taikhoan(idtaikhoan, username, address, email, sdt);
			 }
		 }catch (Exception e) {
			// TODO: handle exception
			 e.printStackTrace();
		 }
		 return tk; 
		
	}
}