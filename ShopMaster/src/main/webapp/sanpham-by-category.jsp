<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>ShopCapy - Phân Loại Sản Phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<style>
/* Các thẻ card sẽ có chiều cao đồng đều */
.card {
	border: none;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	width: 100%;
	height: 200px;
	transition: transform 0.3s ease;
}

.card:hover {
	transform: scale(1.05);
}

.card-img-top {
	width: 100%;
	height: 200px;
}

.card-body {
	flex-grow: 1;
}

.card-title {
	font-size: 1.25rem;
	font-weight: bold;
}

.card-text {
	font-size: 1rem;
	color: #333;
}

.card-text strong {
	color: #000;
}

.col-md-4 {
	display: flex;
	justify-content: space-between;
}
/* Button hiệu ứng */
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

.overlay-buttons a {
	background-color: rgba(255, 255, 255, 0.8);
	padding: 8px 12px;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.overlay-buttons a:hover {
	background-color: rgba(0, 123, 255, 0.7);
}

.image-container {
	position: relative;
	overflow: hidden;
}

.product-img {
	transition: transform 0.3s ease-in-out;
}

.image-container:hover .product-img {
	transform: scale(1.1);
}

/* Hero section */
section.hero-section {
	padding: 60px 0;
	background-color: #70a1ff;
	color: white;
}

section.hero-section h1 {
	font-size: 2.5rem;
	font-weight: bold;
}

section.hero-section p {
	font-size: 1.125rem;
	font-weight: 300;
}

.pagination .btn {
	margin: 0 5px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>

	<section class="hero-section text-center">
		<div class="container">
			<h1>Sản Phẩm Theo Phân Loại</h1>
			<p>Khám phá các sản phẩm đa dạng được sắp xếp theo từng phân
				loại, giúp bạn dễ dàng tìm kiếm và lựa chọn theo nhu cầu một cách
				nhanh chóng và tiện lợi.</p>
		</div>
	</section>
	<br>
	<div class="container mt-4">
		<div class="row">
			<%
			List<Sanpham> productList = (List<Sanpham>) request.getAttribute("productList");
			DecimalFormat decimalFormat = new DecimalFormat("#,###");

			if (productList != null && !productList.isEmpty()) {
				for (Sanpham sp : productList) {
			%>
			<div class="col-md-4 mb-4" data-aos="zoom-out-up">
				<div class="card">
					<div class="image-container">
						<img
							src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sp.getImgfile())%>"
							class="card-img-top product-img" alt="<%=sp.getProName()%>">
						<div class="overlay-buttons">
							<a href="product?action=details&idproduct=<%=sp.getIdproduct()%>"
								class="btn btn-outline-info btn-sm"><i
								class="fa-solid fa-eye"></i> Xem</a>
							<%
							Taikhoan tk = (Taikhoan) session.getAttribute("taikhoan");
							String link = "review?action=add&idproduct=" + sp.getIdproduct();
							boolean isDisabled = (tk == null); // If no "taikhoan" in session, disable the button
							%>
							<a href="<%=link%>"
								class="btn btn-outline-success btn-sm ms-1 <%=isDisabled ? "disabled" : ""%>"
								<%=isDisabled ? "aria-disabled='true' tabindex='-1'" : ""%>>
								<i class="fa-solid fa-comment"></i> Đánh giá
							</a>
						</div>
					</div>
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
							<!-- ---KET THUC -->
							<a
								href="wishlist?action=add&idproduct=<%=sp.getIdproduct()%>&idtaikhoan=<%=idtaikhoan%>"
								class="btn btn-outline-warning btn-sm ms-1"><i
								class="fa-solid fa-heart"></i> Yêu thích</a>
							<%
							} else {
							%>
							<button class="btn btn-outline-warning btn-sm ms-1" disabled>
								<i class="fa-solid fa-heart"></i> Yêu thích
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

		<!-- Phân trang -->
		<div class="d-flex justify-content-center mt-3">
			<%
			String theloai = request.getParameter("theloai");
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
			<a
				href="product?action=byCategory&theloai=<%=theloai%>&page=<%=currentPage - 1%>"
				class="btn btn-outline-success mx-1">Trang Trước</a>
			<%
			}
			%>
			<span class="btn btn-outline-secondary disabled mx-1">Trang <%=currentPage%>
				/ <%=totalPages%></span>
			<%
			if (currentPage < totalPages) {
			%>
			<a
				href="product?action=byCategory&theloai=<%=theloai%>&page=<%=currentPage + 1%>"
				class="btn btn-outline-success mx-1">Trang Kế Tiếp</a>
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
