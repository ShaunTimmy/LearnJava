<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sidebar</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"
	rel="stylesheet">
<style>
/* Sidebar Styles */
.sidebar {
	height: 100vh;
	width: 250px;
	position: fixed;
	background-color: #343a40; /* Màu nền tối hơn */
	padding-top: 20px;
	z-index: 1; /* Đảm bảo sidebar ở trên nội dung chính */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng */
}

.sidebar a {
	color: #f8f9fa; /* Màu chữ sáng */
	text-decoration: none;
	margin-bottom: 10px;
	transition: all 0.3s ease; /* Hiệu ứng mượt */
}

.sidebar a:hover {
	background-color: #82ccdd; /* Màu nền khi hover */
	color: #EA2027; /* Màu chữ sáng khi hover */
	transform: translateX(5px); /* Hiệu ứng di chuyển nhẹ */
	border-radius: 5px;
}

.sidebar .nav-item {
	padding: 10px 20px;
	font-size: 1rem; /* Tăng kích thước chữ */
}

.sidebar .nav-item i {
	font-size: 1.2rem; /* Tăng kích thước icon */
}

.content {
	margin-left: 250px;
	/* Đảm bảo nội dung không bị che khuất bởi sidebar */
	padding: 20px;
	flex: 1;
}

/* Hiệu ứng highlight phần đang được chọn */
.sidebar .active {
	background-color: #17a2b8; /* Màu xanh nổi bật */
	color: #fff; /* Màu chữ trắng */
	font-weight: bold;
	border-radius: 5px;
}

/* Hiệu ứng khi sidebar chuyển động (nếu cần mở rộng trong tương lai) */
.sidebar {
	transition: all 0.3s ease-in-out;
}
span.badge.badge-pill.badge-danger.changed {
    margin-left: 13px;
    font-size: 12px;
    color: #ff6348;
}
</style>
</head>
<body>
	<div class="d-flex">
		<!-- Sidebar -->
		<div class="sidebar d-flex flex-column"
			style="width: 250px; min-height: 100vh;">
			<a href="admin" class="d-flex align-items-center mb-3 px-3 active">
				<i class="bi bi-person-circle me-2"></i> <span><%= session.getAttribute("username") %></span>
			</a>
			<hr>
			<nav class="nav flex-column">
				<a class="nav-item d-flex align-items-center mb-2 px-3"
					href="sanpham"> <i class="bi bi-box-seam me-2"></i> Quản Lý Sản
					Phẩm
					<%
 Integer tongsp = (Integer) session.getAttribute("tongsp");
 if (tongsp!= null && tongsp > 0) {
 %> <span
							class="badge badge-pill badge-danger <%=(tongsp > 0 ? "changed" : "")%>">
								<%=tongsp%>
						</span> 
						<%
 }
 %>
				</a> 
				<a class="nav-item d-flex align-items-center mb-2 px-3"
					href="taikhoan"> <i class="bi bi-people me-2"></i> Quản Lý Tài
					Khoản
				</a> <a class="nav-item d-flex align-items-center mb-2 px-3"
					href="donhang"> <i class="bi bi-cart me-2"></i> Quản Lý Đơn
					Hàng
				</a> <a class="nav-item d-flex align-items-center mb-2 px-3"
					href="danhgia"> <i class="bi bi-star me-2"></i> Quản Lý
					Đánh Giá
				</a> <a class="nav-item d-flex align-items-center mb-2 px-3"
					href="thongke"> <i class="bi bi-bar-chart-line me-2"></i> Thống
					Kê Doanh Thu
				</a>
				<hr>
				<a class="nav-item d-flex align-items-center mt-auto px-3"
					href="${pageContext.request.contextPath}/logout"> <i
					class="bi bi-box-arrow-right me-2"></i> Đăng Xuất
				</a>
			</nav>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-cVKIPhG81r3pKUpQ1h8RRAfGvW8zWFP2iHG8N3PePIpFEM6rlM/c0VB5GPqK6gD7"
		crossorigin="anonymous"></script>

</body>
</html>
