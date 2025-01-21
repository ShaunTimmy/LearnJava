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
			 HttpSession session = request.getSession();
			 session.setAttribute("taikhoan", taikhoan);
			 session.setAttribute("username", username);
			 session.setAttribute("password", password);
			 session.setAttribute("idtaikhoan", taikhoan.getIdtaikhoan());
			 if("user".equals(taikhoan.getRole())) {
				 request.setAttribute("error", "Tài khoản của bạn không có quyền truy cập vào trang này.");
			        request.getRequestDispatcher("login.jsp").forward(request, response);
			 }else {
				 response.sendRedirect("admin.jsp");
			 }
		}else {
			// Xử lý khi đăng nhập thất bại
			if(taikhoanDao.isUsernameExists(username)) {
				request.setAttribute("username", username);
				request.setAttribute("password", password);
			}else {
				request.setAttribute(username, "");
				request.setAttribute(password, "");
			}
			 request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
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
