<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="quantri.com.entity.Wishlist"%>
<%@ page import="quantri.com.dao.WishlistDao"%>
<%@ page import="nguoidung.com.web.WishlistServlet"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Menu Chính</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome Icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<style>
/* Thay đổi màu chữ khi một mục được chọn */
.navbar-nav .nav-link.active, .navbar-nav .nav-link:focus {
	color: #007bff; /* Màu chữ khi mục được chọn */
	font-weight: bold; /* Làm đậm chữ khi mục được chọn */
	transition: color 0.3s ease; /* Hiệu ứng chuyển màu chữ */
}

/* Thay đổi màu chữ khi hover */
.navbar-nav .nav-link:hover {
	color: #0056b3; /* Màu chữ khi hover */
	transition: color 0.3s ease; /* Hiệu ứng chuyển màu chữ */
}

/* Đảm bảo các liên kết không có gạch chân */
.navbar-nav .nav-link {
	text-decoration: none;
	color: #000; /* Màu chữ mặc định */
	transition: color 0.3s ease; /* Hiệu ứng chuyển màu chữ */
}

li.nav-item {
	position: relative;
}

li.nav-item .badge {
	position: absolute;
	top: -10px; /* Điều chỉnh khoảng cách từ trên xuống */
	right: -10px; /* Điều chỉnh khoảng cách từ bên phải */
	background-color: red;
	color: white;
	border-radius: 50%;
	padding: 5px;
	font-size: 12px;
}
/* CSS cho số lượng trên badge */
.badge {
	position: absolute;
	top: -4px;
	right: 65px;
	animation: bounce 0.3s ease-out;
	transform: translate(-6px, 5px);
}

/* Thêm hiệu ứng "nhảy lên" */
@
keyframes bounce { 0% {
	transform: translateY(0);
}
50
%
{
transform
:
translateY(
-5px
); /* Di chuyển lên một chút */
}
100
%
{
transform
:
translateY(
0
); /* Quay lại vị trí ban đầu */
}
}
</style>
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarText"
				aria-controls="navbarText" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav">
					<li class="nav-item"><a
						class="nav-link <%=(request.getRequestURI().contains("homepage") ? "active" : "")%>"
						href="homepage"> <i class="fas fa-home"></i> Trang Chủ
					</a></li>
					<li class="nav-item"><a
						class="nav-link <%=(request.getRequestURI().contains("product") && !request.getRequestURI().contains("byCategory") ? "active"
		: "")%>"
						href="product"> <i class="fas fa-laptop"></i> Sản Phẩm
					</a></li>
					<li class="nav-item"><a
						class="nav-link <%=(request.getParameter("theloai") != null && request.getParameter("theloai").equals("dientu") ? "active" : "")%>"
						href="product?action=byCategory&theloai=dientu"> <i
							class="fas fa-tv"></i> Điện Tử
					</a></li>
					<li class="nav-item"><a
						class="nav-link <%=(request.getParameter("theloai") != null && request.getParameter("theloai").equals("giadung") ? "active" : "")%>"
						href="product?action=byCategory&theloai=giadung"> <i
							class="fas fa-couch"></i> Gia Dụng
					</a></li>
					<li class="nav-item"><a
						class="nav-link <%=(request.getParameter("theloai") != null && request.getParameter("theloai").equals("phukien") ? "active" : "")%>"
						href="product?action=byCategory&theloai=phukien"> <i
							class="fas fa-cogs"></i> Phụ Kiện
					</a></li>
					<li class="nav-item"><a
						class="nav-link <%=(request.getRequestURI().contains("dangky") ? "active" : "")%>"
						href="dangky"> <i class="fas fa-user"></i> Đăng Ký/Đăng Nhập
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fas fa-shopping-cart"></i> Giỏ Hàng
					</a></li>
					<li class="nav-item"><a
						class="nav-link <%=(request.getRequestURI().contains("wishlist") ? "active" : "")%>"
						href="wishlist?action=list"> <i class="fas fa-heart"></i>
							Wishlist <%
 Integer itemCount = (Integer) session.getAttribute("itemCount");
 if (itemCount != null && itemCount > 0) {
 %> <span
							class="badge badge-pill badge-danger <%=(itemCount > 0 ? "changed" : "")%>">
								<%=itemCount%>
						</span> <%
 }
 %>
					</a></li>

					<li class="nav-item"><a
						class="nav-link <%=(request.getRequestURI().contains("lienhe") ? "active" : "")%>"
						href="lienhe"> <i class="fas fa-phone-alt"></i> Liên Hệ
					</a></li>
				</ul>

			</div>
		</div>
	</nav>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
