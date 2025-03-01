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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String username = request.getParameter("username");
        // Gọi phương thức kiểm tra tài khoản từ DAO
        Taikhoan taikhoan = tkDao.validateTaikhoanKH(email, password);

        if (taikhoan != null) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("taikhoan", taikhoan);
            session.setAttribute("email", email);
            session.setAttribute("idtaikhoan", taikhoan.getIdtaikhoan());
            // Chuyển hướng tới trang chính
            response.sendRedirect("homepage");
            // **Tăng bảo mật session**
            session.setMaxInactiveInterval(30 * 60); // Hết hạn sau 30 phút
        } else {
        	if(tkDao.isEmailExists(email)) {
        		request.setAttribute("email", email);
				request.setAttribute("password", password);
        	}else {
				request.setAttribute(email, "");
				request.setAttribute(password, "");
			}
            // Đăng nhập thất bại
            request.setAttribute("error", "Email hoặc mật khẩu không đúng");
            request.getRequestDispatcher("dangnhap.jsp").forward(request, response);
        }
    }


}
