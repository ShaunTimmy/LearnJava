<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopCapy - 404 Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
        }
        .error-container {
            text-align: center;
            padding: 100px;
        }
        .error-container h1 {
            font-size: 5rem;
            color: #e74c3c;
        }
        .error-container p {
            font-size: 1.25rem;
            color: #333;
        }
        .error-container .btn {
            font-size: 1rem;
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }
        .error-container .btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="menu.jsp"></jsp:include>

    <div class="error-container">
        <h1>404</h1>
        <p>Oops! The page you are looking for cannot be found.</p>
        <p>It might have been moved, deleted, or you might have entered the wrong URL.</p>
        <a href="homepage" class="btn">Go Back to Homepage</a>
    </div>

    <jsp:include page="footerpage.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
