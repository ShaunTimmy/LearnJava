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
<title>ShopCapy - Sản Phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"
	rel="stylesheet">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<style>
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

.card {
	transition: transform 0.3s;
}

.card:hover {
	transform: scale(1.1);
}

section.hero-section {
	padding: 50px 0;
}

.card-body .d-flex {
	justify-content: space-between;
}

.image-container {
	position: relative;
	overflow: hidden;
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
a.btn.btn-outline-warning.btn-sm.ms-6 {
    margin-left: 6em;
}
a.btn.btn-outline-info.btn-sm.mx-auto.mt-3 {
    transform: translateX(12px);
}
a.btn.btn-outline-danger.btn-sm.mx-auto.mt-7 {
    transform: translateX(106px);
}

.carousel-inner img {
    filter: brightness(50%);
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

</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>

<!-- Carousel -->
<div id="demo" class="carousel slide" data-bs-ride="carousel">

  <!-- Indicators/dots -->
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
  </div>
 
  <!-- The slideshow/carousel -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="img/banner.jpg" alt="Los Angeles" class="d-block" style="width:100%;height:330px">
       <div class="carousel-caption d-none d-md-block">
        <h3>Sản phẩm chất lượng</h3>
        <p>Khám phá những sản phẩm tốt nhất với giá hấp dẫn!</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="img/banner.png" alt="Chicago" class="d-block" style="width:100%;height:330px">
        <div class="carousel-caption d-none d-md-block">
        <h3>Ưu đãi đặc biệt</h3>
        <p>Giảm giá lên đến 50% cho các sản phẩm hot nhất!</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="img/banner2.jpg" alt="New York" class="d-block" style="width:100%;height:330px">
       <div class="carousel-caption d-none d-md-block">
        <h3>Mua sắm dễ dàng</h3>
        <p>Đặt hàng nhanh chóng - Giao hàng tận nơi!</p>
      </div>
    </div>
  
  </div>
  
  <!-- Left and right controls/icons -->
  <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div>

	
	<br>
	<div class="container mt-4">
		<div class="row">
			<%
			List<Sanpham> listSP = (List<Sanpham>) request.getAttribute("listSP");
			DecimalFormat decimalFormat = new DecimalFormat("#,###");
			if (listSP != null && !listSP.isEmpty()) {
				for (Sanpham sp : listSP) {
			%>
			<div class="col-md-4 mb-4" data-aos="zoom-in">
				<div class="card">
					<div class="image-container">
						<img
							src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sp.getImgfile())%>"
							class="card-img-top product-img" alt="<%=sp.getProName()%>">
						<div class="overlay-buttons">
							<a href="product?action=details&idproduct=<%=sp.getIdproduct()%>"
								class="btn btn-outline-info btn-sm"> <i
								class="fa-solid fa-eye"></i> 
							</a>
							<%
							Taikhoan tk = (Taikhoan) session.getAttribute("taikhoan");
							String link = "review?action=add&idproduct=" + sp.getIdproduct();
							boolean isDisabled = (tk == null); // If no "taikhoan" in session, disable the button
							%>
							<a href="<%=link%>"
								class="btn btn-outline-success btn-sm ms-1 <%=isDisabled ? "disabled" : ""%>"
								<%=isDisabled ? "aria-disabled='true' tabindex='-1'" : ""%>><i
								class="fa-solid fa-comment"></i></a><br>


						</div>
					</div>
					<div class="card-body">
						<h5 class="card-title"><%=sp.getProName()%></h5>
						<p class="card-text">
							<strong>Giá: </strong><%=decimalFormat.format(sp.getPrice())%>
							VND
						</p>

						<div class="d-flex flex-column align-items-start">
							<%
							Taikhoan taikhoan = (Taikhoan) session.getAttribute("taikhoan");
							if (taikhoan != null) {
								int idtaikhoan = taikhoan.getIdtaikhoan();
							%>
							<!-- -THÊM GIỎ HÀNG VÀ YÊU THÍCH -->
							<div class="d-flex justify-content-between">
								<form action="giohang?action=add" method="POST"
									class="d-flex align-items-center me-2">
									<input type="hidden" name="action" value="add"> <input
										type="hidden" name="idproduct" value="<%=sp.getIdproduct()%>">
									<input type="hidden" name="slg" value="1" min="1"
										class="form-control form-control-sm"
										style="width: 60px; margin-right: 5px;">
									<button type="submit" class="btn btn-outline-dark btn-sm">
										<i class="fa-solid fa-cart-shopping"></i> 
									</button>
								</form>
								<a
									href="wishlist?action=add&idproduct=<%=sp.getIdproduct()%>&idtaikhoan=<%=idtaikhoan%>"
									class="btn btn-outline-warning btn-sm ms-6"> <i
									class="fa-solid fa-heart"></i> 
								</a>
								
								<a href="review?action=details&idproduct=<%=sp.getIdproduct()%>"
								class="btn btn-outline-danger btn-sm mx-auto mt-7"> <i class="fa-solid fa-star"></i> </a>
							</div>
							<!-- ---KET THUC -->
							<!-- Nút Xem Đánh Giá nằm phía dưới và căn giữa -->
							
							<%
							} else {
							%>
							<button class="btn btn-outline-warning btn-sm ms-2" disabled>
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

		<!-- Pagination -->
		<div class="d-flex justify-content-center mt-3">
			<%
			Integer currentPage = (Integer) request.getAttribute("currentPage");
			Integer totalPages = (Integer) request.getAttribute("totalPages");

			if (currentPage == null) {
				currentPage = 1;
			}
			if (totalPages == null) {
				totalPages = 1;
			}

			if (currentPage > 1) {
			%>
			<a href="product?action=list&page=<%=currentPage - 1%>"
				class="btn btn-outline-success mx-1"> <i
				class="fas fa-arrow-left me-1"></i>Trang Trước
			</a>
			<%
			}
			// Display page number
			%>
			<span class="btn btn-outline-secondary disabled mx-1">Trang <%=currentPage%>
				/ <%=totalPages%></span>
			<%
			if (currentPage < totalPages) {
			%>
			<a href="product?action=list&page=<%=currentPage + 1%>"
				class="btn btn-outline-success mx-1">Trang Kế Tiếp <i
				class="fas fa-arrow-right ms-1"></i></a>
			<%
			}
			%>
		</div>
	</div>
	<br>
	<br>
	<br>
	<jsp:include page="footerpage.jsp"></jsp:include>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		AOS.init();
	</script>
</body>
</html>
