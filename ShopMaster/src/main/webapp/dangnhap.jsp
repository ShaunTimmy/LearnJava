<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            height: 100vh;
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Arial', sans-serif;
            background: url('img/login-bg.png') no-repeat center center;
	background-size: cover;
        }
        .login-container {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            backdrop-filter: blur(10px);
            text-align: center;
            color: white;
        }
        .input-group-text {
            background: rgba(255, 255, 255, 0.3);
            border: none;
            color: white;
            border-radius: 25px 0 0 25px;
        }
        .input-group .input-group-text {
    padding: 6px 10px; /* Giảm padding của icon */
    font-size: 14px; /* Giảm kích thước icon */
}
.input-group-text {
    padding: 4px 8px; /* Giảm padding của phần chứa icon */
    font-size: 12px; /* Giảm kích thước icon */
    height: 40px; /* Giảm chiều cao */
    display: flex;
    align-items: center;
}

.input-group-text i {
    font-size: 18px;
    transform: translate(2px, 7px);
}
a.custom-link:hover {
    color: #d35400;
    text-decoration: none;
}
.form-control {
    border-radius: 0 25px 25px 0;
    padding: 6px 10px; /* Giảm padding */
    height: 40px; /* Giảm chiều cao */
    font-size: 15px; /* Giảm kích thước chữ */
    border: none;
    background: rgba(255, 255, 255, 0.2);
    color: white;
}
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        .form-control:focus {
            background: rgba(255, 255, 255, 0.3);
            box-shadow: none;
        }
        .btn-primary {
            border-radius: 25px;
            background: white;
            color: #4e54c8;
            font-weight: bold;
            padding: 10px;
            border: none;
            transition: 0.3s;
        }
        .btn-primary:hover {
            background: #6a11cb;
            color: white;
            transform: scale(1.05);
        }
        .custom-link {
            color: white;
            text-decoration: none;
        }
        .custom-link:hover {
            text-decoration: underline;
        }
        i {
            color: white;
            font-size: 50px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<div class="login-container">

    <i class="bi bi-person-circle"></i>
    <h2>Login</h2>

    <% 
    String error = (String) request.getAttribute("error");
    String email = (String) request.getAttribute("email");
       if (error != null) { %>
        <div class="alert alert-danger">
            <%= error %>
        </div>
    <% } %>

    <form action="dangnhap" method="post">
    
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                <input type="email" name="email" id="email" class="form-control" placeholder="Enter your email"
                  value="<%= email!= null ? email : "" %>" >
            </div>
        </div>
        <div class="mb-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" >
            </div>
        </div>
        <button type="submit" class="btn btn-primary w-100 mt-3">Login</button>
    </form>
    <br><br>
    <p>
        Don't have an account ? <a href="dangky.jsp" class="custom-link">Register</a>
    </p>
     <a href="homepage" class="custom-link">Quay về</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
