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


@WebServlet(name="ProductServlet",value="/product")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public SanphamDao sanphamDao;
       
    
    public ProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		sanphamDao=new SanphamDao();
	}

	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		if (action == null) {
			action = "list";
		}
		try {
			switch(action) {
			case "details":
				showDetails(request, response);
				break;
				case "byCategory":
					showByCategory(request, response);
					break;
				case "search":
					searchSP(request, response);
					break;
				
				default:
					listSP(request, response);
					break;
			}
		}catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("infomal.jsp");
			dispatcher.forward(request, response);
		}
	}
		
	

	private void showDetails(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		int idproduct=Integer.parseInt(request.getParameter("idproduct"));
		Sanpham sanpham=sanphamDao.LaySpTheoID(idproduct);
		request.setAttribute("sanpham", sanpham);
		RequestDispatcher dispatcher=request.getRequestDispatcher("sanpham-details.jsp");
		dispatcher.forward(request, response);
	}

	
	private void searchSP(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
	
		String keyword=request.getParameter("keyword");
	
		List<Sanpham> searchProduct=sanphamDao.CustomersearchProduct(keyword);
		request.setAttribute("listSP", searchProduct);
		request.setAttribute("keyword", keyword);
		RequestDispatcher dispatcher=request.getRequestDispatcher("searrch-list.jsp");
		dispatcher.forward(request, response);
		
	}
	private void showByCategory(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException, SQLException {
	    // Lấy thể loại từ tham số URL
	    String theloai = request.getParameter("theloai");
	  
	    if (theloai == null || theloai.isEmpty()) {
	        // Nếu không có thể loại, có thể redirect hoặc trả về lỗi
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thể loại không hợp lệ.");
	        return;
	    }

	    // Lấy thông tin trang và pageSize từ request (nếu có, nếu không thì mặc định)
	    int page = 1;
	    int pageSize = 3; // Mặc định là 3 sản phẩm mỗi trang
	    if (request.getParameter("page") != null) {
	        page = Integer.parseInt(request.getParameter("page"));
	    }
	    if (request.getParameter("pageSize") != null) {
	        pageSize = Integer.parseInt(request.getParameter("pageSize"));
	    }

	    // Lấy danh sách sản phẩm theo thể loại và phân trang
	    List<Sanpham> proList = sanphamDao.getSanphamByTheloai(theloai, page, pageSize);

	    // Tính tổng số sản phẩm trong thể loại để tính tổng số trang
	    int totalProducts = sanphamDao.getTotalProductsByCategory(theloai);
	    int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

	    // Gửi thông tin sản phẩm và phân trang tới JSP
	    request.setAttribute("productList", proList);
	    request.setAttribute("currentPage", page);
	    request.setAttribute("pageSize", pageSize);
	    request.setAttribute("totalPages", totalPages);
	    request.setAttribute("theloai", theloai);
	    
	    // Chuyển hướng đến trang JSP để hiển thị kết quả
	    RequestDispatcher dispatcher = request.getRequestDispatcher("sanpham-by-category.jsp");
	    dispatcher.forward(request, response);
	}

	///DANH SÁCH TOÀN BỘ SẢN PHẨM
	private void listSP(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		int pageSize=6;
		int pageNumber=1;
		String pageParam=request.getParameter("page");
		if(pageParam !=null && !pageParam.isEmpty()) {
			pageNumber=Integer.parseInt(pageParam);
		}
		// Tính số lượng từ database
		int totalProduct=sanphamDao.CountPrdouduct();
		int totalPages=(int) Math.ceil((double) totalProduct/pageSize);
		int offset=(pageNumber -1)*pageSize;
		List<Sanpham> listSP=sanphamDao.SanphamPhanTrang(offset, pageSize);
		request.setAttribute("listSP", listSP);
		request.setAttribute("currentPage", pageNumber);
		request.setAttribute("totalPages", totalPages);
		RequestDispatcher dispatcher=request.getRequestDispatcher("product-list.jsp");
		dispatcher.forward(request, response);
	}


}
