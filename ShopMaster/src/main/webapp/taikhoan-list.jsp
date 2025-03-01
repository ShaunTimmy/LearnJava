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
<style type="text/css">
.content.border.border-secondary.rounded.shadow-lg.p-4.mt-4 {
    margin-left: 280px;
}
.container.mt-5 {
    width: 102%;
    margin-left: -12px;
}
</style>
</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>

	<!-- Nội dung trang chính -->
<div class="content border border-secondary rounded shadow-lg p-4 mt-4" style="min-height: 500px; width: 78%;">
    <div class="container mt-5">
        <h1 class="text-center mb-4">Danh Sách Tài Khoản</h1>
        
        <!-- Thanh tìm kiếm căn trái, không quá rộng -->
        <div class="d-flex justify-content-center align-items-center">
            <div class="card p-2 shadow-sm w-50 w-md-30 border-0">
                <form action="taikhoan?action=search" method="post" class="input-group">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="keyword" class="form-control" placeholder="Bạn cần tìm gì..." required
                    value="${keyword}">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
        </div>

        <!-- Hiển thị danh sách tài khoản theo dạng card -->
        <div class="row mt-4">
            <% List<Taikhoan> listTK = (List<Taikhoan>) request.getAttribute("listTK"); %>
            <% if (listTK != null && !listTK.isEmpty()) { %>
                <% for (Taikhoan tk : listTK) { %>
                <div class="col-12 col-md-6 col-lg-4 mb-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title text-primary">
                                <i class="fas fa-user me-2"></i><%= tk.getUsername() %>
                            </h5>
                            <p class="card-text text-muted">
                                <i class="fas fa-map-marker-alt me-2"></i><%= tk.getAddress() %>
                            </p>
                            <p class="card-text">
                                <i class="fas fa-envelope me-2"></i><%= tk.getEmail() %>
                            </p>
                            <p class="card-text">
                                <i class="fas fa-phone-alt me-2"></i><%= tk.getSdt() %>
                            </p>
                            <p class="card-text">
                                <i class="fas fa-user-tag me-2"></i>
                                <% String role = tk.getRole(); String vatro = role.equals("admin") ? "Quản trị viên" : "Khách hàng"; %>
                                <%= vatro %>
                            </p>
                            <a href="taikhoan?action=delete&idtaikhoan=<%= tk.getIdtaikhoan() %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?')">
                                <i class="fas fa-trash me-1"></i>Xóa
                            </a>
                        </div>
                    </div>
                </div>
                <% } %>
            <% } else { %>
                <div class="col-12 text-center text-muted">Không có tài khoản nào được tìm thấy.</div>
            <% } %>
        </div>

        <!-- Phân trang -->
        <div class="d-flex justify-content-center mt-3">
            <% Integer currentPage = (Integer) request.getAttribute("currentPage"); Integer totalPages = (Integer) request.getAttribute("totalPages"); %>
            <% currentPage = (currentPage == null) ? 1 : currentPage; totalPages = (totalPages == null) ? 1 : totalPages; %>
            
            <% if (currentPage > 1) { %>
                <a href="taikhoan?action=list&page=<%= currentPage - 1 %>" class="btn btn-outline-success mx-1">
                    <i class="fas fa-arrow-left me-1"></i>Trang Trước
                </a>
            <% } %>
            
            <span class="btn btn-outline-secondary disabled mx-1">Trang <%= currentPage %> / <%= totalPages %></span>
            
            <% if (currentPage < totalPages) { %>
                <a href="taikhoan?action=list&page=<%= currentPage + 1 %>" class="btn btn-outline-success mx-1">
                    Trang Kế Tiếp <i class="fas fa-arrow-right ms-1"></i>
                </a>
            <% } %>
        </div>
    </div>
</div>

	<jsp:include page="footer.jsp"></jsp:include>

	<!-- Script Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
