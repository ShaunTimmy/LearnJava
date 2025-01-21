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
  </style>
</head>
<body>
  <jsp:include page="header.jsp"></jsp:include>
  <jsp:include page="menu.jsp"></jsp:include>

  <!-- Hero Section -->
  <section class="hero-section">
    <div class="container">
      <h1>Sản Phẩm Yêu Thích</h1>
      <p>Khám phá danh sách các sản phẩm yêu thích mà bạn đã chọn và muốn sở hữu.</p>
    </div>
  </section>

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
      <div class="col-md-4 mb-4" data-aos="fade-up-right">
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
