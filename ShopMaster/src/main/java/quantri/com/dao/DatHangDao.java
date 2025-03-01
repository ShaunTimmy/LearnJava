package quantri.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import quantri.com.entity.CartItem;
import quantri.com.entity.Orders;
import quantri.com.entity.Sanpham;
import quantri.com.entity.Taikhoan;

public class DatHangDao {
	// Thêm một đơn hàng mới
	public int insertOrder(Orders donhang) throws SQLException {
		String sql = "INSERT INTO orders (idtaikhoan,codeorder,idproduct,quantity ,orderdate, statu, totalprice) VALUES (?,?,?, ?,?,?, ?)";
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
			String codeorder = generateRandomOrderCode();
			pst.setInt(1, donhang.taikhoan.getIdtaikhoan());
			pst.setString(2, codeorder);
			pst.setInt(3, donhang.sanpham.getIdproduct());
			pst.setInt(4, donhang.getQuantity());
			pst.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
			pst.setString(6, donhang.statu);
			pst.setInt(7, donhang.totalprice);
			pst.executeUpdate();
			ResultSet rs = pst.getGeneratedKeys();
			if (rs.next()) {
				return rs.getInt(1);// Trả về ID đơn hàng vừa thêm
			}
		}
		return -1;
	}

	// Phương thức tạo mã đơn hàng ngẫu nhiên
	private String generateRandomOrderCode() {
		// Sử dụng UUID
		return "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
	}

	// Dat hang thanh cong
	public Orders getLatestOrder(int idtaikhoan) throws SQLException {
		Orders order = null;
		String sql = "SELECT dh.idorder, dh.codeorder " + "FROM orders dh "
				+ "JOIN taikhoan tk ON dh.idtaikhoan = tk.idtaikhoan " + "WHERE dh.idtaikhoan = ? "
				+ "ORDER BY dh.idorder DESC LIMIT 1";

		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, idtaikhoan); // Gán tham số idTaiKhoan vào câu truy vấn

			try (ResultSet rs = pst.executeQuery()) {
				if (rs.next()) {
					order = new Orders();
					order.setIdorder(rs.getInt("idorder"));
					order.setCodeorder(rs.getString("codeorder"));
				}
			}
		}
		return order;
	}

	// Lich su dat hang
	public List<Orders> LichSuDatHang(int idtaikhoan) {
		String sql = "SELECT dh.idorder,dh.codeorder,tk.username,sp.proName, " + "sp.imgfile,dh.quantity,dh.totalprice,"
				+ "tk.address,tk.sdt,dh.orderdate, dh.statu FROM `orders` dh "
				+ "JOIN sanpham sp ON dh.idproduct=sp.idproduct " + "JOIN taikhoan tk ON dh.idtaikhoan=tk.idtaikhoan "
				+ "WHERE dh.idtaikhoan=? ORDER BY dh.idorder DESC";
		List<Orders> listOrders = new ArrayList<Orders>();
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, idtaikhoan);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Orders dathang = new Orders();
				Sanpham sanpham = new Sanpham();
				Taikhoan taikhoan = new Taikhoan();
				dathang.setIdorder(rs.getInt("idorder"));
				dathang.setCodeorder(rs.getString("codeorder"));
				dathang.setTotalprice(rs.getInt("totalprice"));
				dathang.setQuantity(rs.getInt("quantity"));
				dathang.setOrderdate(rs.getTimestamp("orderdate").toLocalDateTime());
				dathang.setStatu(rs.getString("statu"));
				sanpham.setProName(rs.getString("proName"));
				sanpham.setImgfile(rs.getBytes("imgfile"));
				taikhoan.setUsername(rs.getString("username"));
				dathang.setSanpham(sanpham);
				dathang.setTaikhoan(taikhoan);
				listOrders.add(dathang);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOrders;
	}

	// Dem so luong
	public int SoluongDH() throws SQLException {
		String sql = "SELECT COUNT(*) FROM `orders`";
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(sql);
				ResultSet rs = pst.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}

		}
		return 0;
	}

	// Danh sach dat hang
	public List<Orders> DanhSachDonHang(int offset, int limit) {
		String sql = "SELECT dh.idorder,dh.codeorder,tk.username,sp.proName, " + "sp.imgfile,dh.quantity,dh.totalprice,"
				+ "tk.address,tk.sdt,dh.orderdate, dh.statu FROM `orders` dh "
				+ "JOIN sanpham sp ON dh.idproduct=sp.idproduct " + "JOIN taikhoan tk ON dh.idtaikhoan=tk.idtaikhoan "
				+ "ORDER BY dh.idorder DESC " + "LIMIT ? OFFSET ?";
		List<Orders> listOrders = new ArrayList<Orders>();
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, limit); // Số lượng sản phẩm trên mỗi trang
			pst.setInt(2, offset);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Orders dathang = new Orders();
				Sanpham sanpham = new Sanpham();
				Taikhoan taikhoan = new Taikhoan();
				dathang.setIdorder(rs.getInt("idorder"));
				dathang.setCodeorder(rs.getString("codeorder"));
				dathang.setTotalprice(rs.getInt("totalprice"));
				dathang.setQuantity(rs.getInt("quantity"));
				dathang.setOrderdate(rs.getTimestamp("orderdate").toLocalDateTime());
				dathang.setStatu(rs.getString("statu"));
				sanpham.setProName(rs.getString("proName"));
				sanpham.setImgfile(rs.getBytes("imgfile"));
				taikhoan.setUsername(rs.getString("username"));
				dathang.setSanpham(sanpham);
				dathang.setTaikhoan(taikhoan);
				listOrders.add(dathang);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listOrders;
	}

	// Lay Thong Tin Cua DH
	public Orders getOrdersByID(int idorder) throws SQLException {
		String sql = "SELECT * FROM `orders` WHERE idorder = ?";
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, idorder);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				String statu = rs.getString("statu");
				return new Orders(idorder, statu);
			}
		}
		return null;
	}

	// Cap nhat Trang thai
	public boolean updateStatus(Orders dh) throws SQLException {
		String sql = "UPDATE `orders` SET statu = ? WHERE idorder = ?";
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setString(1, dh.getStatu());
			pst.setInt(2, dh.getIdorder());
			return pst.executeUpdate() > 0;
		}
	}

	// Chi tiet don hang
	// Chi tiết đơn hàng
	public Orders ChiTietDH(int idorder) {
		Orders donhang = null;
		String sql = "SELECT dh.idorder, dh.codeorder, tk.username, sp.proName, sp.imgfile, "
				+ "dh.quantity, dh.totalprice, tk.address, tk.sdt, dh.orderdate, dh.statu " + "FROM orders dh "
				+ "JOIN sanpham sp ON dh.idproduct = sp.idproduct "
				+ "JOIN taikhoan tk ON dh.idtaikhoan = tk.idtaikhoan " + "WHERE dh.idorder = ?";
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, idorder);
			ResultSet rs = pst.executeQuery();

			if (rs.next()) { // Sửa từ while thành if vì chỉ cần lấy một đơn hàng
				donhang = new Orders();
				Sanpham sanpham = new Sanpham();
				Taikhoan taikhoan = new Taikhoan();

				// Set thông tin đơn hàng
				donhang.setIdorder(rs.getInt("idorder"));
				donhang.setCodeorder(rs.getString("codeorder"));
				donhang.setTotalprice(rs.getInt("totalprice"));
				donhang.setQuantity(rs.getInt("quantity"));
				donhang.setOrderdate(rs.getTimestamp("orderdate").toLocalDateTime());
				donhang.setStatu(rs.getString("statu"));

				// Set thông tin sản phẩm
				sanpham.setProName(rs.getString("proName"));
				sanpham.setImgfile(rs.getBytes("imgfile"));
				donhang.setSanpham(sanpham);

				// Set thông tin tài khoản
				taikhoan.setUsername(rs.getString("username"));
				taikhoan.setAddress(rs.getString("address"));
				taikhoan.setSdt(rs.getString("sdt"));
				donhang.setTaikhoan(taikhoan);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return donhang;
	}

	// Tong Doanh Thu
	 public Map<String, Integer> TongDoanhThuTheoThang() {
	        String sql = "SELECT DATE_FORMAT(orderdate, '%Y-%m') AS month, SUM(totalprice) AS revenue "
	                   + "FROM orders GROUP BY month ORDER BY month";
	        Map<String, Integer> doanhThuMap = new LinkedHashMap<>();

	        try (Connection conn = DataConnection.getConnection();
	             PreparedStatement pst = conn.prepareStatement(sql);
	             ResultSet rs = pst.executeQuery()) {

	            while (rs.next()) {
	                String month = rs.getString("month");
	                int revenue = (int) Math.round(rs.getDouble("revenue"));
	                doanhThuMap.put(month, revenue);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return doanhThuMap;
	    }

	// Huy don hang
	public boolean cancelOrder(int idorder, int idtaikhoan) {
		String sql = "UPDATE orders SET statu = 'Cancelled' WHERE idorder  = ? AND idtaikhoan = ? AND statu != 'Canceled'";
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, idorder);
			pst.setInt(2, idtaikhoan);
			return pst.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Xoa don hang
	public boolean XoaDH(int idorder) throws SQLException {
		String sql = "DELETE FROM orders WHERE idorder = ?";
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			if (conn != null) {
				pst.setInt(1, idorder);
				return pst.executeUpdate() > 0;
			}
		} catch (SQLException e) {
			throw new SQLException("Lỗi khi xóa : " + e.getMessage());
		}
		return false;

	}
	
	//tìm kiếm 
	public List<Orders> searchDH(String keyword) throws SQLException{
		String sql="SELECT * FROM orders WHERE codeorder LIKE ? OR  statu LIKE ?";
		List<Orders>lisOrders=new ArrayList<Orders>();
		try (Connection conn = DataConnection.getConnection(); 
				PreparedStatement pst = conn.prepareStatement(sql)) {
			String searchKeyword = "%" + keyword + "%";
			pst.setString(1, searchKeyword);
			pst.setString(2, searchKeyword); // Thêm tìm kiếm cho theloai
			ResultSet rs=pst.executeQuery();
			while(rs.next()) {
				Orders dathang = new Orders();
				Sanpham sanpham = new Sanpham();
				Taikhoan taikhoan = new Taikhoan();
				dathang.setIdorder(rs.getInt("idorder"));
				dathang.setCodeorder(rs.getString("codeorder"));
				dathang.setOrderdate(rs.getTimestamp("orderdate").toLocalDateTime());
				dathang.setStatu(rs.getString("statu"));
				dathang.setSanpham(sanpham);
				dathang.setTaikhoan(taikhoan);
				lisOrders.add(dathang);
			}
		}
		return lisOrders;
	}

}
