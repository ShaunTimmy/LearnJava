package quantri.com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import quantri.com.dao.TaikhoanDao;
import quantri.com.entity.Taikhoan;

import java.io.IOException;
import java.sql.SQLException;


@WebServlet(name="AdminDoiMatKhauServlet",value="/matkhau")
public class AdminDoiMatKhauServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TaikhoanDao taikhoanDao;  
   
    public AdminDoiMatKhauServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		taikhoanDao=new TaikhoanDao();
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		if(action ==null) {
			action="list";
		}
		try {
			switch(action) {
			case "infor":
				Thongtin(request, response);
				break;
			case "update":
				CapnhatMK(request, response);
				break;
			case "informa":
				ThongtinTK(request, response);
				break;
				default:
					break;
			}
		}catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("infomal.jsp");
			dispatcher.forward(request, response);
	}

}


	private void ThongtinTK(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		String username=request.getParameter("username");
		String address=request.getParameter("address");
		String email=request.getParameter("email");
		String sdt=request.getParameter("sdt");
		int idtaikhoan=Integer.parseInt(request.getParameter("idtaikhoan"));
		Taikhoan tkhoan=new Taikhoan(idtaikhoan, username, address, email, sdt);
		taikhoanDao.CapnhatTT(tkhoan);
		response.sendRedirect("login.jsp");
	}


	private void CapnhatMK(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException, SQLException {
	    String password = request.getParameter("password");
	    String idtaikhoanStr = request.getParameter("idtaikhoan");

	    if (idtaikhoanStr == null || idtaikhoanStr.isEmpty()) {
	        request.setAttribute("errorMessage", "ID tài khoản không hợp lệ.");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("infomal.jsp");
	        dispatcher.forward(request, response);
	        return; // Dừng xử lý
	    }

	    try {
	        int idtaikhoan = Integer.parseInt(idtaikhoanStr);
	        Taikhoan tk = new Taikhoan(idtaikhoan, password);
	        taikhoanDao.CapnhatMatkhau(tk);
	        response.sendRedirect("login.jsp");
	    } catch (NumberFormatException e) {
	        request.setAttribute("errorMessage", "ID tài khoản phải là số.");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
	        dispatcher.forward(request, response);
	    }
	}



	private void Thongtin(HttpServletRequest request, HttpServletResponse response) 
			 throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		Taikhoan taikhoan = (Taikhoan) request.getSession().getAttribute("taikhoan");
	    if (taikhoan != null) {
	        String idtaikhoanStr = request.getParameter("idtaikhoan");

	        // Kiểm tra nếu idtaikhoan không tồn tại hoặc rỗng
	        if (idtaikhoanStr == null || idtaikhoanStr.isEmpty()) {
	            request.setAttribute("errorMessage", "ID tài khoản không hợp lệ.");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
	            dispatcher.forward(request, response);
	            return; // Dừng xử lý
	        }

	        try {
	            int idtaikhoan = Integer.parseInt(idtaikhoanStr);
	            Taikhoan tk = taikhoanDao.ThongTinTK(idtaikhoan);
	            if (tk != null) {
	                request.setAttribute("taikhoan", tk);
	                RequestDispatcher dispatcher = request.getRequestDispatcher("taikhoanadmin.jsp");
	                dispatcher.forward(request, response);
	            } else {
	                request.setAttribute("errorMessage", "Không tìm thấy tài khoản.");
	                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
	                dispatcher.forward(request, response);
	            }
	        } catch (NumberFormatException e) {
	            request.setAttribute("errorMessage", "ID tài khoản không hợp lệ.");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
	            dispatcher.forward(request, response);
	        }
	    } else {
	        // Nếu người dùng chưa đăng nhập, chuyển hướng đến trang đăng nhập
	        response.sendRedirect("login.jsp");
	    }
	}
}
