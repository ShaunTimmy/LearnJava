<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopCapy - Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
    body {
    background: linear-gradient(135deg, #bdc3c7, #ecf0f1);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Arial', sans-serif;
        color: #fff;
    }
    .login-container {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        padding: 40px;
        width: 100%;
        max-width: 400px;
    }
    .form-label {
        font-weight: 600;
        color: #495057;
    }
    .btn-primary {
        background-color: #6a11cb;
        border: none;
    }
    .btn-primary:hover {
        background-color: #6ab04c;
    }
    .icon {
        font-size: 60px;
        color: #6a11cb;
        margin-bottom: 15px;
    }
    h2 {
        font-weight: 700;
        color: #343a40;
        text-align: center;
        margin-bottom: 20px;
    }
    .custom-link {
        display: block;
        text-align: center;
        margin-top: 15px;
        color: #6a11cb;
        text-decoration: none;
    }
    .custom-link:hover {
        text-decoration: underline;
    }
    a.custom-link:hover {
    text-decoration: none;
    color: #eb2f06;
}
</style>
</head>
<body>
<div class="login-container">
    <div class="text-center">
        <i class="bi bi-person-circle icon"></i>
    </div>
    <h2>ĐĂNG NHẬP</h2>
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
    <form action="dangnhap" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">
                <i class="bi bi-person-fill"></i> Username
            </label>
            <input type="text" name="username" id="username" class="form-control" placeholder="Enter your username" 
                   value="<%= username != null ? username : "" %>" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">
                <i class="bi bi-lock-fill"></i> Password
            </label>
            <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" 
                   required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>
        <a href="homepage" class="custom-link">Quay về</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-cVKIPhG81YlGO9gFTiTz5tvx6BoR9H9ZFSm2xLI9u3uxk5j6MbiFEJo3Fm9xA5s7"
        crossorigin="anonymous"></script>
</body>
</html>
