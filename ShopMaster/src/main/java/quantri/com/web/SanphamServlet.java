package quantri.com.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import quantri.com.dao.SanphamDao;
import quantri.com.entity.Sanpham;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;
@MultipartConfig() // Giới hạn kích thước file upload
@WebServlet(name = "SanphamServlet", value = "/sanpham")
public class SanphamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public SanphamDao sanphamDao;

	public SanphamServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		sanphamDao = new SanphamDao();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		if (action == null) {
			action = "list";

		}
		try {
			switch (action) {
			case "new":
				showNewForm(request, response);
				break;
			case "insert":
				ThemSanpham(request, response);
				break;
			case "delete":
				XoaSanPham(request, response);
				break;
			case "edit":
				showEditForm(request, response);
				break;
			case "update":
				CapnhatSanPham(request, response);
				break;
			case "search":
				searchSP(request, response);
				break;
			default:
				listSP(request, response);
				break;
			}
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
			dispatcher.forward(request, response);
		}
	}

	

	private void listSP(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stu
		int pageSize=3;
		int pageNumber=1;
		// Lấy số trang từ tham số "page", nếu không có thì mặc định là 1
		String pageParam=request.getParameter("page");
		if(pageParam !=null && !pageParam.isEmpty()) {
			pageNumber=Integer.parseInt(pageParam);
		}
		// Tính số lượng từ database
		int totalProduct=sanphamDao.CountPrdouduct();
		int totalPages=(int) Math.ceil((double) totalProduct/pageSize);
		int offset=(pageNumber -1)*pageSize;
		List<Sanpham> listSP=sanphamDao.DanhsachPhanTrang(offset, pageSize);
		request.setAttribute("listSP", listSP);
		request.setAttribute("currentPage", pageNumber);
		request.setAttribute("totalPages", totalPages);
		RequestDispatcher dispatcher=request.getRequestDispatcher("sanpham-list.jsp");
		dispatcher.forward(request, response);
	}
	private void XoaSanPham(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		int idproduct=Integer.parseInt(request.getParameter("idproduct"));
		sanphamDao.XoaTT(idproduct);
		response.sendRedirect("sanpham?action=list");
		
	}
	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		int idproduct=Integer.parseInt(request.getParameter("idproduct"));
		Sanpham exixSP=sanphamDao.LaySpTheoID(idproduct);
		request.setAttribute("sanpham", exixSP);
		RequestDispatcher dispatcher=request.getRequestDispatcher("sanpham-form.jsp");
		dispatcher.forward(request, response);
		
	}
	private void CapnhatSanPham(HttpServletRequest request, HttpServletResponse response)
			  throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		int idproduct=Integer.parseInt(request.getParameter("idproduct"));
		String proName=request.getParameter("proName");
		String  description=request.getParameter("description");
		int price=Integer.parseInt(request.getParameter("price"));
		int stock=Integer.parseInt(request.getParameter("stock"));
		String thoigianGH=request.getParameter("thoigianGH");
		String theloai=request.getParameter("theloai");
		byte[] imgfile=processFileUpload(request);
		Sanpham existingProduct=sanphamDao.LaySpTheoID(idproduct);
		if(imgfile ==null) {
			imgfile=existingProduct.getImgfile();
		}
		Sanpham sanpham=new Sanpham(idproduct, proName, description, imgfile, price, stock, thoigianGH, theloai);
		sanphamDao.CapnhatSP(sanpham);
		response.sendRedirect("sanpham?action=list");
	}
	private void searchSP(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException{
		// TODO Auto-generated method stub
		String keyword=request.getParameter("keyword");
		List<Sanpham> searchResult=sanphamDao.searchProduct(keyword);
		request.setAttribute("listSP", searchResult);
		request.setAttribute("keyword", keyword);
		RequestDispatcher dispatcher=request.getRequestDispatcher("sanpham-list.jsp");
		dispatcher.forward(request, response);
		
	}
	private void ThemSanpham(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException{
		// TODO Auto-generated method stub
		String  proName=request.getParameter("proName");
		String  description=request.getParameter("description");
		byte[] imgfile=processFileUpload(request);
		int price=Integer.parseInt(request.getParameter("price"));
		int stock=Integer.parseInt(request.getParameter("stock"));
		String thoigianGH=request.getParameter("thoigianGH");
		String theloai=request.getParameter("theloai");
		Sanpham newSanpham=new Sanpham(proName, description, imgfile, price, stock, thoigianGH, theloai);
		sanphamDao.ThemSP(newSanpham);
		response.sendRedirect("sanpham?action=list");
		
	}
	private void showNewForm(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    RequestDispatcher dispatcher = request.getRequestDispatcher("sanpham-form.jsp");
	    dispatcher.forward(request, response);
	}

	// Xử lý upload ảnh và trả về byte array của ảnh
	private byte[] processFileUpload(HttpServletRequest request) throws IOException, ServletException {
		// TODO Auto-generated method stub
		Part filePart=request.getPart("imgfile");
		if(filePart !=null && filePart.getSize() > 0) {
			InputStream inputStream= filePart.getInputStream();
					return inputStream.readAllBytes();
		}else {
		return null;
		}
	}
	

}
