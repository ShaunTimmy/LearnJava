<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ShopCapy</title>
<!-- CSS liên kết -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"
	rel="stylesheet">
<style>
.about-section {
	border: 2px solid #007bff;
	border-radius: 10px;
	padding: 20px;
	margin: 20px auto;
}

.bg-light.py-5.h-60 {
	background: url('img/banner.webp') no-repeat center center;
	background-size: cover;
	padding: 80px 0;
	text-align: center;
	color: #ffffff;
	transform: translateY(2px);
	height: 110%;
}

.bg-light.py-5.h-60::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.4);
	z-index: 1;
}

.container {
	position: relative;
	z-index: 2;
}

.card {
	border: none;
	box-shadow: none;
	width: 100%;
	height: 200px;
}

.card-img-top {
	width: 100%;
	height: 200px;
}

.card-body {
	flex-grow: 1;
}

.card-text {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.col-md-4 {
	display: flex;
	justify-content: space-between;
}

.image-container {
	position: relative;
	overflow: hidden;
}

.product-img {
	width: 100%;
	height: auto;
	transition: transform 0.3s ease-in-out;
}

.overlay-buttons {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	display: none;
	gap: 10px;
	z-index: 10;
}

.image-container:hover .overlay-buttons {
	display: flex;
}

.image-container:hover .product-img {
	transform: scale(1.1);
}

.overlay-buttons a {
	background-color: rgba(255, 255, 255, 0.8);
	padding: 5px 10px;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.overlay-buttons a:hover {
	background-color: rgba(0, 123, 255, 0.7);
}

.container.text-center {
	margin-top: 92px;
}

.card {
	transition: transform 0.3s;
}

.card:hover {
	transform: scale(1.1);
}

.view-more-btn {
	transition: all 0.3s ease;
	border-radius: 25px;
	padding: 10px 30px;
}

.view-more-btn:hover {
	background-color: #007bff;
	color: white;
	transform: scale(1.1);
	box-shadow: 0 4px 10px rgba(0, 123, 255, 0.5);
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>

	<!-- Giới Thiệu Cửa Hàng -->
	<section class="bg-light py-5 h-60">
		<div class="container text-center">
			<h1>Chào Mừng Đến Với Cửa Hàng Của Chúng Tôi</h1>
			<p>Chúng tôi chuyên cung cấp các sản phẩm điện tử, gia dụng và
				phụ kiện chất lượng cao, giá cả hợp lý, phục vụ nhu cầu của mọi gia
				đình và doanh nghiệp.</p>
			<p>Với đội ngũ nhân viên tận tâm và kinh nghiệm, chúng tôi cam
				kết mang đến cho khách hàng trải nghiệm mua sắm trực tuyến an toàn
				và thuận tiện.</p>
			<p>Hãy khám phá các sản phẩm của chúng tôi và tận hưởng dịch vụ
				tuyệt vời ngay hôm nay!</p>
		</div>
	</section>
	<br>
	<br>

	<!-- Sản Phẩm Giới Thiệu -->
	<section class="container py-5">
		<h1 class="text-center">Sản Phẩm Đặc Biệt Cho Bạn</h1>
		<br>
		<div class="row">
			<%
			List<Sanpham> introPro = (List<Sanpham>) request.getAttribute("intro");
			DecimalFormat decimalFormat = new DecimalFormat("#,###");

			if (introPro != null && !introPro.isEmpty()) {
				for (Sanpham sp : introPro) {
			%>
			<div class="col-md-4 mb-4" data-aos="flip-left">
				<div class="card">
					<!-- Hình Ảnh -->
					<div class="image-container">
						<img
							src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sp.getImgfile())%>"
							class="card-img-top product-img" alt="<%=sp.getProName()%>">
						<div class="overlay-buttons">
							<a
								href="product?action=details&idproduct=<%=sp.getIdproduct()%>"
								class="btn btn-outline-info btn-sm"> <i
								class="fa-solid fa-eye"> </i> Xem
							</a>
							<%
							Taikhoan tk = (Taikhoan) session.getAttribute("taikhoan");
							String link = "review?action=add&idproduct=" + sp.getIdproduct();
							boolean isDisabled = (tk == null); // Disable the button if no user is logged in
							%>
							<a href="<%=link%>"
								class="btn btn-outline-success btn-sm ms-1 <%=isDisabled ? "disabled" : ""%>"
								<%=isDisabled ? "aria-disabled='true' tabindex='-1'" : ""%>>
								<i class="fa-solid fa-comment"></i> Đánh giá
							</a>
						</div>
					</div>
					<!-- Thông Tin SP -->
					<div class="card-body">
						<h5 class="card-title"><%=sp.getProName()%></h5>
						<p class="card-text">
							<strong>Giá: </strong><%=decimalFormat.format(sp.getPrice())%>
							VND
						</p>
						<div class="d-flex justify-content-between">
							<%
							Taikhoan taikhoan = (Taikhoan) session.getAttribute("taikhoan");
							if (taikhoan != null) {
								int idtaikhoan = taikhoan.getIdtaikhoan();
							%>
							<!-- -THÊM GIỎ HÀNG -->
							<form action="cart?action=add" method="GET"
								class="d-flex align-items-center">
								<input type="hidden" name="action" value="add"> <input
									type="hidden" name="idproduct" value="<%=sp.getIdproduct()%>">
								<input type="hidden" name="slg" value="1" min="1"
									class="form-control form-control-sm"
									style="width: 60px; margin-right: 5px;">
								<button type="submit" class="btn btn-outline-dark btn-sm">
									<i class="fa-solid fa-cart-shopping"></i> Thêm vào giỏ
								</button>
							</form>

							<a
								href="wishlist?action=add&idproduct=<%=sp.getIdproduct()%>&idtaikhoan=<%=idtaikhoan%>"
								class="btn btn-outline-warning btn-sm ms-1"><i
								class="fa-solid fa-heart"></i> Yêu thích</a>
							<%
							} else {
							%>
							<button class="btn btn-outline-warning btn-sm ms-1 disabled">
								<i class="fa-solid fa-heart"></i>
							</button>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<div class="col-12 text-center">
				<p>Không có sản phẩm nào trong danh sách.</p>
			</div>
			<%
			}
			%>
		</div>
	</section>

	<div class="text-center mt-4">
		<a href="product" class="btn btn-outline-dark btn-lg view-more-btn"
			data-aos="fade-up">Xem Thêm</a>
	</div>

	<br>
	<br>
	<br>
	<jsp:include page="footerpage.jsp"></jsp:include>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
	<script>
		AOS.init();
	</script>
</body>
</html>
