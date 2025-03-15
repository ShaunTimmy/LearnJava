<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="quantri.com.entity.Wishlist"%>
<%@ page import="quantri.com.dao.WishlistDao"%>
<%@ page import="nguoidung.com.web.WishlistServlet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
body {
	font-family: Arial, sans-serif;
}

.sidebar {
	background-color: #f8f9fa;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.sidebar h4 a {
	color: #333;
	text-decoration: none;
	font-size: 1.1rem;
}

.sidebar-item {
	margin-bottom: 15px;
}

.account-info {
	margin-top: 30px;
}

.info-card {
	margin-bottom: 15px;
	border: 1px solid #ddd;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

.info-card .card-header {
	background-color: #f8f9fa;
	font-weight: bold;
	font-size: 1.1rem;
	border-bottom: 1px solid #ddd;
}

.info-card .card-body {
	font-size: 1rem;
}

.btn-icon {
	display: flex;
	align-items: center;
}

.btn-icon i {
	margin-right: 5px;
}

.header-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.container {
	max-width: 1200px;
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






translateY




(






-5px






)




; /* Di chuyển lên một chút */
}
100






%
{
transform






:






translateY




(






0






)




; /* Quay lại vị trí ban đầu */
}
}
</style>
</head>
<body>
	<div class="container mt-5">
		<div class="row">
			<!-- Sidebar -->
			<div class="col-md-3">
				<div class="sidebar">
					<div class="sidebar-item">
						<h4>
							<a href="lichsu">Đơn Hàng Của Tôi</a>
						</h4>
					</div>
					<div class="sidebar-item">
						<h4>
							<a href="dangxuat" onclick="return confirm('Bạn có muốn đăng xuất tài khoản không ?')">Đăng Xuất</a>
						</h4>
					</div>
				</div>
			</div>
</body>
</html>