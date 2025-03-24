<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="quantri.com.entity.Orders"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thanh toán thành công</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
	background-color: #f4f7fa;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	font-family: 'Arial', sans-serif;
}

.success-box {
	background-color: #ffffff;
	border-radius: 12px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
	padding: 35px;
	width: 100%;
	max-width: 800px;
	animation: fadeIn 0.5s ease-out;
}

.icon {
	font-size: 70px;
	color: #28a745;
	margin-bottom: 20px;
	animation: bounce 1.5s ease-in-out infinite;
	    margin-top: 50px;
	
	
}

h3 {
	font-size: 28px;
	color: #333;
	font-weight: bold;
	margin-bottom: 15px;
}

p {
	color: #555;
	font-size: 16px;
	margin-bottom: 12px;
	line-height: 1.5;
}

.order-id {
	font-weight: bold;
	color: #007bff;
	font-size: 18px;
}

.btn-custom {
	background-color: #007bff;
	color: #fff;
	padding: 10px 25px;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 500;
	transition: background-color 0.3s ease;
	text-decoration: none;
	display: inline-block;
	margin-top: 10px;
}

.btn-custom:hover {
	background-color: #0056b3;
}

/* Payment Information Section */
.payment-info {
	background-color: #fafafa;
	border: 1px solid #e0e0e0;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
	width: 100%;
	max-width: 320px;
}

.payment-info h4 {
	font-size: 20px;
	color: #333;
	font-weight: 600;
	margin-bottom: 15px;
	text-align: center;
}

.payment-info img {
	width: 180px;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	margin-bottom: 10px;
	transition: transform 0.3s ease;
}

.payment-info img:hover {
	transform: scale(1.05);
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(15px);
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
        transform: translateY(-12px);
    }
    60% {
        transform: translateY(-8px);
    }
}

.order-infor {
	transform: translateY(121px);
	height: 100px;
}
</style>
</head>
<body>

	<div class="success-box">
		<!-- Icon chính giữa -->
		<div class="text-center">
			<i class="fas fa-check-circle icon"></i>
		</div>

		<div class="d-flex justify-content-between mt-4">
			<!-- Bên trái: Thông tin đơn hàng -->
			<div class="order-infor">
				<%
				Orders thanhcong = (Orders) request.getAttribute("thanhcong");
				if (thanhcong != null) {
				%>
				<h3>Đặt hàng thành công!</h3>
				<p>
					Mã đơn hàng của bạn là: <span class="order-id"><%=thanhcong.getCodeorder()%></span>
				</p>
				<p>
					Bạn có thể xem chi tiết trong <a href="lichsu"
						class="text-decoration-underline">đơn hàng của tôi</a>.
				</p>
				<%
				} else {
				String error = (String) request.getAttribute("error");
				if (error != null) {
				%>
				<h3><%=error%></h3>
				<a href="homepage" class="btn-custom">Quay lại trang chủ</a>
				<%
				} else {
				out.println("<h3>Không tìm thấy dữ liệu đơn hàng.</h3>");
				}
				}
				%>
				<div
					style="background-color: #ffe6e6; color: #cc0000; padding: 12px; border: 1px solid #cc0000; border-radius: 6px;
					 margin-bottom: 16px; font-size: 16px; font-weight: bold;
					 margin-left: -21px;
                     width: 93%;">
					⚠️ Quý khách vui lòng ghi đúng <strong>Mã Đơn Hàng</strong> khi
					chuyển khoản để đảm bảo giao dịch được xác nhận nhanh chóng !. Sai
					chúng tôi không chịu trách nhiệm, cảm ơn quý khách .
				</div>
			</div>

			<!-- Bên phải: Thông tin thanh toán -->
			<div class="payment-info">
				<h4>Thông tin chuyển khoản</h4>
				<p>
					<strong>Ngân hàng:</strong> BIDV
				</p>
				<div class="text-center">
					<img src="img/qr.jpg" alt="QR Code">
				</div>
				<p>
					<strong>Số tài khoản:</strong> 1234 5678 9101
				</p>
				<p>
					<strong>Chủ tài khoản:</strong> Shirley
				</p>
				<p>
					<strong>Nội dung chuyển tiền:</strong>  <span class="order-id">Mã Đơn Hàng</span>_Tên Tài Khoản
					
				</p>
				
			</div>
		</div>

		<!-- Nút Tiếp tục mua hàng -->
		<div class="text-center mt-4">
			<a href="homepage" class="btn-custom">Tiếp tục mua hàng</a>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
