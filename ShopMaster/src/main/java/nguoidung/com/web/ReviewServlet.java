package nguoidung.com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import quantri.com.dao.ReviewDao;
import quantri.com.dao.SanphamDao;
import quantri.com.entity.Reviews;
import quantri.com.entity.Sanpham;
import quantri.com.entity.Taikhoan;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "ReviewServlet", value = "/review")
public class ReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public ReviewDao reviewDao;
	public SanphamDao sanphamDao;

	public ReviewServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		reviewDao = new ReviewDao();
		sanphamDao=new SanphamDao();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		if (action == null) {
			action = "list";
		}
		try {
			switch (action) {
			case"add":
				showForm(request, response);
				break;
			case "danhgia":
				ReviewSP(request, response);
				break;
			case "details":
				Chitiet(request, response);
				break;
			default:
				break;
			}
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("infomal.jsp");
			dispatcher.forward(request, response);
		}
	}

	private void Chitiet(HttpServletRequest request, HttpServletResponse response) 
			 throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		// Lấy idproduct từ request
        String productIdParam = request.getParameter("idproduct");
       
        if (productIdParam == null) {
            response.sendRedirect("infomal.jsp"); // Nếu không có idproduct, điều hướng tới trang lỗi
            return;
        }
        int productId = Integer.parseInt(productIdParam);
        try {
        	Sanpham sanpham = sanphamDao.LaySpTheoID(productId);// lay thong tin cua 1 san pham 
        	List<Reviews> reList=reviewDao.getReviewsByProductId(productId);
        	request.setAttribute("reviews", reList);
        	 request.setAttribute("proName", sanpham.getProName());
        	 request.getRequestDispatcher("review-detail.jsp").forward(request, response);
        }catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("infomal.jsp"); // Nếu có lỗi, điều hướng tới trang lỗi
        }
	}

	private void showForm(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException, SQLException {
	    // Lấy idproduct từ query parameter
	    String idproductParam = request.getParameter("idproduct");
	    if (idproductParam != null) {
	        try {
	            Integer idproduct = Integer.parseInt(idproductParam);
	            // Lưu idproduct vào session
	            request.getSession().setAttribute("idproduct", idproduct);
	            // Chuyển đến trang đánh giá
	            RequestDispatcher dispatcher = request.getRequestDispatcher("reviews.jsp");
	            dispatcher.forward(request, response);
	        } catch (NumberFormatException e) {
	            response.sendRedirect("error.jsp"); // ID không hợp lệ
	        }
	    } else {
	        response.sendRedirect("error.jsp"); // Không có idproduct
	    }
	}


	private void ReviewSP(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		try {
			// Lấy thông tin tài khoản từ session
			Taikhoan taikhoan = (Taikhoan) request.getSession().getAttribute("taikhoan");
			if (taikhoan == null) {
				response.sendRedirect("dangnhap.jsp");
				return;
			}
			// Lấy thông tin từ session
			Integer productId = (Integer) request.getSession().getAttribute("idproduct");
			if (productId == null) {
				response.sendRedirect("error.jsp");
				return;
			}
			// Lấy thông tin từ request
			int ratting = Integer.parseInt(request.getParameter("ratting"));
			String comments = request.getParameter("comments");
			// Tạo đối tượng Reviews
			Reviews reviews = new Reviews();
			reviews.taikhoan = taikhoan;
			reviews.sanpham = new Sanpham();
			reviews.sanpham.setIdproduct(productId);
			reviews.ratting = ratting;
			reviews.comments = comments;
			reviews.tgian = LocalDateTime.now();
			reviewDao.DanhgiaSP(reviews);
			  // Lưu thông báo vào session
	        HttpSession session = request.getSession();
	        session.setAttribute("message", "Cảm ơn bạn đã gửi đánh giá! Chúng tôi rất trân trọng phản hồi của bạn.");
	        session.setAttribute("messageType", "success"); // Để xác định kiểu thông báo (success, error)
	        
			response.sendRedirect("homepage");
		} catch (Exception e) {
			throw new ServletException("Error processing review: " + e.getMessage(), e);
		}
	}

}
