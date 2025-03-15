package quantri.com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import quantri.com.entity.Reviews;
import quantri.com.entity.Sanpham;
import quantri.com.entity.Taikhoan;

public class ReviewDao {

	// Review san pham
	public void DanhgiaSP(Reviews cmt) throws SQLException {
		String sql = "INSERT INTO reviews(idproduct, idtaikhoan,ratting,comments,tgian) VALUES(?,?,?,?,?)";
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, cmt.sanpham.getIdproduct());
			pst.setInt(2, cmt.taikhoan.getIdtaikhoan());
			pst.setInt(3, cmt.ratting);
			pst.setString(4, cmt.comments);
			pst.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
			int result = pst.executeUpdate();
			if (result > 0) {
				System.out.println("Review sản phẩm thành công.");

			} else {
				System.out.println("Review sản phẩm thất bại.");
			}
		} catch (SQLException e) {
			throw new SQLException("Lỗi khi thêm sản phẩm: " + e.getMessage());
		}
	}

	// Xem đanh gia (khach hang)
	public List<Reviews> getReviewsByProductId(int idproduct) throws SQLException {
		List<Reviews> reviewList = new ArrayList<Reviews>();
		String sql = "SELECT cmt.idreview, cmt.idproduct,sp.proName,tk.username,"
				+ "cmt.ratting,cmt.comments,cmt.tgian " + "FROM `reviews` cmt "
				+ "JOIN sanpham sp ON cmt.idproduct=sp.idproduct " + "JOIN taikhoan tk ON cmt.idtaikhoan=tk.idtaikhoan "
				+ "WHERE cmt.idproduct= ?";
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, idproduct);
			try (ResultSet rs = pst.executeQuery()) {
				while (rs.next()) {
					Reviews reviews = new Reviews();
					reviews.setIdreview(rs.getInt("idreview"));
					reviews.setRatting(rs.getInt("ratting"));
					reviews.setComments(rs.getString("comments"));
					reviews.setTgian(rs.getTimestamp("tgian").toLocalDateTime());

					// Sửa dòng này để lấy đúng idproduct từ ResultSet
					Sanpham sanpham = new Sanpham();
					sanpham.setIdproduct(rs.getInt("idproduct")); // Đảm bảo lấy đúng idproduct từ cột
					sanpham.setProName(rs.getString("proName"));
					reviews.setSanpham(sanpham);

					Taikhoan taikhoan = new Taikhoan();
					taikhoan.setUsername(rs.getString("username"));
					reviews.setTaikhoan(taikhoan);

					reviewList.add(reviews);
				}
			} catch (SQLException e) {
				throw new SQLException("Error fetching reviews: " + e.getMessage());
			}
			return reviewList;
		}

	}

	// DEM SO LUONG
	public int TongSoCMT() throws SQLException {
		String sql = "SELECT COUNT(*) FROM `reviews`";
		try (Connection conn = DataConnection.getConnection();
				PreparedStatement pst = conn.prepareStatement(sql);
				ResultSet rs = pst.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}

		}
		return 0;
	}

	// Danh sach cac comment
	public List<Reviews> DanhSachComment(int offset, int limit) {
		String sql = "SELECT cmt.idreview, cmt.idproduct,sp.proName,tk.username,"
				+ "cmt.ratting,cmt.comments,cmt.tgian " + "FROM `reviews` cmt "
				+ "JOIN sanpham sp ON cmt.idproduct=sp.idproduct " + "JOIN taikhoan tk ON cmt.idtaikhoan=tk.idtaikhoan "
				+ "ORDER BY cmt.idreview DESC LIMIT ? OFFSET ?";
		List<Reviews> listReviews = new ArrayList<Reviews>();
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, limit); // Số lượng sản phẩm trên mỗi trang
			pst.setInt(2, offset);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Reviews reviews = new Reviews();
				reviews.setIdreview(rs.getInt("idreview"));
				reviews.setRatting(rs.getInt("ratting"));
				reviews.setComments(rs.getString("comments"));
				reviews.setTgian(rs.getTimestamp("tgian").toLocalDateTime());

				// Sửa dòng này để lấy đúng idproduct từ ResultSet
				Sanpham sanpham = new Sanpham();
				sanpham.setIdproduct(rs.getInt("idproduct")); // Đảm bảo lấy đúng idproduct từ cột
				sanpham.setProName(rs.getString("proName"));
				reviews.setSanpham(sanpham);

				Taikhoan taikhoan = new Taikhoan();
				taikhoan.setUsername(rs.getString("username"));
				reviews.setTaikhoan(taikhoan);
				listReviews.add(reviews);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listReviews;

	}

	// XOA
	public boolean XoaCMT(int idreview) throws SQLException {
		String sql = "DELETE FROM `reviews` WHERE idreview = ?";
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			if (conn != null) {
				pst.setInt(1, idreview);
				return pst.executeUpdate() > 0;
			}
		} catch (SQLException e) {
			throw new SQLException("Lỗi khi xóa : " + e.getMessage());
		}
		return false;

	}

	// Chi tiết CMT
	public Reviews ChiTietCMT(int idreview) {
		Reviews cmt = null;
		String sql = "SELECT cmt.idreview, cmt.idproduct,sp.proName,tk.username,"
				+ "cmt.ratting,cmt.comments,cmt.tgian " + "FROM `reviews` cmt "
				+ "JOIN sanpham sp ON cmt.idproduct=sp.idproduct " + "JOIN taikhoan tk ON cmt.idtaikhoan=tk.idtaikhoan "
				+ "WHERE cmt.idreview= ?";
		try (Connection conn = DataConnection.getConnection(); PreparedStatement pst = conn.prepareStatement(sql)) {
			pst.setInt(1, idreview);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				cmt = new Reviews();
				cmt.setIdreview(rs.getInt("idreview"));
				cmt.setRatting(rs.getInt("ratting"));
				cmt.setComments(rs.getString("comments"));
				cmt.setTgian(rs.getTimestamp("tgian").toLocalDateTime());
				Sanpham sanpham = new Sanpham();
				sanpham.setIdproduct(rs.getInt("idproduct")); // Đảm bảo lấy đúng idproduct từ cột
				sanpham.setProName(rs.getString("proName"));
				cmt.setSanpham(sanpham);
				Taikhoan taikhoan = new Taikhoan();
				taikhoan.setUsername(rs.getString("username"));
				cmt.setTaikhoan(taikhoan);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cmt;
	}
}
