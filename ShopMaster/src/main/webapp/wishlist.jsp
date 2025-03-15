<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Wishlist"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="java.text.DecimalFormat"%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh Sách Sản Phẩm Yêu Thích</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
  <style>
    body {
      background-color: #f8f9fa;
    }

    .hero-section {
      background-color: #70a1ff;
      color: white;
      padding: 50px 0;
      text-align: center;
      border-radius: 0 0 20px 20px;
    }

    .card {
      border: none;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
      transform: scale(1.05);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
    }

    .card-img-top {
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
      object-fit: cover;
      height: 250px;
    }

    .card-body {
      padding: 20px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .card-title {
      font-size: 1.2rem;
      font-weight: bold;
      color: #333;
    }

    .card-text {
      font-size: 1rem;
      margin-bottom: 15px;
      color: #555;
    }

    .btn-info {
      background-color: #17a2b8;
      border-color: #17a2b8;
      color: white;
      font-weight: bold;
    }

    .btn-info:hover {
      background-color: #138496;
      border-color: #117a8b;
    }

    .btn-danger {
      background-color: #dc3545;
      border-color: #dc3545;
      color: white;
      font-weight: bold;
    }

    .btn-danger:hover {
      background-color: #c82333;
      border-color: #bd2130;
    }

    .col-md-4 {
      display: flex;
      justify-content: center;
      margin-bottom: 30px;
    }

    .container {
      margin-top: 50px;
    }

    footer {
      background-color: #343a40;
      color: white;
      text-align: center;
      padding: 20px 0;
    }

    .no-products-message {
      font-size: 1.2rem;
      color: #6c757d;
    }

    .pagination-container {
      display: flex;
      justify-content: center;
      margin-top: 30px;
    }

    .pagination-button {
      margin: 0 5px;
    }
    .carousel-inner img {
    filter: brightness(50%);
}
.carousel-item {
    position: relative;
}

.carousel-caption {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(1%, -50%);
    text-align: center;
    padding: 15px;
    border-radius: 10px;
    animation: fadeInUp 1s ease-in-out;
}

.carousel-caption h3 {
    font-size: 30px;
    font-weight: bold;
    text-transform: uppercase;
    color: #fff;
    animation: slideInDown 1s ease-in-out;
}

.carousel-caption p {
    font-size: 18px;
    color: #fff;
    animation: fadeIn 1.5s ease-in-out;
}

/* Hiệu ứng mượt khi text xuất hiện */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translate(1%, -60%);
    }
    to {
        opacity: 1;
        transform: translate(1%, -50%);
    }
}

@keyframes slideInDown {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}
  </style>
</head>
<body>
  <jsp:include page="header.jsp"></jsp:include>
  <jsp:include page="menu.jsp"></jsp:include>

 <!-- Carousel -->
<div id="demo" class="carousel slide" data-bs-ride="carousel">

  <!-- Indicators/dots -->
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
  </div>
 
  <!-- The slideshow/carousel -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="img/yeuthich.jpg" alt="Los Angeles" class="d-block" style="width:100%;height:330px">
       <div class="carousel-caption d-none d-md-block">
        <h3>Sản phẩm yêu thích</h3>
        <p>Chọn ngay những món hàng hot nhất dành riêng cho bạn!</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="img/yeuthich.webp" alt="Chicago" class="d-block" style="width:100%;height:330px">
        <div class="carousel-caption d-none d-md-block">
        <h3>Ưu đãi dành riêng</h3>
         <p>Giảm giá hấp dẫn chỉ dành cho các sản phẩm yêu thích của bạn!</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="img/wishlist2.webp" alt="New York" class="d-block" style="width:100%;height:330px">
       <div class="carousel-caption d-none d-md-block">
         <h3>Mua sắm nhanh chóng</h3>
        <p>Thêm vào danh sách yêu thích và đặt hàng ngay chỉ với một cú click!</p>
      </div>
    </div>
  
  </div>
	<!-- Left and right controls/icons -->
  <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div>
<br>

  <!-- Wishlist Section -->
  <div class="container">
    <div class="row">
      <%
        List<Wishlist> wishLists = (List<Wishlist>) request.getAttribute("wishLists");
        DecimalFormat decimalFormat = new DecimalFormat("#,###");
        if (wishLists != null && !wishLists.isEmpty()) {
          for (Wishlist wishlist : wishLists) {
            Sanpham sp = wishlist.getSanpham();
      %>
      <div class="col-md-4 mb-4"  data-aos="flip-down">
        <div class="card">
          <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(sp.getImgfile()) %>" class="card-img-top" alt="<%= sp.getProName() %>">
          <div class="card-body">
            <h5 class="card-title"><%= sp.getProName() %></h5>
            <p class="card-text">
              <strong>Giá: </strong><%= decimalFormat.format(sp.getPrice()) %> VND
            </p>
            <a href="wishlist?action=delete&idlist=<%= wishlist.getIdlist() %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có muốn xóa dữ liệu này không ?')">Xóa</a>
          </div>
        </div>
      </div>
      <%
          }
        } else {
      %>
      <div class="col-12 text-center">
        <p class="no-products-message">Không có sản phẩm nào trong danh sách yêu thích của bạn.</p>
      </div>
      <%
        }
      %>
    </div>

    <!-- Pagination Section -->
    <div class="pagination-container">
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
      <a href="wishlist?action=list&page=<%= currentPage - 1 %>" class="btn btn-outline-success pagination-button">
        <i class="fas fa-arrow-left me-1"></i> Trang Trước
      </a>
      <%
        }
      %>

      <span class="btn btn-outline-secondary disabled pagination-button">Trang <%= currentPage %> / <%= totalPages %></span>

      <%
        if (currentPage < totalPages) {
      %>
      <a href="wishlist?action=list&page=<%= currentPage + 1 %>" class="btn btn-outline-success pagination-button">
        Trang Kế Tiếp <i class="fas fa-arrow-right ms-1"></i>
      </a>
      <%
        }
      %>
    </div>
  </div>
<br><br>
  <jsp:include page="footerpage.jsp"></jsp:include>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    AOS.init();
  </script>
</body>
</html>
