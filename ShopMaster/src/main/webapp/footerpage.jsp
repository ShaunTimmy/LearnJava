<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer with Social Icons</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        /* Ensure the body takes full height */
        html, body {
            height: 100%;
            margin: 0;
        }

        /* Footer styling */
        footer {
            background-color: #222;
            color: #fff;
            padding: 20px 0;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        .footer-icons a {
            color: #fff;
            font-size: 1.5rem;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .footer-icons a:hover {
            color: #70a1ff;
        }

        .footer-links a {
            color: #fff;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #70a1ff;
        }
    </style>
</head>
<body>
    
    <footer class="text-center">
        <div class="container">
            <p>&copy; 2024 Cửa Hàng Đồ Điện Tử, Gia Dụng và Phụ Kiện. Tất cả các quyền được bảo lưu.</p>
            <div class="footer-icons my-3">
                <a href="https://facebook.com" target="_blank"><i class="bi bi-facebook"></i></a>
                <a href="https://instagram.com" target="_blank"><i class="bi bi-instagram"></i></a>
                <a href="https://twitter.com" target="_blank"><i class="bi bi-twitter"></i></a>
                <a href="https://youtube.com" target="_blank"><i class="bi bi-youtube"></i></a>
                <a href="https://linkedin.com" target="_blank"><i class="bi bi-linkedin"></i></a>
            </div>
            <div class="footer-links">
                <a href="#">Chính Sách Bảo Mật</a> | 
                <a href="#">Điều Khoản Sử Dụng</a>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
