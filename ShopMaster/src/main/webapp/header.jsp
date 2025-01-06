<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"
	rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&display=swap" rel="stylesheet">
	<style >
	h1.m-0 {
    font-family: 'Dancing Script', cursive;
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
    <form class="d-flex w-50" action="product?action=search" method="post">
      <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm kiếm sản phẩm..." aria-label="Search">
      <button class="btn btn-outline-light" type="submit"><i class="fab fa-searchengin"></i></button>
    </form>
    
<!-- Icon Tài khoản và Đăng xuất -->
<div class="d-flex align-items-center">
 <a href="#"> <i class="fas fa-user-circle fa-lg me-2"></i>
  
  <!-- Kiểm tra nếu người dùng đã đăng nhập -->
  <%
    String username = (String) session.getAttribute("username");
    if (username != null) {  // Nếu đã đăng nhập
  %>
    <span><%= username %></span> </a>
    <!-- Hiển thị dấu phân tách | nếu đã đăng nhập -->
    <span class="text-white mx-2">|</span> 
    <a href="dangxuat" class="text-white text-decoration-none ms-2">Đăng xuất</a>
  <%
    } else {  // Nếu chưa đăng nhập
  %>
    <span class="text-white">Tài khoản</span> <!-- Thay <p> bằng <span> để nằm ngang hàng -->
  <%
    }
  %>
</div>

</div>
</header>




   <!-- Thêm Bootstrap JS và Popper.js từ CDN -->
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>