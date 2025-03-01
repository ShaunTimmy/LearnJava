<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.*"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>ShopCapy-Đánh giá sản phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet" crossorigin="anonymous">
<!-- Thêm Font Awesome cho các biểu tượng -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&display=swap"
	rel="stylesheet">
	
<style>
.review-card {
	background-color: #f8f9fa;
	padding: 15px;
	border-radius: 10px;
	margin-bottom: 15px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.review-card .review-header {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.review-card .review-header .username {
	font-weight: bold;
	margin-right: 10px;
}

.review-card .review-header .rating {
	color: #f39c12;
}

.review-card .review-footer {
	font-size: 0.9rem;
	color: #6c757d;
}

.text-center {
	text-align: center;
}
section.hero-section {
    padding: 60px 0;
    background-color: #70a1ff;
    color: white;
}
h3.text-center {
	font-family: 'Dancing Script', cursive;
	font-size: 33px;
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
      <img src="img/review.avif" alt="Los Angeles" class="d-block" style="width:100%;height:400px">
       <div class="carousel-caption d-none d-md-block">
          <h3>Khách hàng nói gì?</h3>
        <p>Hàng ngàn đánh giá chân thực từ khách hàng đã mua sắm!</p>
    </div>
    </div>
    <div class="carousel-item">
      <img src="img/reiew.avif" alt="Chicago" class="d-block" style="width:100%;height:400px">
        <div class="carousel-caption d-none d-md-block">
          <h3>Sản phẩm chất lượng</h3>
         <p>Được chứng nhận bởi những phản hồi tích cực từ người dùng!</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="img/review2.avif" alt="New York" class="d-block" style="width:100%;height:400px">
       <div class="carousel-caption d-none d-md-block">
         <h3>Trải nghiệm tuyệt vời</h3>
        <p>Khách hàng hài lòng với dịch vụ và chất lượng sản phẩm!</p>
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
	<div class="container mt-4">
		<h3 class="text-center">
			Cảm nhận của khách hàng về :
			<%=(request.getAttribute("proName") != null) ? request.getAttribute("proName") : "Tên sản phẩm không có sẵn"%>
		</h3>


		<div class="list-group">
			<%
			List<Reviews> reviews = (List<Reviews>) request.getAttribute("reviews");
			if (reviews != null) {
				for (Reviews review : reviews) {
			%>
			<div class="review-card">
				<div class="review-header">
					<div class="username"><%=review.getTaikhoan().getUsername()%></div>
					<div class="rating">
						<%
						int rating = review.getRatting(); // Lấy rating từ đối tượng review
						for (int i = 1; i <= 5; i++) {
							if (i <= rating) {
						%>
						<i class="fa-solid fa-star"></i>
						<!-- Hiển thị sao đầy -->
						<%
						} else {
						%>
						<i class="fa-regular fa-star"></i>
						<!-- Hiển thị sao rỗng -->
						<%
						}
						}
						%>
					</div>
				</div>
				<div class="review-body">
					<p><%=review.getComments()%></p>
				</div>
				<div class="review-footer">
					<span><%=review.getTgian()%></span>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<div class="alert alert-info" role="alert">Chưa có đánh giá nào
				cho sản phẩm này.</div>
			<%
			}
			%>
			<div class="d-flex justify-content-start mt-3 gap-2">
					<a href="javascript:history.back()" class="btn btn-outline-secondary btn-sm">Quay Về</a>
			
				</div>
		</div>
	</div>
	<br><br><br><br><br><br>
<jsp:include page="footerpage.jsp"></jsp:include>
</body>
</html>
