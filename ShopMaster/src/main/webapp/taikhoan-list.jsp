<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Tài Khoản</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>

	<!-- Nội dung trang chính -->
	<div class="content border border-secondary rounded shadow p-4 mt-4">
		<div class="container mt-5">
			<h1 class="text-center">Danh Sách Tài Khoản</h1>
				<div class="d-flex justify-content-center align-items-center">
					<div class="card p-2 shadow-sm w-50 w-md-30">
						<form action="taikhoan?action=search" method="post" class="input-group">
							<input type="hidden" name="action" value="search">
							<input type="text" name="keyword" class="form-control" placeholder="Bạn cần tìm gì..." required>
							<button type="submit" class="btn btn-primary">
								<i class="fab fa-searchengin"></i>
							</button>
						</form>
					</div>
				</div>

			<!-- Hiển thị danh sách tài khoản theo dạng card -->
			<div class="row mt-4">
				<%
				// Lấy danh sách tài khoản từ attribute
				List<Taikhoan> listTK = (List<Taikhoan>) request.getAttribute("listTK");

				// Kiểm tra nếu danh sách tài khoản không null
				if (listTK != null && !listTK.isEmpty()) {
					for (Taikhoan tk : listTK) {
				%>
				<div class="col-md-4 mb-4">
					<div class="card shadow-sm">
						<div class="card-body">
							<h5 class="card-title"><i class="fas fa-user me-2"></i><%= tk.getUsername() %></h5>
							<p class="card-text"><i class="fas fa-map-marker-alt me-2"></i><%= tk.getAddress() %></p>
							<p class="card-text"><i class="fas fa-envelope me-2"></i><%= tk.getEmail() %></p>
							<p class="card-text"><i class="fas fa-phone-alt me-2"></i><%= tk.getSdt() %></p>
							<p class="card-text">
								<%
									String role = tk.getRole(); 
									String vatro = ""; 

									switch (role) {
										case "user":
											vatro = "Khách hàng ";
											break;
										case "admin":
											vatro = "Quản trị viên ";
											break;
										default:
											vatro = "Không xác định"; // Xử lý trường hợp không khớp
											break;
									}
								%>
								<i class="fas fa-user-tag me-2"></i><%= vatro %>
							</p>
							<a href="taikhoan?action=delete&idtaikhoan=<%= tk.getIdtaikhoan() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this account?')">
								<i class="fas fa-trash me-1"></i>Xóa
							</a>
						</div>
					</div>
				</div>
				<%
					} // Kết thúc vòng lặp
				} else {
				%>
				<div class="col-12">
					<p class="text-center">No Information Found</p>
				</div>
				<%
				}
				%>
			</div>

			<!-- Phân trang -->
			<div class="d-flex justify-content-center mt-3">
				<%
				// Lấy currentPage và totalPages từ request
				Integer currentPage = (Integer) request.getAttribute("currentPage");
				Integer totalPages = (Integer) request.getAttribute("totalPages");

				// Gán giá trị mặc định nếu null
				if (currentPage == null) {
					currentPage = 1;
				}
				if (totalPages == null) {
					totalPages = 1;
				}

				// Tạo liên kết "Trang Trước" nếu không phải là trang đầu tiên
				if (currentPage > 1) {
				%>
				<a href="taikhoan?action=list&page=<%= currentPage - 1 %>" class="btn btn-outline-success mx-1">
					<i class="fas fa-arrow-left me-1"></i>Trang Trước</a>
				<%
				}

				// Hiển thị số trang hiện tại
				%>
				<span class="btn btn-outline-secondary disabled mx-1">Trang <%= currentPage %> / <%= totalPages %></span>
				<%
				// Tạo liên kết "Trang Sau" nếu không phải là trang cuối cùng
				if (currentPage < totalPages) {
				%>
				<a href="taikhoan?action=list&page=<%= currentPage + 1 %>" class="btn btn-outline-success mx-1">Trang Kế Tiếp <i class="fas fa-arrow-right ms-1"></i></a>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp"></jsp:include>

	<!-- Script Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
