<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi Tiết Đánh Giá</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
    body {
        background-color: #f9f9f9;
        font-family: Arial, sans-serif;
    }
    .review-card {
        background: #ffffff;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .review-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }
    .username {
        font-weight: bold;
        font-size: 1.2em;
    }
    .proName {
        font-size: 1em;
        color: #6c757d;
    }
    .rating i {
        font-size: 1.2em;
        color: #ffc107; /* Màu vàng cho sao đầy */
        margin-right: 3px;
    }
    .rating i.fa-regular {
        color: #e0e0e0; /* Màu xám cho sao rỗng */
    }
    .review-body {
        font-size: 1em;
        color: #333;
        line-height: 1.6;
        margin-bottom: 15px;
    }
    .review-footer {
        font-size: 0.9em;
        color: #6c757d;
    }
    .container {
        margin-top: 50px;
    }
    .btn {
        font-size: 0.9em;
    }
</style>
</head>
<body>
<jsp:include page="sidebar.jsp"></jsp:include>
<div class="container">
    <div class="content">
    <h2 class="text-center mb-4">Chi Tiết Thông Tin Đánh Giá</h2>
        <div class="list-group">
            <%
            Reviews chitietCMT = (Reviews) request.getAttribute("chitietCMT");
            if (chitietCMT != null) {
            %>
            <div class="review-card">
                <div class="review-header">
                    <div class="username"><%= chitietCMT.getTaikhoan().getUsername() %></div>
                    <div class="proName"><%= chitietCMT.getSanpham().getProName() %></div>
                </div>
                <div class="rating">
                    <%
                    int rating = chitietCMT.getRatting(); // Lấy rating từ đối tượng review
                    for (int i = 1; i <= 5; i++) {
                        if (i <= rating) {
                    %>
                    <i class="fa-solid fa-star"></i>
                    <%
                        } else {
                    %>
                    <i class="fa-regular fa-star"></i>
                    <%
                        }
                    }
                    %>
                </div>
                <div class="review-body">
                    <p><%= chitietCMT.getComments() %></p>
                </div>
                <div class="review-footer">
                    <span>Thời gian: <%= chitietCMT.getTgian() %></span>
                </div>
            </div>
            <%
            } else {
            %>
            <div class="alert alert-info" role="alert">Chưa có đánh giá nào cho sản phẩm này.</div>
            <%
            }
            %>
            <div class="d-flex justify-content-start mt-3 gap-2">
                <a href="javascript:history.back()" class="btn btn-outline-secondary btn-sm">Quay Về</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
