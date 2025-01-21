<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ShopCapy - Đăng Ký</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&display=swap"
	rel="stylesheet">
<script type="text/javascript">
	function validateForm(event) {
		const username = document.getElementById("username").value.trim();
		const password = document.getElementById("password").value.trim();
		const usernameError = document.getElementById("usernameError");
		const passwordError = document.getElementById("passwordError");
		const address = document.getElementById("address").value.trim();
		const addressError = document.getElementById("addressError");
		const sdt = document.getElementById("sdt").value.trim();
		const sdtError = document.getElementById("sdtError");
		const email = document.getElementById("email").value.trim();
		const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // Regex kiểm tra email hợp lệ
		let isValid = true;
		// Reset lỗi
		usernameError.textContent = "";
		passwordError.textContent = "";
		addressError.textContent = "";
		sdtError.textContent = "";
		emailRegex.textContent = "";
		if (username.length < 4) {
			isValid = false;
			usernameError.textContent = "Tên tài khoản phải có ít nhất 4 ký tự.";
		}
		if (password.length < 4) {
			isValid = false;
			passwordError.textContent = "Mật khẩu phải có ít nhất 4 ký tự.";
		}
		if (address == "") {
			isValid = false;
			addressError.textContent = "Vui lòng không bỏ trống"
		}
		if (sdt.length < 10) {
			isValid = false;
			sdtError.textContent = "Số điện thoại phải có ít nhất 10 ký tự.";
		}
		if (!emailRegex.test(email)) {
			isValid = false;
			document.getElementById("emailRegex").textContent = "Vui lòng nhập địa chỉ email hợp lệ!"; // Hiển thị lỗi
		} else {
			document.getElementById("emailRegex").textContent = ""; // Xóa lỗi nếu email hợp lệ
		}
		if (!isValid) {

			event.preventDefault(); // Ngăn chặn việc gửi form nếu không hợp lệ
		}
	}
</script>
<style>
body {
	background-color: #f8f9fa;
}

.form-container {
	max-width: 800px;
	margin: 50px auto;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 10px;
	background-color: #ffffff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-container h2 {
	font-family: 'Dancing Script', cursive;
}

.form-container .form-label {
	font-weight: bold;
}

.form-container .form-control {
	border-radius: 5px;
	transition: box-shadow 0.3s ease;
}

.form-container .form-control:focus {
	box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
	border-color: #007bff;
}

.form-container .btn-primary {
	width: 100%;
}

.form-container .input-group-text {
	background-color: #f8f9fa;
	border-radius: 5px;
}

.form-container .input-group .form-control {
	border-left: none;
}

.form-container .input-group .form-control:focus {
	border-left: 1px solid #007bff;
}

.form-container .input-group-text i {
	color: #007bff;
}

.login-link {
	margin-top: 10px;
	text-align: center;
}

.back-button {
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>

	<div class="container">
		<div class="form-container">
			<h2 class="text-center mb-4">Đăng Ký Tài Khoản</h2>
			<div style="text-align: center; margin-top:5px;">
			</div>
			<%
			String successMessage = (String) request.getAttribute("successMessage");
			if (successMessage != null) {
			%>
			<div class="alert alert-success text-center" role="alert">
				<%=successMessage%>
			</div>
			<%
			}
			%>
			<br>
			<form action="dangky" method="post" onsubmit="validateForm(event)">
				<div class="row mb-3">
					<label for="username" class="col-sm-3 col-form-label"><i
						class="bi bi-person-circle"></i> Tên tài khoản <span
						style="color: red;">*</span></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="username"
							name="username" placeholder="Nhập tên tài khoản"> <span
							id="usernameError" class="text-danger"></span>
					</div>
				</div>
				<div class="row mb-3">
					<label for="password" class="col-sm-3 col-form-label"><i
						class="bi bi-lock"></i> Mật khẩu <span style="color: red;">*</span></label>
					<div class="col-sm-9">
						<input type="password" class="form-control" id="password"
							name="password" placeholder="Nhập mật khẩu"> 
							<span
							id="passwordError" class="text-danger"></span>
					</div>
				</div>
				<div class="row mb-3">
					<label for="address" class="col-sm-3 col-form-label"><i
						class="bi bi-house-door"></i> Địa chỉ <span style="color: red;">*</span></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="address"
							name="address" placeholder="Nhập địa chỉ"> <span
							id="addressError" class="text-danger"></span>
					</div>
				</div>
				<div class="row mb-3">
					<label for="email" class="col-sm-3 col-form-label"><i
						class="bi bi-envelope"></i> Email <span style="color: red;">*</span></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="email" name="email"
							placeholder="Nhập email"> <span id="emailRegex"
							class="text-danger"></span>
					</div>
				</div>
				<div class="row mb-3">
					<label for="sdt" class="col-sm-3 col-form-label"><i
						class="bi bi-phone"></i> Số điện thoại <span style="color: red;">*</span></label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="sdt" name="sdt"
							placeholder="Nhập số điện thoại"> <span id="sdtError"
							class="text-danger"></span>
					</div>
				</div>
				<div class="row mb-3" hidden>
					<label for="role" class="col-sm-3 col-form-label"><i
						class="bi bi-person-badge"></i> Vai trò <span style="color: red;">*</span></label>
					<div class="col-sm-9">
						<select class="form-select" id="role" name="role">
							<option value="user" selected>Khách hàng</option>
						</select>
					</div>
				</div>
				<div class="text-center">
					<button type="submit" class="btn btn-primary">Đăng Ký</button>
				</div>
			</form>
			<div class="login-link">
				<p>
					Bạn đã có tài khoản? <a href="dangnhap.jsp" class="text-primary">Đăng
						nhập tại đây</a>
				</p>
			</div>
			<div class="back-button">
				<a href="dangky" class="btn btn-secondary">Hủy</a>
			</div>
		</div>
	</div>
	<br>
	<jsp:include page="footerpage.jsp"></jsp:include>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMF1cbCXFVWRApJoEihMdGv5v6bE5z0vCcHI6NqD8iJeHxHSj8vSKZl4Sk7"
		crossorigin="anonymous"></script>
</body>
</html>
