<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>

<!-- Bootstrap 5 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	crossorigin="anonymous">
<link
	href="https://fonts.googleapis.com/css?family=Dancing+Script|Roboto"
	rel="stylesheet">
<style>
*, *:after, *:before {
	box-sizing: border-box;
}

body {
	background: url('img/lgin.jpg') repeat center center/cover;
	height: 100vh;
	text-align: center;
	font-family: 'Roboto', sans-serif;
}

.body {
	background: #fff;
	position: absolute;
	top: 200px;
	left: -20px;
	border-radius: 100px 100px 100px 100px/126px 126px 96px 96px;
	width: 250px;
	height: 282px;
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.3);
}

form {
	min-height: 320px;
	/* Đặt chiều cao tối thiểu để tránh form bị dịch chuyển */
	max-width: 400px;
	padding: 20px 40px;
	background: #fff;
	height: 300px;
	margin: auto;
	display: block;
	box-shadow: 0 10px 15px rgba(0, 0, 0, 0.15);
	-webkit-transition: 0.3s;
	transition: 0.3s;
	position: relative;
	-webkit-transform: translateY(-100px);
	transform: translateY(-100px);
	z-index: 500;
	box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.2);
	border: 1px solid #eee;
}

form.up {
	-webkit-transform: translateY(-180px);
	transform: translateY(-180px);
}

h1 {
	color: #1b3b59;
	font-family: 'Dancing Script', cursive;
}

.btn {
	background: #fff;
	padding: 5px;
	width: 150px;
	height: 35px;
	border: 1px solid #0e0d0d;
	margin-top: 25px;
	cursor: pointer;
	-webkit-transition: 0.3s;
	transition: 0.3s;
	box-shadow: 0 50px #1b1a1b inset;
	color: #fff;
}

.btn:hover {
	box-shadow: 0 0 #3676ec inset;
	color: #3b5ae4;
}

.btn:focus {
	outline: none;
}

.form-group {
	position: relative;
	font-size: 15px;
	color: #666;
}

.form-group+.form-group {
	margin-top: 30px;
}

.form-group .form-label {
	position: absolute;
	z-index: 1;
	left: 0;
	top: 5px;
	-webkit-transition: 0.3s;
	transition: 0.3s;
}

.form-group .form-control {
	width: 100%;
	position: relative;
	height: 35px;
	background: none;
	border: none;
	padding: 5px 0;
	-webkit-transition: 0.3s;
	transition: 0.3s;
	border-bottom: 1px solid #777;
	color: #555;
}

.form-group .form-control:invalid {
	outline: none;
}

.form-group .form-control:focus, .form-group .form-control:valid {
	outline: none;
	box-shadow: 0 1px #051937;
	border-color: #051937;
}

.form-group .form-control:focus+.form-label, .form-group .form-control:valid+.form-label
	{
	font-size: 12px;
	color: #051937;
	-webkit-transform: translateY(-15px);
	transform: translateY(-15px);
}

.form-control {
	appearance: none;
	-webkit-appearance: none;
	-moz-appearance: none;
}

.form-control:focus {
	box-shadow: none !important;
}

.
.alert.alert-danger.text-center {
	display: block !important;
	position: absolute;
	font-size: 16px;
	right: -180px;
	top: -300px;
	z-index: 200;
	padding: 30px 25px;
	background: #fff;
	border-radius: 50%;
	opacity: 0;
	-webkit-transform: scale(0, 0);
	transform: scale(0, 0);
	-moz-transition: linear 0.4s 0.6s;
	-o-transition: linear 0.4s 0.6s;
	-webkit-transition: linear 0.4s;
	-webkit-transition-delay: 0.6s;
	-webkit-transition: linear 0.4s 0.6s;
	transition: linear 0.4s 0.6s;
}

.
.alert.alert-danger.text-center:after, ...alert.alert-danger.text-centert:before
	{
	content: '';
	position: absolute;
	width: 20px;
	height: 25px;
	background: #fff;
	left: -19px;
	bottom: -8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	border-radius: 50%;
}

.
.alert.alert-danger.text-center:before {
	width: 15px;
	height: 15px;
	left: -35px;
	bottom: -25px;
}

h2 {
	color: #1b3b59;
	font-family: 'Dancing Script', cursive;
}

.login-container {
	transform: translateY(230px);
}
</style>
</head>
<body>



	<div class="login-container">

		<form action="login" method="post">
			<div class="error-message" id="error-message">
				<%
				String error = (String) request.getAttribute("error");
				String username = (String) request.getAttribute("username");
				if (error != null) {
				%>
				<p class="alert alert-danger text-center">
					<%=error%>
				</p>
				<%
				}
				%>
			</div>

			<h2 class="text-center">ĐĂNG NHẬP</h2>

			<div class="form-group">
				<i class="bi bi-person-fill"></i> <input type="text" name="username"
					class="form-control"
					value="<%=username != null ? username : ""%>" required> <label
					class="form-label">Username</label>
			</div>
			<div class="form-group">
				<i class="bi bi-lock-fill"></i> <input type="password"
					name="password" class="form-control" required> <label
					class="form-label">Password</label>
			</div>

			<button type="submit" class="btn btn--outline-primary w-60">Đăng
				Nhập</button>

		</form>

	</div>
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</body>
</html>

