package nguoidung.com.web;

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

@WebServlet(name = "DangkyServlet", value = "/dangky")
public class DangkyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TaikhoanDao taikhoanDao;

    public DangkyServlet() {
        super();
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        taikhoanDao = new TaikhoanDao();
    }

    // Hiển thị trang đăng ký
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Điều hướng đến trang đăng ký
            RequestDispatcher dispatcher = request.getRequestDispatcher("dangky.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("infomal.jsp");
            dispatcher.forward(request, response);
        }
    }

    // Xử lý đăng ký tài khoản
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy thông tin từ form
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String sdt = request.getParameter("sdt");
            String role = request.getParameter("role");

            // Tạo đối tượng tài khoản
            Taikhoan newTaikhoan = new Taikhoan(username, password, address, email, sdt, role);

            // Gọi DAO để lưu tài khoản
            taikhoanDao.DangKyTaiKhoan(newTaikhoan);

            // Hiển thị thông báo thành công
            request.setAttribute("successMessage", "Đăng ký thành công!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("dangky.jsp");
           response.sendRedirect("dangnhap.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý đăng ký.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
