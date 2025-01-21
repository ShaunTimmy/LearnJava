package nguoidung.com.web;

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

@WebServlet("/dangnhap")
public class KhachhangLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TaikhoanDao tkDao;

    public KhachhangLogin() {
        super();
    }

    public void init(ServletConfig config) throws ServletException {
        tkDao = new TaikhoanDao(); // Khởi tạo DAO
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Gọi phương thức kiểm tra tài khoản từ DAO
        Taikhoan taikhoan = tkDao.validateTaikhoan(username, password);

        if (taikhoan != null) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("taikhoan", taikhoan);
            session.setAttribute("username", username);
            session.setAttribute("idtaikhoan", taikhoan.getIdtaikhoan());
            // Chuyển hướng tới trang chính
            response.sendRedirect("homepage");
        } else {
        	if(tkDao.isUsernameExists(username)) {
        		request.setAttribute("username", username);
				request.setAttribute("password", password);
        	}else {
				request.setAttribute(username, "");
				request.setAttribute(password, "");
			}
            // Đăng nhập thất bại
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.getRequestDispatcher("dangnhap.jsp").forward(request, response);
        }
    }
}
