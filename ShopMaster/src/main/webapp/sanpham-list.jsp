<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Sản Phẩm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>
	
	<!-- NOI DUNG CHINH -->
	<div class="content border border-secondary rounded shadow p-4 mt-4 h-500 w-20">
        <div class="container mt-5">
            <h1 class="text-center">Danh Sách Sản Phẩm</h1>
            <div class="mb-3 d-flex flex-column flex-md-row justify-content-between align-items-center">
                <!-- Nút thêm sản phẩm -->
                <a href="sanpham?action=new" class="btn btn-outline-dark mb-3 mb-md-0">
                    <i class="fas fa-plus-circle me-1"></i>Thêm Sản Phẩm Mới
                </a>

                <!-- Form tìm kiếm -->
                <div class="card p-2 shadow-sm w-50 w-md-30">
                    <form action="sanpham?action=search" method="post" class="input-group">
                        <input type="hidden" name="action" value="search"> 
                        <input type="text" name="keyword" class="form-control" placeholder="Bạn cần tìm gì..." required>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            </div>

            <!-- DANH SÁCH SẢN PHẨM (Card layout) -->
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <% 
                // Hiển thị danh sách sản phẩm 
                List<Sanpham> listSP = (List<Sanpham>) request.getAttribute("listSP");
                if (listSP != null && !listSP.isEmpty()) {
                    for (Sanpham sp : listSP) { 
                %>
                <div class="col">
                    <div class="card shadow-sm">
                        <img src="<%
                            byte[] imgData = sp.getImgfile();
                            if (imgData != null) {
                                String base64Image = java.util.Base64.getEncoder().encodeToString(imgData);
                        %>data:image/jpeg;base64,<%= base64Image %><% 
                            } else { 
                        %>#<% } %>" class="card-img-top" alt="<%=sp.getProName()%>" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title"><%=sp.getProName()%></h5>
                            <p class="card-text">
                                <strong>Giá: </strong><%= new DecimalFormat("#,###").format(sp.getPrice()) %> VND<br>
                                <strong>Số lượng: </strong><%= sp.getStock() %><br>
                                <strong>Thời gian giao hàng: </strong>
                                <% 
                                String thoigianGH = sp.getThoigianGH();
                                String hienThi = "";
                                switch (thoigianGH) {
                                    case "fast": hienThi = "1-3 ngày"; break;
                                    case "steady": hienThi = "2-5 ngày"; break;
                                    case "slow": hienThi = "3-7 ngày"; break;
                                    case "quick": hienThi = "Ngày mai"; break;
                                    default: hienThi = "Không xác định"; break;
                                }
                                %>
                                <%=hienThi%>
                            </p>
                            <p class="card-text"><strong>Loại: </strong>
                                <% 
                                String theloai = sp.getTheloai();
                                String tloai = "";
                                switch (theloai) {
                                    case "dientu": tloai = "Điện tử"; break;
                                    case "giadung": tloai = "Gia dụng"; break;
                                    case "phukien": tloai = "Phụ kiện"; break;
                                    default: tloai = "Không xác định"; break;
                                }
                                %>
                                <%=tloai%>
                            </p>
                            <div class="d-flex justify-content-between">
                                <a href="sanpham?action=edit&idproduct=<%=sp.getIdproduct()%>" class="btn btn-outline-info btn-sm">
                                    <i class="fas fa-edit me-1"></i>Cập nhật
                                </a>
                                <a href="sanpham?action=delete&idproduct=<%=sp.getIdproduct()%>" class="btn btn-outline-danger btn-sm"
                                   onclick="return confirm('Bạn có muốn xóa dữ liệu này không ?')">
                                    <i class="fas fa-trash me-1"></i>Xóa
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <% 
                    } 
                } else { 
                %>
                <div class="col-12">
                    <div class="alert alert-warning text-center" role="alert">
                        Không có sản phẩm nào trong danh sách
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Phân trang -->
            <div class="d-flex justify-content-center mt-3">
                <%
                Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                if (currentPage == null) currentPage = 1;
                if (totalPages == null) totalPages = 1;
                if (currentPage > 1) { 
                %>
                <a href="sanpham?action=list&page=<%=currentPage - 1%>" class="btn btn-outline-success mx-1">
                    <i class="fas fa-arrow-left me-1"></i>Trang Trước
                </a>
                <% } %>
                <span class="btn btn-outline-secondary disabled mx-1">
                    Trang <%=currentPage%> / <%=totalPages%>
                </span>
                <%
                if (currentPage < totalPages) { 
                %>
                <a href="sanpham?action=list&page=<%=currentPage + 1%>" class="btn btn-outline-success mx-1">
                    Trang Kế Tiếp<i class="fas fa-arrow-right ms-1"></i>
                </a>
                <% } %>
            </div>
        </div>
    </div>

    <br>
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
