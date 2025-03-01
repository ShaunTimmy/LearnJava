<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sidebar Hiện Đại</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
/* Sidebar Styles */
.sidebar {
    height: 100vh;
    width: 270px;
    position: fixed;
    background: linear-gradient(135deg, #1f4037, #99f2c8);
    padding-top: 20px;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.2);
    transition: all 0.3s;
    color: white;
}

.sidebar a {
    color: white;
    text-decoration: none;
    padding: 12px 20px;
    display: flex;
    align-items: center;
    font-size: 1.1rem;
    border-radius: 8px;
    transition: all 0.3s;
}
.sidebar a i {
    font-size: 1.3rem;
    margin-right: 12px;
}
.sidebar a:hover, .sidebar .active {
    background: rgba(255, 255, 255, 0.2);
    transform: translateX(5px);
}
.sidebar hr {
    border-color: rgba(255, 255, 255, 0.5);
}

/* Content Styles */
.content {
    margin-left: 150px;
    padding: 30px;
    transition: margin-left 0.3s;
    background: #f8f9fa;
    min-height: 100vh;
}

/* Responsive Sidebar */
@media (max-width: 768px) {
    .sidebar {
        width: 220px;
    }
    .content {
        margin-left: 220px;
    }
}
</style>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar d-flex flex-column">
            <a href="admin" class="d-flex align-items-center mb-3 px-3 active">
                <i class="bi bi-person-circle"></i> <span><%= session.getAttribute("username") %></span>
            </a>
            <hr>
            <nav class="nav flex-column">
                <a class="nav-item" href="sanpham"> <i class="bi bi-box-seam"></i> Quản Lý Sản Phẩm
<%
 Integer tongsp = (Integer) session.getAttribute("tongsp");
 if (tongsp != null && tongsp > 0) {
 %> <span
					class="badge badge-pill badge-danger <%=(tongsp > 0 ? "changed" : "")%>">
						<%=tongsp%>
				</span> <%
 }
 %>
 </a>
                <a class="nav-item" href="taikhoan"> <i class="bi bi-people"></i> Quản Lý Tài Khoản 
<%
 Integer slgdky = (Integer) session.getAttribute("slgdky");
 if (slgdky != null && slgdky > 0) {
 %> <span
					class="badge badge-pill badge-danger <%=(slgdky > 0 ? "changed" : "")%>">
						<%=slgdky%>
				</span> <%
 }
 %>
</a>
                <a class="nav-item" href="donhang"> <i class="bi bi-cart"></i> Quản Lý Đơn Hàng 
<%
 Integer tongdh= (Integer) session.getAttribute("tongdh");
 if (tongdh != null && tongdh > 0) {
 %> <span
					class="badge badge-pill badge-danger <%=(tongdh > 0 ? "changed" : "")%>">
						<%=tongdh%>
				</span> <%
 }
 %>
</a>
                <a class="nav-item" href="danhgia"> <i class="bi bi-star"></i> Quản Lý Đánh Giá 
<%
 Integer tongcmt= (Integer) session.getAttribute("tongcmt");
 if (tongcmt != null && tongcmt > 0) {
 %> <span
					class="badge badge-pill badge-danger <%=(tongcmt > 0 ? "changed" : "")%>">
						<%=tongcmt%>
				</span> <%
 }
 %>
</a>
                <a class="nav-item" href="thongke"> <i class="bi bi-bar-chart-line"></i> Thống Kê Doanh Thu </a>
<%
				Integer idtaikhoan = (Integer) session.getAttribute("idtaikhoan");
				if (idtaikhoan != null) {
				%>
				<a class="nav-item d-flex align-items-center mb-2 px-3"
					href="matkhau?action=infor&idtaikhoan=<%=idtaikhoan%>"> <i
					class="bi bi-people me-2"></i> Thông Tin Tài Khoản
				</a>
				<%
				} // Nếu chưa đăng nhập
				%>
				<hr>
               
                <a class="nav-item" href="logout"
                onclick="return confirm('Bạn có muốn đăng xuất tài khoản không ?')"> <i class="bi bi-box-arrow-right"></i> Đăng Xuất </a>
            </nav>
        </div>
        
      
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
