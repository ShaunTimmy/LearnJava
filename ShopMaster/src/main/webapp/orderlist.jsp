<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.*"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lịch Sử Đặt Hàng</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
    }
    .order-card {
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 15px;
        background-color: #fff;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .order-card img {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
    }
    .empty-cart {
        font-style: italic;
        color: #6c757d;
        text-align: center;
    }
    .order-card .order-details {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .order-card .order-details span {
        font-weight: bold;
    }
</style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="menu.jsp"></jsp:include>
<jsp:include page="sideba.jsp"></jsp:include>

<!-- Container div to wrap content for proper layout -->
<div class="col-md-9">
    <h2 class="text-center mb-4" data-aos="fade-down">Lịch Sử Đặt Hàng</h2>

    <%
        List<Orders> lichsuOrders = (List<Orders>) request.getAttribute("lichsu");
        DecimalFormat df = new DecimalFormat("#,###");
        if (lichsuOrders != null && !lichsuOrders.isEmpty()) {
            for (Orders dh : lichsuOrders) {
                Sanpham sp = dh.getSanpham();
    %>

    <div class="order-card" data-aos="fade-up">
        <div class="order-details">
            <div>
                <h5>Mã đơn hàng: <%= dh.getCodeorder() %></h5>
                <p class="text-muted">Thời gian đặt hàng : <%= dh.getOrderdate() %></p>
            </div>
            <div>
                <span class="badge bg-success"><%= dh.getStatu() %></span>
            </div>
        </div>

        <div class="row">
            <div class="col-md-3">
                <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(sp.getImgfile()) %>" alt="<%= sp.getProName() %>" />
            </div>
            <div class="col-md-9">
                <p><strong>Tên sản phẩm:</strong> <%= sp.getProName() %></p>
                <p><strong>Số lượng:</strong> <%= dh.getQuantity() %></p>
                <p><strong>Tổng tiền:</strong> <%= df.format(dh.getTotalprice()) %> VND</p>
            </div>
        </div>
    </div>

    <%
            }
        } else {
    %>
    <div class="empty-cart">Bạn chưa có đơn hàng nào.</div>
    <%
        }
    %>

    <div class="d-flex justify-content-between">
        <a href="javascript:history.back()" class="btn btn-secondary mt-4">Quay lại</a>
    </div>
</div>
  </div>
</div>
  </div>
<br><br><br>
<jsp:include page="footerpage.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    AOS.init();
</script>
</body>
</html>
