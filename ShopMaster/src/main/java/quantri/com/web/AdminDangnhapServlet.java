package quantri.com.web;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import quantri.com.dao.TaikhoanDao;
import quantri.com.entity.Taikhoan;

import java.io.IOException;


@WebServlet("/login")
public class AdminDangnhapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TaikhoanDao taikhoanDao;  
    
    public AdminDangnhapServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		taikhoanDao=new TaikhoanDao();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		Taikhoan taikhoan=taikhoanDao.validateTaikhoan(username, password);
		//đăng nhập thành công
		if(taikhoan !=null) {
			 HttpSession sessionqt = request.getSession(false);
			 sessionqt.setAttribute("taikhoan", taikhoan);
			 sessionqt.setAttribute("username", username);
			 sessionqt.setAttribute("password", password);
			 sessionqt.setAttribute("idtaikhoan", taikhoan.getIdtaikhoan());
			 if("user".equals(taikhoan.getRole())) {
				 request.setAttribute("error", "Tài khoản không hợp lệ.");
			        request.getRequestDispatcher("login.jsp").forward(request, response);
			 }else {
				 response.sendRedirect("admin.jsp");
			 }
			   // **Tăng bảo mật session**
	            sessionqt.setMaxInactiveInterval(30 * 60); // Hết hạn sau 30 phút
		}else {
			// Xử lý khi đăng nhập thất bại
			if(taikhoanDao.isUsernameExists(username)) {
				request.setAttribute("username", username);
				request.setAttribute("password", password);
			}else {
				request.setAttribute(username, "");
				request.setAttribute(password, "");
			}
			 request.setAttribute("error", "Thông tin không đúng");
			    request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String errorMessage=request.getParameter("logoutMessage");
		if(errorMessage !=null) {
			request.setAttribute("error", errorMessage);
		}
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

}
