package nguoidung.com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import quantri.com.dao.DatHangDao;
import quantri.com.entity.Orders;
import quantri.com.entity.Taikhoan;

import java.io.IOException;
import java.util.List;


@WebServlet(name="LichSuDatHangServlet",value="/lichsu")
public class LichSuDatHangServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DatHangDao datHangDao;   
    
    public LichSuDatHangServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		datHangDao=new DatHangDao();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String action = request.getParameter("action");
	        if ("huydon".equals(action)) {
	            HuyDonHang(request, response);
	        } else {
	            doGet(request, response);
	        }
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Taikhoan taikhoan=(Taikhoan)request.getSession().getAttribute("taikhoan");
		if(taikhoan !=null) {
			int idtaikhoan=taikhoan.getIdtaikhoan();
			List<Orders> lichsuOrders=datHangDao.LichSuDatHang(idtaikhoan);
			request.setAttribute("lichsu", lichsuOrders);
			RequestDispatcher dispatcher=request.getRequestDispatcher("orderlist.jsp");
			dispatcher.forward(request, response);
		}else {
	        response.sendRedirect("dangnhap.jsp");
	    }
	
	}
	private void HuyDonHang(HttpServletRequest request, HttpServletResponse response)
			 throws ServletException, IOException{
		// TODO Auto-generated method stub
		  
		        // Lấy thông tin tài khoản từ session
			   HttpSession sessionObj = request.getSession();
			  Integer  idtaikhoan = (Integer) sessionObj.getAttribute("idtaikhoan");
		        if (idtaikhoan == null) {
		            response.sendRedirect("dangnhap.jsp");
		            return;
		        }
		        int idorder=Integer.parseInt(request.getParameter("idorder"));
		        boolean huydh=datHangDao.cancelOrder(idorder, idtaikhoan);
		        if (huydh) {
		            request.setAttribute("message", "Đã hủy đơn hàng thành công!");
		        } else {
		            request.setAttribute("message", "Hủy đơn hàng thất bại hoặc đơn hàng đã bị hủy trước đó.");
		        }

		        request.getRequestDispatcher("lichsu?action=list").forward(request, response);
	}


	
}
