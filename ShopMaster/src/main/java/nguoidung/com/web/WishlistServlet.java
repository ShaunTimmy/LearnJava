package nguoidung.com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import quantri.com.dao.CartDao;
import quantri.com.dao.SanphamDao;
import quantri.com.dao.WishlistDao;
import quantri.com.entity.Sanpham;
import quantri.com.entity.Taikhoan;
import quantri.com.entity.Wishlist;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet(name="WishlistServlet",value="/wishlist")
public class WishlistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WishlistDao wishDao;
	
       
    
    public WishlistServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		wishDao=new WishlistDao();
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		if(action ==null) {
			action="list";
		}
		try {
			switch(action) {
			case "add":
				ThemDanhSach(request, response);
				break;
			case "delete":
				XoaDS(request, response);
				break;
			
				default:
					listYT(request, response);
					break;
			}
		}catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("infomal.jsp");
			dispatcher.forward(request, response);
	}
	}

	private void XoaDS(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		int idlist=Integer.parseInt(request.getParameter("idlist"));
		wishDao.XoaDS(idlist);
		response.sendRedirect("wishlist?action=list");
		
		
	}


	private void listYT(HttpServletRequest request, HttpServletResponse response)
			 throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		Taikhoan taikhoan=(Taikhoan)request.getSession().getAttribute("taikhoan");
		if(taikhoan !=null) {
			 int pageSize = 6; // Số lượng sản phẩm trên mỗi trang
		    int pageNumber = 1; 
		    // Lấy số trang từ tham số "page", nếu có
	        String pageParam = request.getParameter("page");
	        if (pageParam != null && !pageParam.isEmpty()) {
	            pageNumber = Integer.parseInt(pageParam);
	        }
	        
			int idtaikhoan=taikhoan.getIdtaikhoan();
			 // Tính tổng số wishlist
	        int totalProduct = wishDao.SoluongYT(idtaikhoan);
	        int totalPages = (int) Math.ceil((double) totalProduct / pageSize);
	        
	        // Tính vị trí bắt đầu của trang
	        int offset = (pageNumber - 1) * pageSize;
			List<Wishlist> wishLists=wishDao.DanhsachYeuThich(idtaikhoan, offset, pageSize);
			 // Lấy số lượng wishlist
			int itemCount=wishDao.SoluongYT(idtaikhoan);
			request.setAttribute("wishLists", wishLists);
			request.setAttribute("currentPage", pageNumber);
	        request.setAttribute("totalPages", totalPages);
			request.getSession().setAttribute("itemCount", itemCount);
			RequestDispatcher dispatcher=request.getRequestDispatcher("wishlist.jsp");
			dispatcher.forward(request, response);
		}
		else {
	        // Nếu người dùng chưa đăng nhập, chuyển hướng đến trang đăng nhập
	        response.sendRedirect("dangky.jsp");
	    }
	}


	private void ThemDanhSach(HttpServletRequest request, HttpServletResponse response)
	         throws ServletException, IOException, SQLException {
	     try {
	         String idProductParam = request.getParameter("idproduct");
	         String idTaiKhoanParam = request.getParameter("idtaikhoan");
	         
	         // Validate parameters
	         if (idProductParam == null || idTaiKhoanParam == null) {
	             request.setAttribute("errorMessage", "Missing product or account ID.");
	             RequestDispatcher dispatcher = request.getRequestDispatcher("infomal.jsp");
	             ThemDanhSach(request, response);
	             return;
	         }

	         int idproduct = Integer.parseInt(idProductParam);
	         int idtaikhoan = Integer.parseInt(idTaiKhoanParam);

	         Wishlist wishlist = new Wishlist();
	         wishlist.setSanpham(new Sanpham(idproduct));
	         wishlist.setTaikhoan(new Taikhoan(idtaikhoan));

	         boolean isAdded = wishDao.ThemDanhSach(wishlist);
	         if (isAdded) {
	             request.setAttribute("successMessage", "Thêm sản phẩm yêu thích thành công!");
	             RequestDispatcher dispatcher = request.getRequestDispatcher("wishlist.jsp");
	             listYT(request, response);
	         } else {
	             request.setAttribute("errorMessage", "Không thể thêm sản phẩm yêu thích!");
	             RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
	             dispatcher.forward(request, response);
	         }
	     } catch (NumberFormatException e) {
	         request.setAttribute("errorMessage", "Invalid product or account ID format.");
	         RequestDispatcher dispatcher = request.getRequestDispatcher("infomal.jsp");
	         dispatcher.forward(request, response);
	     }
	 }


}
