<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopCapy-Tìm Kiếm Sản Phẩm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
      
   <style>
    /* Đảm bảo tất cả các thẻ card đều có cùng chiều cao */
 .card {
    border: none; /* Bỏ viền của thẻ card */
    box-shadow: none; /* Bỏ bóng đổ nếu có */
     width: 100%;
     height: 200px; 
}
.card {
	transition: transform 0.3s;
}

.card:hover {
	transform: scale(1.1);
}

.card-img-top {
    width: 100%; /* Đảm bảo ảnh chiếm hết chiều rộng */
    height: 200px; /* Giới hạn chiều cao ảnh */
  
}

.card-body {
    flex-grow: 1; /* Đảm bảo nội dung card có thể giãn nở đều */
}
    /* Giới hạn chiều cao của phần text, tránh trường hợp quá dài làm thẻ không đồng đều */
    .card-text {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    /* Đảm bảo các thẻ sản phẩm có chiều cao giống nhau */
    .col-md-4 {
        display: flex;
        justify-content: space-between;
    }
</style>
   
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="menu.jsp"></jsp:include>
    <div class="container mt-4">
    <h2 class="text-center">Các Sản Phẩm Liên Quan : <%= request.getAttribute("keyword") %></h2>
    <br><br>
    <div class="row">
        <%
            List<Sanpham> listSP = (List<Sanpham>) request.getAttribute("listSP");
            DecimalFormat decimalFormat = new DecimalFormat("#,###");

            if (listSP != null && !listSP.isEmpty()) {
                for (Sanpham sp : listSP) {
        %>
            <div class="col-md-4 mb-4" data-aos="fade-down">
                <div class="card">
                    <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(sp.getImgfile()) %>"
                         class="card-img-top" alt="<%= sp.getProName() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= sp.getProName() %></h5>
                        <p class="card-text">
                            <strong>Giá: </strong><%= decimalFormat.format(sp.getPrice()) %> VND
                        </p>
                        <a href="product?action=details&idproduct=<%= sp.getIdproduct() %>" class="btn btn-outline-info btn-sm">Xem Chi Tiết</a>
                    </div>
                </div>
            </div>
        <% 
                }
            } else {
        %>
            <div class="col-12 text-center">
                <p>Không có sản phẩm nào trong danh sách.</p>
            </div>
        <% 
            }
        %>
    </div>
</div>
   

    <!-- Phân trang -->
    <div class="d-flex justify-content-center mt-3">
        <%
            Integer currentPage = (Integer) request.getAttribute("currentPage");
            Integer totalPages = (Integer) request.getAttribute("totalPages");

            if (currentPage == null) {
                currentPage = 1;
            }
            if (totalPages == null) {
                totalPages = 1;
            }

            if (currentPage > 1) {
        %>
            <a href="product?action=list&page=<%= currentPage - 1 %>" class="btn btn-outline-success mx-1">Trang Trước</a>
        <%
            }

            // Hiển thị số trang
        %>
        <span class="btn btn-outline-secondary disabled mx-1">Trang <%= currentPage %> / <%= totalPages %></span>

        <%
            if (currentPage < totalPages) {
        %>
            <a href="product?action=list&page=<%= currentPage + 1 %>" class="btn btn-outline-success mx-1">Trang Kế Tiếp</a>
        <%
            }
        %>
    </div>

</div> <!-- End of container -->

   <br><br><br><br><br><br><br>
    <jsp:include page="footerpage.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
      <script>
  AOS.init();
</script>
</body>
</html>