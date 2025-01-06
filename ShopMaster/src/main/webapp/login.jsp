<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
    body {
        background: linear-gradient(135deg, #051937, #1b3b59);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Arial', sans-serif;
    }
    .login-container {
        background: #082038;
        border-radius: 15px;
        box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.5);
        padding: 30px;
        width: 100%;
        max-width: 400px;
        color: white;
    }
    .form-label {
        font-weight: 600;
        color: #adb5bd;
    }
    .btn-primary {
        background-color: #ffffff;
        border: none;
        color: #082038;
        border-radius: 30px;
        font-weight: bold;
    }
    .btn-primary:hover {
        background-color: #30336b;
    }
    .form-control {
        background: #1b3b59;
        border: none;
        border-radius: 30px;
        color: white;
        padding-left: 40px;
    }
    .form-control:focus {
        box-shadow: 0px 0px 5px rgba(255, 255, 255, 0.5);
        outline: none;
    }
    .form-group {
        position: relative;
        margin-bottom: 20px;
    }
    .form-group i {
        position: absolute;
        top: 50%;
        left: 15px;
        transform: translateY(-50%);
        color: #adb5bd;
    }
    .icon {
        font-size: 48px;
        color: #6c63ff;
    }
    h2 {
        font-weight: 700;
        color: white;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
<div class="login-container">
    <div class="text-center">
        <i class="bi bi-person-circle icon"></i>
    </div>
    <h2 class="text-center">ĐĂNG NHẬP</h2>
    <% 
        String error = (String) request.getAttribute("error");
        String username = (String) request.getAttribute("username");
        if (error != null) {
    %>
        <div class="alert alert-danger">
            <%= error %>
        </div>
    <% 
        }
    %>
    <form action="login" method="post">
        <div class="form-group">
            <i class="bi bi-person-fill"></i>
            <input type="text" name="username" class="form-control" placeholder="Tên đăng nhập" 
                   value="<%= username != null ? username : "" %>" required>
        </div>
        <div class="form-group">
            <i class="bi bi-lock-fill"></i>
            <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Đăng Nhập</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-cVKIPhG81YlGO9gFTiTz5tvx6BoR9H9ZFSm2xLI9u3uxk5j6MbiFEJo3Fm9xA5s7"
        crossorigin="anonymous"></script>
</body>
</html>
