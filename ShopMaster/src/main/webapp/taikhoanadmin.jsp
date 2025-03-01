<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="quantri.com.entity.Taikhoan"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thông Tin Tài Khoản</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.account-info {
	margin-top: 20px;
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

.header-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.btn-icon {
	display: flex;
	align-items: center;
}

.btn-icon i {
	margin-right: 5px;
}
       .content.border.border-secondary.rounded.shadow.p-4.mt-4.h-500.w-20 {
    width: 76%;
    margin-left: 292px;
}
</style>
</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>
	<div
		class="content border border-secondary rounded shadow p-4 mt-4 h-500 w-20">
		<div class="header-row">
			<h2 class="mb-4 text-primary">Thông Tin Tài Khoản</h2>


			<button type="button" class="btn btn-outline-success btn-icon"
				data-bs-toggle="modal" data-bs-target="#modalThongTin">
				<i class="bi bi-pencil-square me-1"></i> Cập Nhật
			</button>
			<button type="button" class="btn btn-outline-primary btn-icon"
				data-bs-toggle="modal" data-bs-target="#staticBackdrop">
				<i class="bi bi-lock"></i> Đổi Mật Khẩu
			</button>
			<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
				data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="staticBackdropLabel">Đổi
								Mật Khẩu</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form action="matkhau?action=update" method="POST">
								<input type="hidden" name="idtaikhoan"
									value="<%=request.getParameter("idtaikhoan")%>">
								<div class="mb-3">
									<label for="password" class="form-label">Mật khẩu mới</label> <input
										type="password" class="form-control" id="password"
										name="password" placeholder="Nhập mật khẩu mới">
								</div>
								<button type="submit" class="btn btn-primary">Cập Nhật</button>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Đóng</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%
		Taikhoan taikhoan = (Taikhoan) request.getAttribute("taikhoan");
		Integer idtaikhoan = (Integer) session.getAttribute("idtaikhoan");
		if (taikhoan != null && idtaikhoan != null) {
		%>
		<!-- Card for Username -->
		<div class="card info-card">
			<div class="card-header">Tên Tài Khoản</div>
			<div class="card-body">
				<p class="card-text"><%=taikhoan.getUsername()%></p>
			</div>


		</div>

		<!-- Card for Address -->
		<div class="card info-card">
			<div class="card-header">Địa Chỉ</div>
			<div class="card-body">
				<p class="card-text"><%=taikhoan.getAddress()%></p>
			</div>
		</div>

		<!-- Card for Email -->
		<div class="card info-card">
			<div class="card-header">Email</div>
			<div class="card-body">
				<p class="card-text"><%=taikhoan.getEmail()%></p>
			</div>
		</div>

		<!-- Card for Phone Number -->
		<div class="card info-card">
			<div class="card-header">Số Điện Thoại</div>
			<div class="card-body">
				<p class="card-text"><%=taikhoan.getSdt()%></p>
			</div>
		</div>


		<!-- ------------------------------CAP NHAT THONG TIN ----------------->
		<div class="d-flex justify-content-center mt-3">


			<div class="modal fade" id="modalThongTin" data-bs-backdrop="static"
				data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="staticBackdropLabel">Thông
								Tin Tài Khoản</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form action="matkhau?action=informa" method="POST">
								<input type="hidden" name="idtaikhoan"
									value="<%=request.getParameter("idtaikhoan")%>">
								<div class="mb-3">
									<label for="username" class="form-label">Tên đăng nhập
									</label> <input type="text" class="form-control" id="username"
										name="username" placeholder="Nhập tên đăng nhập mới"
										value="<%=(request.getAttribute("taikhoan") != null) ? ((Taikhoan) request.getAttribute("taikhoan")).getUsername() : ""%>">
								</div>

								<div class="mb-3">
									<label for="address" class="form-label">Địa chỉ</label> <input
										type="text" class="form-control" id="address" name="address"
										placeholder="Nhập địa chỉ mới"
										value="<%=(request.getAttribute("taikhoan") != null) ? ((Taikhoan) request.getAttribute("taikhoan")).getAddress() : ""%>">
								</div>

								<div class="mb-3">
									<label for="email" class="form-label">Email</label> <input
										type="text" class="form-control" id="email" name="email"
										placeholder="Nhập địa chỉ email mới"
										value="<%=(request.getAttribute("taikhoan") != null) ? ((Taikhoan) request.getAttribute("taikhoan")).getEmail() : ""%>">
								</div>

								<div class="mb-3">
									<label for="sdt" class="form-label">Số điện thoại</label> <input
										type="text" class="form-control" id="sdt" name="sdt"
										placeholder="Nhập số điện thoại mới"
										value="<%=(request.getAttribute("taikhoan") != null) ? ((Taikhoan) request.getAttribute("taikhoan")).getSdt() : ""%>">
								</div>
								<button type="submit" class="btn btn-success">Cập Nhật</button>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Đóng</button>
						</div>
					</div>
				</div>
			</div>


		</div>
		<!-- ---------------------------------------------------------------------- -->
		<%
		} else {
		%>
		<p class="text-danger">Không tìm thấy thông tin tài khoản!</p>
		<%
		}
		%>
		<div class="d-flex justify-content-between">
			<a href="javascript:history.back()" class="btn btn-secondary mt-4">Quay
				lại</a>
		</div>


		<!-- Modal -->


	</div>
	<br>
	<br>
	<br>
	<jsp:include page="footer.jsp"></jsp:include>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.js"></script>
</body>
</html>
