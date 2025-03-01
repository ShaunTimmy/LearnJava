package quantri.com.web;

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


@WebFilter({"/admin","/sanpham", "/taikhoan", "/donhang", "/thongke", "/danhgia"})
public class AdminLoginFilter extends HttpFilter implements Filter {
       
    
    public AdminLoginFilter() {
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
	    HttpServletRequest httRequest = (HttpServletRequest) request;
	    HttpServletResponse httResponse = (HttpServletResponse) response;
		
	    HttpSession session = httRequest.getSession(false);
	    String requestURI = httRequest.getRequestURI();
	    
	    String loginPage = "/login.jsp";
	    String loginServlet = "/login";
	    
	    // Kiểm tra session và URI
	    boolean loggedIn = (session != null && session.getAttribute("taikhoan") != null);
	    boolean loginRequest = requestURI.endsWith(loginPage) || requestURI.endsWith(loginServlet);

	    if(loggedIn) {
	    	 // Kiểm tra vai trò người dùng
	    	Taikhoan taikhoan=(Taikhoan) session.getAttribute("taikhoan");
	    	String role=taikhoan.getRole();
	    	if("user".equals(role)&& requestURI.endsWith("admin.jsp")) {
	    		  // Chuyển hướng về login.jsp với thông báo lỗi
	            httRequest.setAttribute("error", "Tài khoản của bạn không có quyền truy cập vào trang này.");
	            httRequest.getRequestDispatcher("login.jsp").forward(httRequest, httResponse);
	            return; // Kết thúc để tránh các lệnh sau
	    	}
	    }
	    if(loggedIn || loginRequest) {
		chain.doFilter(request, response);// Cho phép tiếp tục
	    }else {
	        httResponse.sendRedirect(httRequest.getContextPath() + loginPage);
	    }
	    
	}


	

}
