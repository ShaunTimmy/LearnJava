package nguoidung.com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import quantri.com.dao.SanphamDao;
import quantri.com.entity.Sanpham;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet implementation class HomePageServlet
 */
@WebServlet(name="HomePageServlet", value="/homepage")
public class HomePageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public SanphamDao sanphamDao;
    
    public HomePageServlet() {
        super();
    }

    public void init(ServletConfig config) throws ServletException {
        sanphamDao = new SanphamDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            listSP(request, response);  // Đảm bảo phương thức này tồn tại
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listSP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // TODO Auto-generated method stub
        List<Sanpham> IntroPro = sanphamDao.selectProductIntro();
        request.setAttribute("intro", IntroPro);
        RequestDispatcher dispatcher = request.getRequestDispatcher("homepage.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
