<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="quantri.com.entity.Taikhoan"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>ShopCapy-Chi Tiết Sản Phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<style>
/* Cải tiến giao diện ảnh sản phẩm */
.product-image {
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 10px;
	background-color: #f8f9fa;
	transition: transform 0.3s ease-in-out;
	position: relative;
	overflow: hidden;
}

.zoom-container {
	position: relative;
	overflow: hidden;
	width: 100%;
	height: auto;
}

.rect {
	position: absolute;
	top: 0;
	left: 0;
	width: 0;
	height: 0;
	background-color: rgba(119, 255, 248, 0.5);
	display: none;
	pointer-events: none;
}

.product-image.zoom {
	transform: scale(1.5);
	cursor: zoom-in;
}

.product-details {
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 20px;
	background-color: #ffffff;
}

.product-details h3 {
	color: #007bff;
}

.product-details p {
	font-size: 16px;
	line-height: 1.6;
}

.btn-add-to-cart {
	background-color: #28a745;
	border-color: #28a745;
	color: white;
	font-size: 16px;
	padding: 10px 20px;
	border-radius: 5px;
	text-decoration: none;
}

span.carousel-control-prev-icon {
	background-color: #0a58ca;
}

span.carousel-control-next-icon {
	background-color: #0a58ca;
}

.zoom-container {
	position: relative;
	overflow: hidden;
	width: 100%;
	height: auto;
}

.product-image {
	width: 100%;
	height: 100%;
	transition: transform 0.3s ease-in-out;
}

.zoom-lens {
	position: absolute;
	border: 2px solid #000;
	width: 70px; /* Kích thước kính lúp */
	height: 70px;
	display: none;
	pointer-events: none;
	border-radius: 50%;
	transition: all 0.3s ease-in-out;
}

.zoom-container:hover .zoom-lens {
	display: block;
}

.zoom-container:hover .zoom-lens {
	transition: all 0.3s ease-in-out;
}
/* Lightbox Styles */
.lightbox {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.8);
	justify-content: center;
	align-items: center;
}

.lightbox-content {
	width: 60%;
	height: auto;
}

.close-btn {
	position: absolute;
	top: 20px;
	right: 30px;
	font-size: 40px;
	color: white;
	cursor: pointer;
	z-index: 1001;
}

section.hero-section {
	padding: 50px 0;
}
</style>
</head>

<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>

	<section class="hero-section"
		style="background-color: #70a1ff; color: #fff;">
		<div class="container text-center">
			<h1>Chi Tiết Sản Phẩm</h1>
			<p>
				Khám phá thông tin chi tiết về sản phẩm, từ thiết kế, <br> tính
				năng đến giá cả, giúp bạn hiểu rõ hơn trước khi đưa ra lựa chọn mua
				sắm.
			</p>
		</div>
	</section>
	<br>
	<br>

	<div class="container mt-4">

		<%
		Sanpham sanpham = (Sanpham) request.getAttribute("sanpham");
		if (sanpham != null) {
			DecimalFormat decimalFormat = new DecimalFormat("#,###");
		%>

		<div class="row align-items-start">
			<!-- Sidebar Image Section -->
			<aside class="col-md-6 col-lg-5 mb-4">
				<div class="zoom-container">

					<img
						src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sanpham.getImgfile())%>"
						class="d-block w-100 img-fluid product-image"
						onclick="openLightbox()" alt="<%=sanpham.getProName()%>">
					<div class="zoom-lens"></div>
				</div>
			</aside>
			<!-- Lightbox -->
			<div id="lightbox" class="lightbox">
				<span class="close-btn" onclick="closeLightbox()">&times;</span> <img
					class="lightbox-content" id="lightbox-img">
			</div>

			<!-- Product Details Section -->
			<div class="col-md-6 col-lg-7 product-details w-90">
				<h3><%=sanpham.getProName()%></h3>
				<strong>Giá: </strong><%=decimalFormat.format(sanpham.getPrice())%>
				VND
				</p>
				<p>
					<strong>Số Lượng: </strong><%=sanpham.getStock()%></p>
				<p>
					<strong>Thời Gian Giao Hàng: </strong>
					<%
					String thoigianGH = sanpham.getThoigianGH();
					String hienThi = "";
					switch (thoigianGH) {
						case "fast" :
							hienThi = "1-3 ngày";
							break;
						case "steady" :
							hienThi = "2-5 ngày";
							break;
						case "slow" :
							hienThi = "3-7 ngày";
							break;
						case "quick" :
							hienThi = "Ngày mai";
							break;
						default :
							hienThi = "Không xác định";
							break;
					}
					%>
					<%=hienThi%>
				</p>
				<p>
					<strong> Phân Loại: </strong>
					<%
					String theloai = sanpham.getTheloai();
					String tloai = "";
					switch (theloai) {
						case "dientu" :
							tloai = "Điện tử";
							break;
						case "giadung" :
							tloai = "Gia dụng";
							break;
						case "phukien" :
							tloai = "Phụ kiện";
							break;
						default :
							tloai = "Không xác định";
							break;
					}
					%>
					<%=tloai%>

				</p>
				<p>
					<strong>Mô Tả: </strong><%=sanpham.getDescription()%></p>
				<p>
					<!-- Buttons Section -->
				<div class="d-flex justify-content-start mt-3 gap-2 ">
					<a href="javascript:history.back()"
						class="btn btn-outline-secondary btn-sm w-100">Quay Về</a> <a
						href="#" class="btn btn-outline-info btn-sm w-100">Xem Đánh
						Giá</a> 
				</div>
				<br> <span class="text-center d-block zoom-text">Click
					chuột vào hình để phóng to</span>
			</div>
		</div>
		<%
		} else {
		%>
		<div class="alert alert-warning text-center">Không tìm thấy sản
			phẩm này.</div>
		<%
		}
		%>
	</div>
	<jsp:include page="footerpage.jsp"></jsp:include>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
const container = document.querySelector('.zoom-container');
const image = document.querySelector('.product-image');
const lens = document.querySelector('.zoom-lens');

container.addEventListener('mousemove', (e) => {
    let posX = e.pageX - container.offsetLeft - lens.offsetWidth / 2;
    let posY = e.pageY - container.offsetTop - lens.offsetHeight / 2;
    
    // Giới hạn vị trí của kính lúp trong phạm vi ảnh
    if (posX > container.offsetWidth - lens.offsetWidth) {
        posX = container.offsetWidth - lens.offsetWidth;
    }
    if (posY > container.offsetHeight - lens.offsetHeight) {
        posY = container.offsetHeight - lens.offsetHeight;
    }
    
    lens.style.left = posX + 'px';
    lens.style.top = posY + 'px';
    
 // Phóng to ảnh theo kính lúp với transition
    const zoom = 2;
    image.style.transform = `scale(${zoom})`;
    image.style.transformOrigin = `${(posX / container.offsetWidth) * 100}% ${(posY / container.offsetHeight) * 100}%`;
});
function openLightbox() {
    const lightbox = document.getElementById('lightbox');
    const lightboxImg = document.getElementById('lightbox-img');
    const productImage = document.querySelector('.product-image');
    
    lightbox.style.display = 'flex';
    lightboxImg.src = productImage.src; // Copy the source of the image to the lightbox
}

function closeLightbox() {
    const lightbox = document.getElementById('lightbox');
    lightbox.style.display = 'none';
}
	</script>


</body>

</html>
