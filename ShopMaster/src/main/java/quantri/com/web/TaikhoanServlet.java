package quantri.com.web;

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
import java.util.List;


@WebServlet(name="TaikhoanServlet",value="/taikhoan")
public class TaikhoanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TaikhoanDao taikhoanDao;
       
    
    public TaikhoanServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		taikhoanDao = new TaikhoanDao();
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		if(action==null) {
			action="list";
		}
		try {
			switch(action) {
			case "delete":
				XoaTT(request, response);
				break;
			case "search":
				searchAccount(request, response);
				break;
			
				default:
					listTK(request, response);
					break;
			}
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
			dispatcher.forward(request, response);
		}
	}

	private void searchAccount(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException{
		// TODO Auto-generated method stub
		String keyword=request.getParameter("keyword");
		List<Taikhoan> searchResult=taikhoanDao.searchAccount(keyword);
		request.setAttribute("listTK", searchResult);
		request.setAttribute("keyword", keyword);
		RequestDispatcher dispatcher=request.getRequestDispatcher("taikhoan-list.jsp");
		dispatcher.forward(request, response);
		
	}


	private void XoaTT(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException{
		// TODO Auto-generated method stub
		int idtaikhoan=Integer.parseInt(request.getParameter("idtaikhoan"));
		taikhoanDao.XoaTaikhoan(idtaikhoan);
		response.sendRedirect("taikhoan?action=list");
		
	}


	private void listTK(HttpServletRequest request, HttpServletResponse response) 
			throws SQLException, ServletException, IOException{
		// TODO Auto-generated method stub
		 int pageSize=3;// Số slg trên mỗi trang
		 int pageNumber=1;// Trang mặc định là trang đầu tiên
		// Lấy số trang từ tham số "page", nếu không có thì mặc định là 1
		String pageParam=request.getParameter("page");
		if(pageParam !=null && !pageParam.isEmpty()) {
			pageNumber=Integer.parseInt(pageParam);
		}
		// Tính số lượng từ database
		int totalTaikhoan=taikhoanDao.countTaikhoan();
		int totalPages=(int) Math.ceil((double) totalTaikhoan/pageSize);
		// Tính toán offset
		int offset=(pageNumber -1)*pageSize;
		// Lấy danh sách sản phẩm của trang hiện tại
		List<Taikhoan> listTK=taikhoanDao.DanhsachPhaTrang(offset, pageSize);
		request.setAttribute("listTK", listTK);
		request.setAttribute("currentPage", pageNumber);
		request.setAttribute("totalPages", totalPages);
		request.getSession().setAttribute("slgdky", totalTaikhoan);
		RequestDispatcher dispatcher=request.getRequestDispatcher("taikhoan-list.jsp");
		dispatcher.forward(request, response);
	}

}
