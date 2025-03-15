package quantri.com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import quantri.com.dao.DatHangDao;
import quantri.com.entity.Orders;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet(name="DonhangServlet",value="/donhang")
public class DonhangServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       private DatHangDao datHangDao;
   
    public DonhangServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		datHangDao=new DatHangDao();
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action=request.getParameter("action");
		if(action==null) {
			action="list";
		}
		try {
			switch(action) {
			case "details":
				Chitiet(request, response);
			break;
			case "update":
				TrangthaiDH(request, response);
				break;
			case "delete":
				XoaDH(request, response);
				break;
			case "search":
				Timkiem(request, response);
				break;
			default:
				listDatHang(request, response);
				break;
			}
		}catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
			dispatcher.forward(request, response);
		}
	}




	private void Timkiem(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		String keyword=request.getParameter("keyword");
		List<Orders> searchDH=datHangDao.searchDH(keyword);
		request.setAttribute("listDH", searchDH);
		request.setAttribute("keyword", keyword);
		RequestDispatcher dispatcher=request.getRequestDispatcher("donhang-list.jsp");
		dispatcher.forward(request, response);
		
		
	}


	private void Chitiet(HttpServletRequest request, HttpServletResponse response) 
			 throws ServletException, IOException{
		// TODO Auto-generated method stub
		  try {
			   int idorder = Integer.parseInt(request.getParameter("idorder"));
			   Orders exisDh= datHangDao.ChiTietDH(idorder);
			   if(exisDh !=null) {
				   request.setAttribute("chitiet", exisDh);
				   RequestDispatcher dispatcher=request.getRequestDispatcher("chitiet-donhang.jsp");
				   dispatcher.forward(request, response);
			   }else {
		            request.setAttribute("errorMessage", "Đơn hàng không tồn tại.");
		            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
		            dispatcher.forward(request, response);
		        }
		  }catch (NumberFormatException e) {
		        request.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ.");
		        RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
		        dispatcher.forward(request, response);
		    }
		
	}


	private void TrangthaiDH(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException, SQLException {
	    // Lấy thông tin từ request
	    int idorder = Integer.parseInt(request.getParameter("idorder"));
	    String newStatus = request.getParameter("statu"); // Trạng thái mới từ form

	    // Lấy thông tin đơn hàng từ cơ sở dữ liệu
	    Orders donhang = datHangDao.getOrdersByID(idorder);

	    if (donhang != null) {
	        // Cập nhật trạng thái đơn hàng
	        donhang.setStatu(newStatus); // Gán trạng thái mới
	        boolean updated = datHangDao.updateStatus(donhang);

	        if (!updated) {
	            throw new SQLException("Cập nhật trạng thái không thành công.");
	        }
	    }

	    // Chuyển hướng về trang danh sách đơn hàng
	    response.sendRedirect("donhang?action=list");
	}



	private void listDatHang(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		int pageSize=6;
		int pageNumber=1;
		// Lấy số trang từ tham số "page", nếu không có thì mặc định là 1
				String pageParam=request.getParameter("page");
				if(pageParam !=null && !pageParam.isEmpty()) {
					pageNumber=Integer.parseInt(pageParam);
				}
				// Tính số lượng từ database
				int totalDH=datHangDao.SoluongDH();
				int totalPages=(int) Math.ceil((double) totalDH/pageSize);
				int offset=(pageNumber -1)*pageSize;
		List<Orders> listDH=datHangDao.DanhSachDonHang(offset, pageSize);
		request.setAttribute("listDH", listDH);
		request.setAttribute("currentPage", pageNumber);
		request.setAttribute("totalPages", totalPages);
		request.getSession().setAttribute("tongdh", totalDH);
		RequestDispatcher dispatcher=request.getRequestDispatcher("donhang-list.jsp");
		dispatcher.forward(request, response);
	}
	private void XoaDH(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException, SQLException {
	    int idorder = Integer.parseInt(request.getParameter("idorder"));
	    boolean isDeleted = datHangDao.XoaDH(idorder);

	    if (isDeleted) {
	        request.getSession().setAttribute("message", "Xóa đơn hàng thành công!");
	    } else {
	        request.getSession().setAttribute("message", "Xóa đơn hàng thất bại!");
	    }

	    response.sendRedirect("donhang?action=list"); // Chỉ redirect, không forward
	}

}
