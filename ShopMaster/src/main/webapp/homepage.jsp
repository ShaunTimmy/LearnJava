<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopCapy</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<!-- Bootstrap Icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"
	rel="stylesheet">
<style>
.about-section {
	border: 2px solid #007bff; /* Viền màu xanh */
	border-radius: 10px; /* Bo góc viền */
	padding: 20px; /* Khoảng cách bên trong */
	margin: 20px auto; /* Căn giữa và thêm khoảng cách bên ngoài */
	/* Màu nền nhạt */
}

.bg-light.py-5.h-60 {
	background: url('img/banner.webp') no-repeat center center;
	background-size: cover;
	padding: 80px 0;
	text-align: center;
	color: #ffffff; /* Red color for text */
	transform: translateY(10px);
	transform: translateY(2px);
	height: 110%;
}

/* Lớp phủ mờ */
.bg-light.py-5.h-60::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.4); /* Màu đen với độ trong suốt 40% */
	z-index: 1; /* Đảm bảo lớp phủ nằm trên nền */
}

/* Đảm bảo văn bản trong container không bị ảnh hưởng bởi lớp phủ */
.container {
	position: relative;
	z-index: 2; /* Đảm bảo văn bản hiển thị trên lớp phủ */
}

/* Đảm bảo tất cả các thẻ card đều có cùng chiều cao */
.card {
	border: none; /* Bỏ viền của thẻ card */
	box-shadow: none; /* Bỏ bóng đổ nếu có */
	width: 100%;
	height: 200px;
}

.card-img-top {
	width: 100%; /* Đảm bảo ảnh chiếm hết chiều rộng */
	height: 200px; /* Giới hạn chiều cao ảnh */
}

.card-body {
	flex-grow: 1; /* Đảm bảo nội dung card có thể giãn nở đều */
}
/* Giới hạn chiều cao của phần text, tránh trường hợp quá dài làm thẻ không đồng đều */
.card-text {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

/* Đảm bảo các thẻ sản phẩm có chiều cao giống nhau */
.col-md-4 {
	display: flex;
	justify-content: space-between;
}

.card-text {
	
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

		<div class="container text-center ">
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
	
	<!-- -----------SAN PHAM GIOI THIEU ---------------- -->

	<section class="container py-5">
		<h1 class="text-center">Sản Phẩm Đặc Biệt Cho Bạn</h1>
		<br>
		<div class="row">
			<%
			List<Sanpham> IntroPro = (List<Sanpham>) request.getAttribute("intro");
			DecimalFormat decimalFormat = new DecimalFormat("#,###");

			if (IntroPro != null && !IntroPro.isEmpty()) {
				for (Sanpham sp : IntroPro) {
			%>
			<div class="col-md-4 mb-4" data-aos="flip-left">
				<div class="card">
					<img
						src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sp.getImgfile())%>"
						class="card-img-top" alt="<%=sp.getProName()%>">
					<div class="card-body">
						<h5 class="card-title"><%=sp.getProName()%></h5>
						<p class="card-text">
							<strong>Giá: </strong><%=decimalFormat.format(sp.getPrice())%>
							VND
						</p>
						<!-- -----BUTTON---------------- -->
						<div class="d-flex justify-content-between">
							<!-- Nút Xem Chi Tiết -->
							<a href="product?action=details&idproduct=<%=sp.getIdproduct()%>"
								class="btn btn-outline-info btn-sm">Xem Chi Tiết</a>

							<!-- Nút Thêm Vào Yêu Thích -->
							<%
							Taikhoan taikhoan = (Taikhoan) session.getAttribute("taikhoan");
							if (taikhoan != null) {
								int idtaikhoan = taikhoan.getIdtaikhoan();
							%>
							<a
								href="wishlist?action=add&idproduct=<%=sp.getIdproduct()%>&idtaikhoan=<%=idtaikhoan%>"
								class="btn btn-outline-success btn-sm ms-1">Thêm Vào Yêu
								Thích</a>
							<%
							} else {
							%>
							<button class="btn btn-outline-warning btn-sm ms-1" disabled>Thêm
								Vào Yêu Thích</button>
							<%
							}
							%>
						</div>
						<!-- -----BUTTON---------------- -->
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
        <a href="product" class="btn btn-outline-dark btn-lg view-more-btn" data-aos="fade-up">Xem Thêm</a>
    </div>

	<!-- ---------------------------------------- -->
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
