<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopCapy - Liên Hệ</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style>
    /* Hero Section */
    section.hero-section {
        padding: 60px 0;
        background: linear-gradient(135deg, #70a1ff, #1e90ff);
        color: #fff;
        text-align: center;
    }
    section.hero-section h1 {
        font-size: 2.5rem;
        font-weight: bold;
        margin-bottom: 20px;
    }
    section.hero-section p {
        font-size: 1.2rem;
        margin-bottom: 0;
    }

    /* Contact Section */
    section.contact-section {
        padding: 50px 0;
        background-color: #f8f9fa;
    }
    .contact-card {
        background: #b3d9d9;
        border: none;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 30px;
        text-align: center;
        transition: transform 0.3s ease;
    }
    .contact-card:hover {
        transform: translateY(-10px);
    }
    .contact-card i {
        font-size: 2.5rem;
        color: #1e90ff;
        margin-bottom: 15px;
    }
    .contact-card h4 {
        font-size: 1.5rem;
        font-weight: bold;
        margin-bottom: 10px;
    }
    .contact-card p {
        font-size: 1rem;
        color: #6c757d;
    }
    .carousel-item.active img {
    filter: brightness(85%);
}
</style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="menu.jsp"></jsp:include>

<!-- The slideshow/carousel -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="img/lienhe1.jpg" alt="Los Angeles" class="d-block" style="width:100%;height:400px">
    </div>

  </div>

<section class="contact-section">
    <div class="container">
        <div class="row gy-4">
            <!-- Address -->
            <div class="col-md-4">
                <div class="contact-card">
                    <i class="fas fa-map-marker-alt"></i>
                    <h4>Địa Chỉ</h4>
                    <p>123 Đường A, Quận X, Hà Nội </p>
                </div>
            </div>
            <!-- Phone -->
            <div class="col-md-4">
                <div class="contact-card">
                    <i class="fas fa-phone-alt"></i>
                    <h4>Điện Thoại</h4>
                    <p>(+84) 123 456 789</p>
                </div>
            </div>
            <!-- Email -->
            <div class="col-md-4">
                <div class="contact-card">
                    <i class="fas fa-envelope"></i>
                    <h4>Email</h4>
                    <p>support@shopmaster.com</p>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footerpage.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
