<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Tài Khoản</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>
	<!-- Nội dung trang chính -->
	<div class="content border border-secondary rounded shadow p-4 mt-4 h-250">
		<div class="container mt-5">
			<h1 class="text-center">Danh Sách Tài Khoản</h1>
				<div class="d-flex justify-content-center align-items-center" >
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
			<table class="table table-bordered table-striped mt-4">
				<thead class="table table-dark">
					<tr>
						<th>STT</th>
						<th>Tên Đăng Nhập</th>
						<th>Địa Chỉ</th>
						<th>Email</th>
						<th>Số Điện Thoại</th>
						<th>Vai Trò</th>
						<th>Quản Lý</th>
					</tr>
				</thead>
				<tbody>
					<%
					// Lấy danh sách tài khoản từ attribute
					List<Taikhoan> listTK = (List<Taikhoan>) request.getAttribute("listTK");

					// Kiểm tra nếu danh sách tài khoản không null
					if (listTK != null && !listTK.isEmpty()) {
						int stt = 1;
						for (Taikhoan tk : listTK) {
					%>
					<tr>
						<td><%=stt++%></td>
						<td><%=tk.getUsername()%></td>
						<td><%=tk.getAddress()%></td>
						<td><%=tk.getEmail()%></td>
						<td><%=tk.getSdt()%></td>
						<td>
						<%
							String role = tk.getRole() ; 
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
							%> <%=vatro%>
						</td>
						<td><a
							href="taikhoan?action=delete&idtaikhoan=<%=tk.getIdtaikhoan()%>"
							class="btn btn-danger btn-sm"
							onclick="return confirm('Are you sure you want to delete this account?')">
							<i class="fas fa-trash me-1"></i>Xóa</a>
						</td>
					</tr>
					<%
					} // Kết thúc vòng lặp
					} else {
					%>
					<tr>
						<td colspan="7" class="text-center">No Information Found</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
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
				<a href="taikhoan?action=list&page=<%=currentPage - 1%>"
					class="btn btn-outline-success mx-1">
					<i class="fas fa-arrow-left me-1"></i>Trang Trước</a>
				<%
				}

				// Hiển thị số trang hiện tại
				%>
				<span class="btn btn-outline-secondary disabled mx-1">Trang <%=currentPage%>
					/ <%=totalPages%></span>
				<%
				// Tạo liên kết "Trang Sau" nếu không phải là trang cuối cùng
				if (currentPage < totalPages) {
				%>
				<a href="taikhoan?action=list&page=<%=currentPage + 1%>"
					class="btn btn-outline-success mx-1">Trang Kế Tiếp <i class="fas fa-arrow-right ms-1"></i></a>
				<%
				}
				%>
			</div>
		</div>
	</div>
<jsp:include page="footer.jsp"></jsp:include>
	<!-- Script Bootstrap -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>