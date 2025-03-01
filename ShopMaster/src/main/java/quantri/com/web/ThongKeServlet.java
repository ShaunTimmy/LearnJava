package quantri.com.web;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import quantri.com.dao.DatHangDao;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;


@WebServlet(name="ThongKeServlet", value="/thongke")
public class ThongKeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DatHangDao datHangDao;   
   
    public ThongKeServlet() {
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
		  Map<String, Integer> doanhThuData = datHangDao.TongDoanhThuTheoThang();
	        
	        // Đặt dữ liệu vào request
	        request.setAttribute("doanhThuData", doanhThuData);
	        
	        // Chuyển hướng đến trang JSP
	        request.getRequestDispatcher("doanhthu.jsp").forward(request, response);
	}

}
