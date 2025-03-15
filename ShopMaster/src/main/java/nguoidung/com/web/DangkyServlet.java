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
import send.email.com.EmailUtil;

import java.io.IOException;
import java.sql.SQLException;

import javax.mail.MessagingException;



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
         
            // Gửi email xác nhận đăng ký
            String subject = "Chào mừng " + username + " đến với hệ thống!";
         // Nội dung email với Bootstrap
            String message = "<!DOCTYPE html>"
                    + "<html lang='vi'>"
                    + "<head>"
                    + "<meta charset='UTF-8'>"
                    + "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                    + "<title>Đăng ký thành công</title>"
                    + "<style>"
                    + "body { font-family: Arial, sans-serif; background-color: #f8f9fa; padding: 20px; }"
                    + ".container { max-width: 600px; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }"
                    + ".header { background-color: #007bff; color: white; padding: 10px; text-align: center; border-radius: 10px 10px 0 0; }"
                    + ".content { padding: 20px; }"
                    + ".button { display: inline-block; padding: 10px 20px; margin-top: 15px; background-color: #28a745; color: white; text-decoration: none; border-radius: 5px; }"
                    + ".footer { text-align: center; margin-top: 20px; font-size: 12px; color: #6c757d; }"
                    + "</style>"
                    + "</head>"
                    + "<body>"
                    + "<div class='container'>"
                    + "<div class='header'><h2>Chào mừng " + username + "!</h2></div>"
                    + "<div class='content'>"
                    + "<p>Bạn đã đăng ký tài khoản thành công trên hệ thống của chúng tôi.</p>"
                    + "<h4>Thông tin tài khoản của bạn:</h4>"
                    + "<ul>"
                    + "<li><strong>Email:</strong> " + email + "</li>"
                    + "<li><strong>Số điện thoại:</strong> " + sdt + "</li>"
                    + "</ul>"
                    + "</div>"
                    + "<div class='footer'>"
                    + "<p>Trân trọng,<br><strong>Đội ngũ hỗ trợ</strong></p>"
                    + "</div>"
                    + "</div>"
                    + "</body>"
                    + "</html>";

            EmailUtil.sendEmail(email, subject, message);

            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng kiểm tra email của bạn.");
            
            // Hiển thị thông báo thành công
            request.setAttribute("successMessage", "Đăng ký thành công!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("dangky.jsp");
           response.sendRedirect("dangnhap.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý đăng ký.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        } catch (MessagingException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đăng ký thành công nhưng không thể gửi email.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("dangky.jsp");
            dispatcher.forward(request, response);
        }
    }
}
