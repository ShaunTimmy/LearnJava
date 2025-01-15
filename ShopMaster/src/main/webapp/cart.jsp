<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="quantri.com.entity.CartItem"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>ShopCapy - Giỏ Hàng</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	rel="stylesheet">
<style>
.cart-item {
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 15px;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	background-color: #fff;
}

.cart-item img {
	border-radius: 8px;
	width: 80px;
	height: 80px;
	object-fit: cover;
}

.cart-item-details {
	margin-left: 20px;
	flex: 1;
}

.cart-item-actions {
	display: flex;
	align-items: center;
}

.cart-item-actions a {
	margin: 0 5px;
}

.cart-summary {
	font-size: 1.2rem;
	font-weight: bold;
}

.empty-cart {
	font-size: 1.5rem;
	color: #777;
	text-align: center;
}

.total-price {
	font-size: 1.5rem;
	color: #dc3545;
}

.hero-section {
	padding: 50px 0;
	background-color: #70a1ff;
	color: #fff;
}

.hero-section h1 {
	font-size: 2.5rem;
	font-weight: bold;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>

	<!-- Hero Section -->
	<section class="hero-section text-center">
		<div class="container">
			<h1>Giỏ Hàng Của Bạn</h1>
			<p>
				Tại đây, bạn có thể xem và quản lý các sản phẩm yêu thích đã thêm
				vào giỏ hàng. <br>Hãy kiểm tra kỹ trước khi tiến hành thanh
				toán!
			</p>
		</div>
	</section>

	<div class="container my-4">
		<%
		List<CartItem> listGH = (List<CartItem>) request.getAttribute("listGH");
		DecimalFormat df = new DecimalFormat("#,###");
		double totalAmount = 0;
		int stt = 1;
		%>
		<%
		if (listGH != null && !listGH.isEmpty()) {
		%>
		<div class="cart-items">
			<%
			for (CartItem item : listGH) {
				Sanpham sp = item.getSanpham();
				double itemTotal = sp.getPrice() * item.getSlg();
				totalAmount += itemTotal;
			%>
			<div class="cart-item" data-aos="fade-up">
				<img
					src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sp.getImgfile())%>"
					alt="<%=sp.getProName()%>" />
				<div class="cart-item-details">
					<h5><%=sp.getProName()%></h5>
					<p><%=df.format(sp.getPrice())%>
						VND
					</p>
					<div class="cart-item-actions">
						<a href="giohang?action=decrease&iditem=<%=item.getIditem()%>"
							class="btn btn-sm btn-outline-dark"><i class="fas fa-minus"></i></a>
						<span><%=item.getSlg()%></span> <a
							href="giohang?action=increase&iditem=<%=item.getIditem()%>"
							class="btn btn-sm btn-outline-info"><i class="fas fa-plus"></i></a>
					</div>
				</div>
				<div class="cart-item-actions">
					<p><%=df.format(itemTotal)%>
						VND
					</p>
					<a href="giohang?iditem=<%=item.getIditem()%>&action=delete"
						class="btn btn-sm btn-outline-danger"
						onclick="return confirm('Bạn có muốn xóa giỏ hàng này không ?')"><i
						class="fas fa-trash"></i></a>
				</div>
			</div>
			<%
			}
			%>
			<div class="cart-summary">
				<div class="d-flex justify-content-between">
					<span>TỔNG TIỀN:</span> <span class="total-price"><%=df.format(totalAmount)%>
						VND</span>
				</div>
			</div>
		</div>

		<div class="d-flex justify-content-between align-items-center mt-4">
			<a href="product" class="btn btn-outline-primary"><i
				class="fas fa-arrow-left"></i> Tiếp tục mua sắm</a>
				
				<!-- --DAT HANG --- -->
			<%
			int tonggia = 0;
			int soluong = 0;
			int idproduct = 0;
			Taikhoan taikhoan = (Taikhoan) request.getSession().getAttribute("taikhoan");

			if (taikhoan != null) {
				if (listGH != null && !listGH.isEmpty()) {
					for (CartItem item : listGH) {
				Sanpham sp = item.getSanpham();
				if (sp != null) {
					int itemTotal = sp.getPrice() * item.getSlg();
					tonggia += itemTotal;
					soluong = item.getSlg(); // Số lượng
					idproduct = sp.getIdproduct(); // ID sản phẩm
				}
					}
				}

				// Lưu thông tin vào session
				request.getSession().setAttribute("totalprice", tonggia);
				request.getSession().setAttribute("quantity", soluong);
				request.getSession().setAttribute("idproduct", idproduct);
			%>
			<!-- Chỉ truyền action qua URL -->
			<a href="giohang?action=thanhtoan" class="btn btn-outline-success">
				<i class="fas fa-check"></i> Đặt Hàng
			</a>
			<%
			} else {
			%>
			<div class="alert alert-warning">Vui lòng đăng nhập để thanh
				toán.</div>
			<%
			}
			%>
		</div>
		<!-- --------------------------- -->
		
		<%
		} else {
		%>
		<div class="empty-cart">Giỏ hàng của bạn đang trống.</div>
		<%
		}
		%>
	</div>
	<br>
	<br>
	<jsp:include page="footerpage.jsp"></jsp:include>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"
		integrity="sha384-eMNJoM94Us0i0n5LN1d2Pj9g1rK/HZ3f5PyLr92/9loZ9FqeKk6/7LvK1q/NBXkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhG81rQug4K9ORjNJz8f4pCWIwX1RsjtM6dPZJ29p6EGGoI1LVF2XKD1z04z"
		crossorigin="anonymous"></script>
</body>
</html>
