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
<title>ShopCapy -Tìm Kiếm Sản Phẩm</title>
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
	transition: transform 0.3s ease;
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
a.btn.btn-outline-warning.btn-sm.ms-6 {
    margin-left: 6em;
}
a.btn.btn-outline-info.btn-sm.mx-auto.mt-3 {
    transform: translateX(12px);
}
a.btn.btn-outline-danger.btn-sm.mx-auto.mt-7 {
    transform: translateX(106px);
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>


	<div class="container mt-4">
		<h2 class="text-center">
			Các Sản Phẩm Liên Quan :
			<%=request.getAttribute("keyword")%></h2>
		<br> <br>
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
								class="fa-solid fa-comment"></i></a>
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
								class="btn btn-outline-danger btn-sm mx-auto mt-7">  <i class="fa-solid fa-star"></i> </a>
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
	</div>
	<div class="text-center mt-4">
    <a href="homepage" class="btn btn-outline-secondary">Quay Lại</a>
</div>
	<br>
	<br>
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
