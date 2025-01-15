<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="quantri.com.entity.Orders"%>
<%@ page import="quantri.com.entity.CartItem"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán thành công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f5f8fc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .success-box {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 40px;
            max-width: 450px;
            width: 100%;
            animation: slideIn 0.5s ease-out;
        }
        .success-box .icon {
            font-size: 60px;
            color: #28a745;
            margin-bottom: 20px;
            animation: bounce 1s ease-in-out infinite;
        }
        .success-box h3 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }
        .success-box p {
            color: #666;
            margin-bottom: 30px;
        }
        .success-box .order-id {
            font-weight: bold;
            color: #333;
            font-size: 18px;
        }
        .success-box a.btn {
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .success-box a.btn:hover {
            background-color: #0056b3;
        }
        /* Animation effects */
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

    </style>
</head>
<body>
    <div class="success-box">
     <%
         Orders thanhcong = (Orders) request.getAttribute("thanhcong");
         if (thanhcong != null) {
     %>
         <div class="icon">
             <i class="fas fa-check-circle"></i>
         </div>
         <h3>Đặt hàng thành công</h3>
         <p>Mã số đơn hàng của bạn là: <span class="order-id"><%= thanhcong.getCodeorder() %></span></p>
         <p>Bạn có thể xem chi tiết trong <a href="lichsu">đơn hàng của tôi</a>.</p>
         <a href="homepage" class="btn btn-success">Tiếp tục mua hàng</a>
     <%
         } else {
             // Display error message if no order is found
             String error = (String) request.getAttribute("error");
             if (error != null) {
     %>
                 <h3><%= error %></h3>
                 <a href="homepage" class="btn btn-primary">Quay lại trang chủ</a>
     <%
             } else {
                 // Debugging if dathang is null
                 out.println("<h3>Order data not found.</h3>");
             }
         }
     %>
 </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.js"></script>
</body>
</html>
