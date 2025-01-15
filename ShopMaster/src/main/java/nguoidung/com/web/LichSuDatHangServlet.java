package nguoidung.com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
	}
}
