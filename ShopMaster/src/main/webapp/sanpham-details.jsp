<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="quantri.com.entity.Taikhoan"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>ShopCapy-Chi Tiết Sản Phẩm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<style>
/* Custom Styles */
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

.zoom-lens {
	position: absolute;
	border: 2px solid #000;
	width: 70px;
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
section.hero-section {
	padding: 50px 0;
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

.carousel-item {
    position: relative;
}

.carousel-caption {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(1%, -50%);
    text-align: center;
    padding: 15px;
    border-radius: 10px;
    animation: fadeInUp 1s ease-in-out;
}

.carousel-caption h3 {
    font-size: 30px;
    font-weight: bold;
    text-transform: uppercase;
    color: #fff;
    animation: slideInDown 1s ease-in-out;
}

.carousel-caption p {
    font-size: 18px;
    color: #fff;
    animation: fadeIn 1.5s ease-in-out;
}

/* Hiệu ứng mượt khi text xuất hiện */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translate(1%, -60%);
    }
    to {
        opacity: 1;
        transform: translate(1%, -50%);
    }
}

@keyframes slideInDown {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}
.carousel-inner.im img {
    filter: brightness(50%);
}
</style>
</head>

<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>

	
<!-- The slideshow/carousel -->
  <div class="carousel-inner im">
    <div class="carousel-item active">
      <img src="img/infor1.jpg" alt="Los Angeles" class="d-block" style="width:100%;height:330px">
       <div class="carousel-caption d-none d-md-block">
       <h3>Chi Tiết Sản Phẩm</h3>
         <p>Khám phá thông tin chi tiết về sản phẩm, từ thiết kế,<br>
tính năng đến giá cả, giúp bạn hiểu rõ hơn trước khi đưa ra lựa chọn mua sắm.</p>
    </div>
   </div>
  </div>
<br>
	<div class="container mt-4">
		<%
		Sanpham sanpham = (Sanpham) request.getAttribute("sanpham");


		if (sanpham != null) {
			DecimalFormat decimalFormat = new DecimalFormat("#,###");
		%>

		<div class="row align-items-start">
			<!-- Image Section -->
			<aside class="col-md-5 col-lg-6 mb-md-0 mb-4">
				<div id="productImageCarousel" class="carousel slide" data-bs-ride="carousel">
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#productImageCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						<button type="button" data-bs-target="#productImageCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
						<button type="button" data-bs-target="#productImageCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
					</div>

					<div class="carousel-inner">
						<!-- Slide 1 -->
						<div class="carousel-item active">
							<div class="zoom-container">
								<img src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sanpham.getImgfile())%>" class="d-block w-100 img-fluid product-image" onclick="openLightbox()" alt="<%=sanpham.getProName()%>">
								<div class="zoom-lens"></div>
							</div>
						</div>
						<!-- Slide 2 -->
						<div class="carousel-item">
							<div class="zoom-container">
								<img src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sanpham.getImgfile())%>" class="d-block w-100 img-fluid product-image" onclick="openLightbox()" alt="<%=sanpham.getProName()%>">
								<div class="zoom-lens"></div>
							</div>
						</div>
						<!-- Slide 3 -->
						<div class="carousel-item">
							<div class="zoom-container">
								<img src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sanpham.getImgfile())%>" class="d-block w-100 img-fluid product-image" onclick="openLightbox()" alt="<%=sanpham.getProName()%>">
								<div class="zoom-lens"></div>
							</div>
						</div>
					</div>

					<!-- Navigation Buttons -->
					<button class="carousel-control-prev" type="button" data-bs-target="#productImageCarousel" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Trước</span>
					</button>
					<button class="carousel-control-next" type="button" data-bs-target="#productImageCarousel" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Sau</span>
					</button>
				</div>
			</aside>

			<!-- Lightbox -->
			<div id="lightbox" class="lightbox">
				<span class="close-btn" onclick="closeLightbox()">&times;</span> 
				<img class="lightbox-content" id="lightbox-img">
			</div>

			<!-- Product Details Section -->
			<div class="col-md-6 col-lg-6 product-details-wrapper">
				<div class="product-details">
				<h3><%=sanpham.getProName()%></h3>
				<strong>Giá: </strong><%=decimalFormat.format(sanpham.getPrice())%> VND
				<p><strong>Số Lượng: </strong><%=sanpham.getStock()%></p>
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
				<p><strong>Mô Tả: </strong><%=sanpham.getDescription()%></p>

				<!-- Action Buttons -->
				<div class="d-flex justify-content-start mt-3 gap-2">
					<a href="javascript:history.back()" class="btn btn-outline-secondary btn-sm">Quay Về</a>
			
				</div>
			</div>
				<br> 
				<span class="text-center d-block zoom-text">Click
					chuột vào hình để phóng to</span>
		</div>
		<%
		} else {
		%>
		<div class="alert alert-warning text-center">Không tìm thấy sản phẩm này.</div>
		<%
		}
		%>
	</div>
	
	
	
	</div>
	
<br> 
	<jsp:include page="footerpage.jsp"></jsp:include>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		// Lightbox Function
		function openLightbox() {
			const lightbox = document.getElementById('lightbox');
			const lightboxImg = document.getElementById('lightbox-img');
			const productImage = event.target;
			lightbox.style.display = 'flex';
			lightboxImg.src = productImage.src;
		}

		function closeLightbox() {
			const lightbox = document.getElementById('lightbox');
			lightbox.style.display = 'none';
		}

		// Zoom Functionality
		const container = document.querySelector('.zoom-container');
		const lens = document.querySelector('.zoom-lens');

		container.addEventListener('mousemove', function (e) {
			const rect = container.getBoundingClientRect();
			const offsetX = e.clientX - rect.left;
			const offsetY = e.clientY - rect.top;

			const lensSize = lens.offsetWidth;
			const zoomFactor = 2; // Change zoom level here

			// Position the lens based on mouse position
			lens.style.left = offsetX - lensSize / 2 + 'px';
			lens.style.top = offsetY - lensSize / 2 + 'px';

			// Set the background image and position for zoom effect
			container.style.backgroundImage = `url('${event.target.src}')`;
			container.style.backgroundSize = (event.target.width * zoomFactor) + 'px ' + (event.target.height * zoomFactor) + 'px';
			container.style.backgroundPosition = `-${offsetX * zoomFactor - lensSize / 2}px -${offsetY * zoomFactor - lensSize / 2}px`;
		});
	</script>
</body>
</html>
