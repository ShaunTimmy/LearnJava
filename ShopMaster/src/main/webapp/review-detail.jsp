<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.*"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Đánh giá sản phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet" crossorigin="anonymous">
<!-- Thêm Font Awesome cho các biểu tượng -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>
<section class="hero-section text-center">
		<div class="container">
			<h1>Đánh giá sản phẩm</h1>
<p>Khám phá và đánh giá các sản phẩm chất lượng từ nhiều thương hiệu khác nhau. Chia sẻ ý kiến của bạn để giúp người khác dễ dàng đưa ra quyết định mua sắm thông minh và hợp lý.</p>

		</div>
	</section>
	<br>
	<div class="container mt-4">
		<h3 class="text-center">
			Đánh giá sản phẩm :
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
