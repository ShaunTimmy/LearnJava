<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="quantri.com.entity.Taikhoan"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Tài Khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
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
 
    </style>
</head>
<body>

    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="menu.jsp"></jsp:include>
    <jsp:include page="sideba.jsp"></jsp:include>
   

            <!-- Main Content -->
            <div class="col-md-9">
                <div class="account-info">
                    <div class="header-row">
                        <h2 class="mb-4 text-primary">Thông Tin Tài Khoản</h2>
                        <div>
                            <button type="button" class="btn btn-outline-success btn-icon" data-bs-toggle="modal" data-bs-target="#modalThongTin">
                                <i class="fas fa-edit me-1"></i> Cập Nhật
                            </button>
                            <button type="button" class="btn btn-outline-primary btn-icon" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                <i class="bi bi-lock"></i> Đổi Mật Khẩu
                            </button>
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

                    <!-- Modal for Updating Information -->
                    <div class="modal fade" id="modalThongTin" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Thông Tin Tài Khoản</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="thongtin?action=informa" method="POST">
                                        <input type="hidden" name="idtaikhoan" value="<%=request.getParameter("idtaikhoan")%>">
                                        <div class="mb-3">
                                            <label for="username" class="form-label">Tên đăng nhập</label>
                                            <input type="text" class="form-control" id="username" name="username" value="<%= taikhoan.getUsername() %>">
                                        </div>
                                        <div class="mb-3">
                                            <label for="address" class="form-label">Địa chỉ</label>
                                            <input type="text" class="form-control" id="address" name="address" value="<%= taikhoan.getAddress() %>">
                                        </div>
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="email" class="form-control" id="email" name="email" value="<%= taikhoan.getEmail() %>">
                                        </div>
                                        <div class="mb-3">
                                            <label for="sdt" class="form-label">Số điện thoại</label>
                                            <input type="text" class="form-control" id="sdt" name="sdt" value="<%= taikhoan.getSdt() %>">
                                        </div>
                                        <button type="submit" class="btn btn-success">Cập Nhật</button>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- --Change Passs -->
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
							<form action="thongtin?action=update" method="POST">
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

                    <!-- Logout Button -->
                    <div class="d-flex justify-content-between mt-3">
                        <a href="thongtin?action=delete" class="btn btn-outline-danger btn-icon mt-4" onclick="return confirm('Bạn có muốn xóa tài khoản không ?')">
                            <i class="bi bi-trash"></i> Xóa 
                        </a>
                        <a href="javascript:history.back()" class="btn btn-secondary mt-4">Quay
				lại</a>
                    </div>

                    <%
                        } else {
                    %>
                        <p class="text-danger">Không tìm thấy thông tin tài khoản!</p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
<br><br>
    <jsp:include page="footerpage.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
