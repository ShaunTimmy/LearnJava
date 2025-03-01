package nguoidung.com.web;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import quantri.com.entity.Taikhoan;

import java.io.IOException;

/**
 * Servlet Filter implementation class KhachhangFilter
 */
@WebFilter({"/giohang","/wishlist"})
public class KhachhangFilter extends HttpFilter implements Filter {
       
    
    public KhachhangFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	public void destroy() {
		// TODO Auto-generated method stub
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
	        throws IOException, ServletException {
	    HttpServletRequest httRequestKH = (HttpServletRequest) request;
	    HttpServletResponse httResponseKH = (HttpServletResponse) response;
	    HttpSession KHsession = httRequestKH.getSession(false);
	    String requestURIKH = httRequestKH.getRequestURI();
	    String loginPageKH = "/dangnhap.jsp";
	    String loginServletKH = "/dangnhap";

	    // Kiểm tra session và URI
	    boolean loggedInKH = (KHsession != null && KHsession.getAttribute("taikhoan") != null);
	    boolean loginRequestKH = requestURIKH.endsWith(loginPageKH) || requestURIKH.endsWith(loginServletKH);

	    if (loggedInKH) {
	        // Kiểm tra vai trò người dùng
	        Taikhoan taikhoanKH = (Taikhoan) KHsession.getAttribute("taikhoan");
	        String role = taikhoanKH.getRole();

	        // Kiểm tra nếu admin vào trang homepage (khách hàng)
	        if ("admin".equals(role) && requestURIKH.endsWith("homepage.jsp")) {
	            httRequestKH.setAttribute("error", "Bạn không có quyền truy cập vào trang này.");
	            httRequestKH.getRequestDispatcher("dangnhap.jsp").forward(httRequestKH, httResponseKH);
	            return; // Kết thúc để tránh các lệnh sau
	        }
	        // Kiểm tra nếu khách hàng vào trang admin
	        if (!"admin".equals(role) && requestURIKH.endsWith("admin.jsp")) {
	            httRequestKH.setAttribute("error", "Bạn không có quyền truy cập vào trang admin.");
	            httRequestKH.getRequestDispatcher("dangnhap.jsp").forward(httRequestKH, httResponseKH);
	            return; // Kết thúc để tránh các lệnh sau
	        }
	    }

	    // Nếu đã đăng nhập hoặc đang vào trang đăng nhập, tiếp tục xử lý request
	    if (loggedInKH || loginRequestKH) {
	        chain.doFilter(request, response);
	    } else {
	        httResponseKH.sendRedirect(httRequestKH.getContextPath() + loginPageKH);
	    }
	}

}
