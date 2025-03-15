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
import quantri.com.dao.DatHangDao;
import quantri.com.dao.SanphamDao;
import quantri.com.dao.TaikhoanDao;
import quantri.com.entity.CartItem;
import quantri.com.entity.Orders;
import quantri.com.entity.Sanpham;
import quantri.com.entity.Taikhoan;
import send.email.com.EmailUtil;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

import javax.mail.MessagingException;


@WebServlet(name="CartServlet",value="/giohang")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CartDao cartDao;
	 private DatHangDao datHangDao;
	 private SanphamDao sanphamDao;
	 private TaikhoanDao taikhoanDao;
    public CartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		cartDao = new CartDao();
		datHangDao=new DatHangDao();
		sanphamDao=new SanphamDao();
		taikhoanDao=new TaikhoanDao();
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
			switch (action) {
			case "add":
				AddCart(request, response);
				break;
			case "delete":
				XoaTT(request, response);
				break;
			case "decrease":
				giamSoLuong(request, response);
				break;
			case "increase":
				tangSoLuong(request, response);
				break;
			case "thanhtoan":
				  DatHang(request, response);
				break;
			case "thanhcong":
				DathangThanhcong(request, response);
				break;
			case "huydon":
				HuyDonHang(request, response);
				break;
			default:
				listGH(request, response);
				break;
			}
		} catch (SQLException | ServletException | IOException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("infomal.jsp");
			dispatcher.forward(request, response);
		}
	}


	private void HuyDonHang(HttpServletRequest request, HttpServletResponse response)
			 throws ServletException, IOException{
		// TODO Auto-generated method stub
		  
		        // Lấy thông tin tài khoản từ session
			   HttpSession sessionObj = request.getSession();
			  Integer  idtaikhoan = (Integer) sessionObj.getAttribute("idtaikhoan");
		        if (idtaikhoan == null) {
		            response.sendRedirect("dangnhap.jsp");
		            return;
		        }
		        int idorder=Integer.parseInt(request.getParameter("idorder"));
		        boolean huydh=datHangDao.cancelOrder(idorder, idtaikhoan);
		        if (huydh) {
		            request.setAttribute("message", "Đã hủy đơn hàng thành công!");
		        } else {
		            request.setAttribute("message", "Hủy đơn hàng thất bại hoặc đơn hàng đã bị hủy trước đó.");
		        }

		        request.getRequestDispatcher("orderlist.jsp").forward(request, response);
	}


	private void DathangThanhcong(HttpServletRequest request, HttpServletResponse response) 
			 throws ServletException, IOException{
		// TODO Auto-generated method stub
		 try {
	            // Lấy id tài khoản từ yêu cầu
	            int idtaikhoan = Integer.parseInt(request.getParameter("idtaikhoan"));

	            // Gọi DAO để lấy đơn hàng gần nhất
	            Orders donhang = datHangDao.getLatestOrder(idtaikhoan);

	            if (donhang != null) {
	                // Nếu có đơn hàng, chuyển thông tin vào request
	                request.setAttribute("message", "Đặt hàng thành công!");
	                request.setAttribute("thanhcong", donhang);
	                request.getRequestDispatcher("success.jsp").forward(request, response);
	            } else {
	                // Nếu không tìm thấy đơn hàng
	                request.setAttribute("error", "Không tìm thấy đơn hàng nào.");
	                request.getRequestDispatcher("infomal.jsp").forward(request, response);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
	            request.getRequestDispatcher("infomal.jsp").forward(request, response);
	        }
		
		
	}

	private void DatHang(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    try {
	        // Lấy thông tin tài khoản từ session
	        Taikhoan taikhoan = (Taikhoan) request.getSession().getAttribute("taikhoan");
	        if (taikhoan == null) {
	            response.sendRedirect("dangnhap.jsp");
	            return;
	        }

	        // Lấy thông tin từ session
	        Integer productId = (Integer) request.getSession().getAttribute("idproduct");
	        Integer quantity = (Integer) request.getSession().getAttribute("quantity");
	        Integer totalPrice = (Integer) request.getSession().getAttribute("totalprice");

	        if (productId == null || quantity == null || totalPrice == null) {
	            request.setAttribute("errorMessage", "Thông tin đơn hàng không đầy đủ. Vui lòng thử lại!");
	            request.getRequestDispatcher("infomal.jsp").forward(request, response);
	            return;
	        }
	       

	        // Tạo đối tượng đơn hàng
	        Orders donhang = new Orders();
	        donhang.taikhoan = taikhoan;
	        donhang.sanpham = new Sanpham();
	        donhang.sanpham.setIdproduct(productId);
	        donhang.setQuantity(quantity);
	        donhang.totalprice = totalPrice;
	        donhang.statu = "Pending";

	        // Lưu đơn hàng vào cơ sở dữ liệu
	        int idorder = datHangDao.insertOrder(donhang);

	        if (idorder > 0) {
	            // Xóa giỏ hàng khỏi cơ sở dữ liệu sau khi thanh toán thành công
	            int idcart = cartDao.getCartByUserId(taikhoan.getIdtaikhoan());
	            if (idcart != -1) {
	                // Xóa tất cả sản phẩm trong giỏ hàng
	                cartDao.clearCart(idcart);
	            }

	            // Xóa giỏ hàng khỏi session
	            request.getSession().removeAttribute("listGH");
	            request.getSession().removeAttribute("soluong");
	            request.getSession().removeAttribute("idproduct");
	            request.getSession().removeAttribute("quantity");
	            request.getSession().removeAttribute("totalprice");
	            //SAU KHI ĐẶT HÀNG THÀNH CÔNG 
	            Orders thanhcong = datHangDao.getLatestOrder(taikhoan.getIdtaikhoan());
	            donhang.setCodeorder(thanhcong.getCodeorder());  // Set the codeorder from the latest order
	         // Gửi email xác nhận đặt hàng
	            String subject = "Xác nhận đơn hàng #" + donhang.getCodeorder();
	            String messageBody = "<html><head>"
	                    + "<meta name='viewport' content='width=device-width, initial-scale=1'>"
	                    + "<style>"
	                    + "body { font-family: Arial, sans-serif; background-color: #f8f9fa; margin: 0; padding: 20px; }"
	                    + ".container { max-width: 600px; background: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }"
	                    + ".header { background-color: #007bff; color: #ffffff; padding: 15px; text-align: center; font-size: 20px; font-weight: bold; border-radius: 8px 8px 0 0; }"
	                    + ".content { padding: 20px; }"
	                    + ".table { width: 100%; border-collapse: collapse; margin-top: 15px; }"
	                    + ".table th, .table td { border: 1px solid #ddd; padding: 10px; text-align: center; }"
	                    + ".table th { background-color: #007bff; color: white; }"
	                    + ".footer { margin-top: 20px; font-size: 12px; color: #777; text-align: center; }"
	                    + "</style>"
	                    + "</head><body>"
	                    + "<div class='container'>"
	                    + "<div class='header'>Xác Nhận Đơn Hàng #" + donhang.getCodeorder() + "</div>"
	                    + "<div class='content'>"
	                    + "<p>Xin chào <strong>" + taikhoan.getUsername() + "</strong>,</p>"
	                    + "<p>Cảm ơn bạn đã đặt hàng tại cửa hàng của chúng tôi! Dưới đây là thông tin đơn hàng của bạn:</p>"
	                    + "<table class='table'>"
	                    + "<tr><th>Mã đơn hàng</th><th>Số lượng</th><th>Tổng tiền</th></tr>"
	                    + "<tr><td>" + donhang.getCodeorder() + "</td><td>" + donhang.getQuantity() + "</td><td>" + donhang.totalprice + " VND</td></tr>"
	                    + "</table>"
	                    + "<p>Đơn hàng của bạn đang được xử lý. Chúng tôi sẽ sớm liên hệ với bạn.</p>"
	                    + "<p><strong>Trân trọng,</strong><br> Cửa hàng của chúng tôi</p>"
	                    + "</div>"
	                    + "<div class='footer'>Đây là email tự động, vui lòng không trả lời.</div>"
	                    + "</div>"
	                    + "</body></html>";


	            try {
	            	Taikhoan fullAccount = taikhoanDao.ThongTinTK(taikhoan.getIdtaikhoan()); // Lấy tài khoản đầy đủ
	            	String email = fullAccount.getEmail();
	            	if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
	            	    System.out.println("Email không hợp lệ: " + email);
	            	    request.setAttribute("errorMessage", "Email không hợp lệ. Vui lòng kiểm tra lại!");
	            	    request.getRequestDispatcher("infomal.jsp").forward(request, response);
	            	    return;
	            	}
	            	EmailUtil.sendEmail(email, subject, messageBody);
	                System.out.println("Email xác nhận đơn hàng đã được gửi đến: " + taikhoan.getEmail());
	            } catch (MessagingException e) {
	                e.printStackTrace();
	                System.out.println("Gửi email thất bại.");
	            }
	            request.setAttribute("thanhcong", donhang);
	            // Chuyển hướng về trang chủ
	            request.getRequestDispatcher("success.jsp").forward(request, response);
	        } else {
	            request.setAttribute("errorMessage", "Không thể tạo đơn hàng. Vui lòng thử lại!");
	            request.getRequestDispatcher("infomal.jsp").forward(request, response);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý đơn hàng. Vui lòng thử lại!");
	        request.getRequestDispatcher("informal.jsp").forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMessage", "Đã xảy ra lỗi không mong muốn. Vui lòng thử lại!");
	        request.getRequestDispatcher("infomal.jsp").forward(request, response);
	    }
	}





	private void giamSoLuong(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException, SQLException {
	    int iditem = Integer.parseInt(request.getParameter("iditem"));
	    CartItem cartItem = cartDao.getCartItemById(iditem);
	    
	    if (cartItem != null && cartItem.getSlg() > 1) {
	        int Slggiam = cartItem.getSlg() - 1;
	        cartItem.setSlg(Slggiam);
	        
	        // Cập nhật lại số lượng vào cơ sở dữ liệu
	        boolean updated = cartDao.updateCartItem(cartItem);
	        if (!updated) {
	            throw new SQLException("Cập nhật số lượng giảm không thành công.");
	        }
	    }
	    
	    response.sendRedirect("giohang?action=list");
	}

	private void tangSoLuong(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException, SQLException {
	    int iditem = Integer.parseInt(request.getParameter("iditem"));
	    CartItem cartItem = cartDao.getCartItemById(iditem);
	    
	    if (cartItem != null) {
	        // Kiểm tra nếu số lượng chưa đạt 10 mới cho phép tăng
	        if (cartItem.getSlg() < 10) {
	            int Slgtang = cartItem.getSlg() + 1;
	            cartItem.setSlg(Slgtang);
	            
	            // Cập nhật lại số lượng vào cơ sở dữ liệu
	            boolean updated = cartDao.updateCartItem(cartItem);
	            if (!updated) {
	                throw new SQLException("Cập nhật số lượng tăng không thành công.");
	            }
	        } else {
	            // Nếu số lượng đã đạt 10, thông báo hoặc xử lý thêm nếu cần
	            request.setAttribute("error", "Số lượng sản phẩm tối đa là 10.");
	        }
	    }
	    
	    response.sendRedirect("giohang?action=list");
	}


	private void XoaTT(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		int iditem=Integer.parseInt(request.getParameter("iditem"));
		cartDao.XoaGH(iditem);
		response.sendRedirect("giohang?action=list");
		
	}

	private void listGH(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		// TODO Auto-generated method stub
		Taikhoan taikhoan = (Taikhoan) request.getSession().getAttribute("taikhoan");
		if (taikhoan != null) {
			int idtaikhoan = taikhoan.getIdtaikhoan();
			int idcart = cartDao.getCartByUserId(idtaikhoan);
			if (idcart != -1) {
				List<CartItem> listGH = cartDao.DanhsachGH(idcart);
				 // Lấy số lượng 
				int soluong=cartDao.SoluongGH(idcart);
				request.setAttribute("listGH", listGH);
				request.getSession().setAttribute("soluong", soluong);
				RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
				dispatcher.forward(request, response);
			} else {
				// Nếu không tìm thấy giỏ hàng
				request.setAttribute("message", "Không tìm thấy giỏ hàng!");
				RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
				dispatcher.forward(request, response);

			}
		} else {
			// Nếu người dùng chưa đăng nhập, chuyển hướng tới trang đăng nhập
			response.sendRedirect("dangky.jsp");
		}
	}

	private void AddCart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		HttpSession session = request.getSession();
		Taikhoan taikhoan = (Taikhoan) session.getAttribute("taikhoan");
		if (taikhoan == null) {
			response.sendRedirect("dangky");
			return;
		}

		int idproduct = Integer.parseInt(request.getParameter("idproduct"));
		int slg = Integer.parseInt(request.getParameter("slg"));

		try {
			Integer idcart = (Integer) session.getAttribute("currentCartId");
			if (idcart == null || idcart == 0) {
				idcart = cartDao.getCartByUserId(taikhoan.getIdtaikhoan());// Tạo giỏ hàng mới
				// Lưu ID giỏ hàng vào session
			}
			if (idcart == null) {
				idcart = cartDao.createCart(taikhoan);
			}
			session.setAttribute("currentCartId", idcart);
			boolean success = cartDao.addCartItem(idcart, idproduct, slg); // Thêm sản phẩm vào giỏ
			if (success) {
				response.sendRedirect("giohang?action=list");
			} else {
				throw new SQLException("Không thể thêm sản phẩm vào giỏ hàng.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
			dispatcher.forward(request, response);
		}
	}
	}


