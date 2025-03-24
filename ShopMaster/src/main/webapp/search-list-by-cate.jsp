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
<style >
.container.mt-5 {
    width: 80%;
    margin-left: 115px;
}
.content.border.border-secondary.rounded.shadow-lg.p-4.mt-4 {
    margin-left: 280px;
}
.container.mt-5 {
    width: 102%;
    margin-left: -12px;
}
form.cate.p-2.shadow-sm.w-50.w-md-30 {
    transform: translateY(-56px);
}
</style>
</head>
<body>
<jsp:include page="sidebar.jsp"></jsp:include>
<div class="content border border-secondary rounded shadow-lg p-4 mt-4" style="min-height: 500px; width: 78%;">
    <div class="container mt-5">
 <form action="sanpham?action=category" method="POST" class="cate p-2 shadow-sm w-50 w-md-30">
    <select class="form-select" name="searchCate" onchange="this.form.submit()">
        <option value="">Chọn danh mục</option>
        <option value="dientu" ${selectedCate == 'dientu' ? 'selected' : ''}>Điện tử</option>
        <option value="giadung" ${selectedCate == 'giadung' ? 'selected' : ''}>Gia dụng</option>
        <option value="phukien" ${selectedCate == 'phukien' ? 'selected' : ''}>Phụ kiện</option>
    </select>
</form>
<br>
        <h1 class="text-center text-primary">Phân Loại Sản Phẩm</h1>
        <br>
        
        <!-- DANH SÁCH SẢN PHẨM (Card layout) -->
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <% List<Sanpham> listSP = (List<Sanpham>) request.getAttribute("listSP");
            if (listSP != null && !listSP.isEmpty()) {
                for (Sanpham sp : listSP) { %>
            <div class="col">
                <div class="card shadow-sm border-0">
                    <img src="<% byte[] imgData = sp.getImgfile();
                        if (imgData != null) {
                            String base64Image = java.util.Base64.getEncoder().encodeToString(imgData); %>data:image/jpeg;base64,<%= base64Image %><% } else { %>#<% } %>" 
                        class="card-img-top" alt="<%=sp.getProName()%>" style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title text-dark"><%=sp.getProName()%></h5>
                        <p class="card-text text-muted">
                            <strong>Giá: </strong><%= new DecimalFormat("#,###").format(sp.getPrice()) %> VND<br>
                            <strong>Số lượng: </strong><%= sp.getStock() %><br>
                            <strong>Thời gian giao hàng: </strong>
                            <% String thoigianGH = sp.getThoigianGH();
                            String hienThi = "";
                            switch (thoigianGH) {
                                case "fast": hienThi = "1-3 ngày"; break;
                                case "steady": hienThi = "2-5 ngày"; break;
                                case "slow": hienThi = "3-7 ngày"; break;
                                case "quick": hienThi = "Ngày mai"; break;
                                default: hienThi = "Không xác định"; break;
                            } %>
                            <%=hienThi%>
                        </p>
                        <p class="card-text text-muted"><strong>Loại: </strong>
                            <% String theloai = sp.getTheloai();
                            String tloai = "";
                            switch (theloai) {
                                case "dientu": tloai = "Điện tử"; break;
                                case "giadung": tloai = "Gia dụng"; break;
                                case "phukien": tloai = "Phụ kiện"; break;
                                default: tloai = "Không xác định"; break;
                            } %>
                            <%=tloai%>
                        </p>
                        <div class="d-flex justify-content-between">
                            <a href="sanpham?action=edit&idproduct=<%=sp.getIdproduct()%>" class="btn btn-outline-info btn-sm">
                                <i class="fas fa-edit me-1"></i> Cập nhật
                            </a>
                            <a href="sanpham?action=delete&idproduct=<%=sp.getIdproduct()%>" class="btn btn-outline-danger btn-sm"
                               onclick="return confirm('Bạn có muốn xóa dữ liệu này không ?')">
                                <i class="fas fa-trash me-1"></i> Xóa
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <% } } else { %>
            <div class="col-12">
                <div class="alert alert-warning text-center" role="alert">
                    Không có sản phẩm nào trong danh sách
                </div>
            </div>
            <% } %>
        </div>

     	<div class="text-center mt-4">
    <a href="sanpham?action=list" class="btn btn-outline-secondary">Quay Lại</a>
</div>
   
    </div>
</div>


    <br>
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>