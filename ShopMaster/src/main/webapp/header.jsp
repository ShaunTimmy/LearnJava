<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopCapy</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&display=swap" rel="stylesheet">
<style>
  h1.m-0 {
    font-family: 'Dancing Script', cursive;
        transform: translate(-65px, -5px);
  }
  .header-item {
    display: flex;
    align-items: center;
        transform: translate(112px, 4px);
  }
  .header-item .me-2 {
    margin-right: 10px;
  }
  .header-item .badge {
    position: absolute;
    top: -5px;
    right: -5px;
  }
</style>
</head>
<body>
<!-- Header -->
<header class="bg-dark text-white py-3">
  <div class="container d-flex justify-content-between align-items-center">
    <!-- Tên trang -->
    <h1 class="m-0">ShopCapy</h1>

    <!-- Ô tìm kiếm -->
<form class="d-flex w-50" action="product?action=search" method="post" style="max-width: 500px; margin: auto;">
  <div class="input-group">
    <input class="form-control" type="search" name="keyword" placeholder="Tìm kiếm sản phẩm..." aria-label="Search" style="border-radius: 30px 0 0 30px; border: 1px solid #ccc;"
    value="${keyword}">
    <button class="btn btn-outline-light" type="submit" style="border-radius: 0 30px 30px 0; background-color: #7158e2; border: 1px solid #7158e2;">
      <i class="bi bi-search"></i>
    </button>
  </div>
</form>

    
    <!-- Tài khoản, Giỏ hàng, Wishlist -->
    <div class="header-item">
      <!-- Tài khoản -->
      <div class="me-3">
        <i class="bi bi-person-circle fa-lg me-2"></i>
        <% String email= (String) session.getAttribute("email");
        Integer idtaikhoan = (Integer) session.getAttribute("idtaikhoan"); 
        if (email != null && idtaikhoan != null) { %>
          <span>Xin Chào Bạn</span> 
          <span class="text-white" style="margin-left: 10px;">|</span>
          <a href="thongtin?action=details&idtaikhoan=<%= idtaikhoan %>"
           class="text-white text-decoration-none mx-2">Thông tin</a>
        <% } else { %>
          <span class="text-white">Tài khoản</span>
        <% } %>
      </div>

      <!-- Giỏ hàng -->
      <div class="me-3 position-relative">
        <a href="giohang?action=list" class="text-white">
          <i class="bi bi-cart-fill fa-lg me-2"></i>

        </a>
        <% Integer soluong = (Integer) session.getAttribute("soluong"); if (soluong != null && soluong > 0) { %>
          <span class="badge bg-danger rounded-pill"><%= soluong %></span>
        <% } %>
      </div>

      <!-- Wishlist -->
      <div class="position-relative">
        <a href="wishlist?action=list" class="text-white">
          <i class="bi bi-heart-fill fa-lg me-2"></i> 
        </a>
        <% Integer itemCount = (Integer) session.getAttribute("itemCount"); if (itemCount != null && itemCount > 0) { %>
          <span class="badge bg-danger rounded-pill"><%= itemCount %></span>
        <% } %>
      </div>
      
    </div>
  </div>
</header>

<!-- Thêm Bootstrap JS và Popper.js từ CDN -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
