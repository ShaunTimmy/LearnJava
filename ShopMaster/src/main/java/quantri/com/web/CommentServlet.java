package quantri.com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import quantri.com.dao.ReviewDao;
import quantri.com.entity.Reviews;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet(name="CommentServlet",value="/danhgia")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReviewDao danhgiaDao;   
    
    public CommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		danhgiaDao=new ReviewDao();
	}

	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action=request.getParameter("action");
		if(action==null) {
			action="list";
		}
		try {
			switch(action) {
			case "details":
				ChitietCMT(request, response);
				break;
				case "delete":
					XoaCMT(request, response);
					break;
					default:
						listCMT(request, response);
						break;
			}
		}catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
			dispatcher.forward(request, response);
		}
	}


	private void ChitietCMT(HttpServletRequest request, HttpServletResponse response)
			 throws ServletException, IOException{
		// TODO Auto-generated method stub
		try {
			int idreview=Integer.parseInt(request.getParameter("idreview"));
			Reviews exisCMT=danhgiaDao.ChiTietCMT(idreview);
			if(exisCMT !=null) {
				request.setAttribute("chitietCMT", exisCMT);
				RequestDispatcher dispatcher=request.getRequestDispatcher("reviews-detail.jsp");
				 dispatcher.forward(request, response);
			}else {
	            request.setAttribute("errorMessage", "Đơn hàng không tồn tại.");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
	            dispatcher.forward(request, response);
	        }
		}catch (NumberFormatException e) {
	        request.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ.");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
	        dispatcher.forward(request, response);
	    }
	
		
	}


	private void XoaCMT(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		int idreview=Integer.parseInt(request.getParameter("idreview"));
		danhgiaDao.XoaCMT(idreview);
		response.sendRedirect("danhgia?action=list");
		
	}


	private void listCMT(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		int pageSize=5;
		int pageNumber=1;
		// Lấy số trang từ tham số "page", nếu không có thì mặc định là 1
		String pageParam=request.getParameter("page");
		if(pageParam !=null && !pageParam.isEmpty()) {
			pageNumber=Integer.parseInt(pageParam);
		}
		// Tính số lượng từ database
		int totalCMT=danhgiaDao.TongSoCMT();
		int totalPages=(int) Math.ceil((double) totalCMT/pageSize);
		int offset=(pageNumber -1)*pageSize;
		List<Reviews>  listCMT=danhgiaDao.DanhSachComment(offset, pageSize);
		request.setAttribute("listNX", listCMT);
		request.setAttribute("currentPage", pageNumber);
		request.setAttribute("totalPages", totalPages);
		request.getSession().setAttribute("tongcmt", totalCMT);
		RequestDispatcher dispatcher=request.getRequestDispatcher("review-list.jsp");
		dispatcher.forward(request, response);
	}

}
