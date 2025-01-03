<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Trị Viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            background-color: #f8f9fa;
            padding-top: 20px;
            top: 0;
            left: 0;
        }
        .sidebar a {
            color: #333;
            text-decoration: none;
            margin-bottom: 10px;
        }
        .sidebar a:hover {
            background-color: #e9ecef;
            color: #007bff;
        }
        .sidebar .nav-item {
            padding: 10px 20px;
        }
        /* Điều chỉnh cho phần nội dung chính */
        .main-content {
            margin-left: 250px; /* Dành không gian cho sidebar */
            padding: 20px;
            font-size: 14px;
        }

        .main-content h2 {
            font-size: 18px;
        }

        .main-content p {
            font-size: 14px;
            line-height: 1.5;
        }

        /* Responsive: Khi màn hình nhỏ hơn 768px, sidebar sẽ ẩn đi và main content chiếm toàn bộ chiều rộng */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
            }
            .main-content {
                margin-left: 0;
            }
        }
          .content {
        margin-left: 250px; /* Đảm bảo nội dung không bị che khuất bởi sidebar */
        padding: 20px;
    }

    .card {
       margin-left:-250px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .card-body {
        background-color: #f8f9fa;
        padding: 40px;
        text-align: center;
    }

    h2 {
        font-weight: bold;
        color: #007bff;
    }

    p {
        font-size: 1.1rem;
        color: #555;
    }

    .card-body strong {
        color: #007bff;
    }

    .mt-3 {
        margin-top: 1rem;
    }

    .mb-4 {
        margin-bottom: 1.5rem;
    }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp"></jsp:include>
    <!-- Main Content -->
  <div class="content">
    <div class="main-content">
        <div class="card">
            <div class="card-body">
                <h2 class="text-center mb-4">Chào Mừng Đến Với Trang Quản Trị Viên</h2>
                <p class="mt-3 text-center">
                    Xin chào, <strong><%= session.getAttribute("username") %></strong>! <br>
                    Đây là khu vực quản lý hệ thống, nơi bạn có thể thực hiện các thao tác quan trọng như quản lý người dùng, sản phẩm, đơn hàng,... và theo dõi các hoạt động của hệ thống. <br>
                    Với giao diện thân thiện và dễ sử dụng, chúng tôi hy vọng sẽ giúp bạn tiết kiệm thời gian và nâng cao hiệu quả quản lý.
                </p>
                <p class="mt-3 text-center">
                    Bạn có thể bắt đầu bằng cách chọn một trong các chức năng ở thanh điều hướng bên trái hoặc sử dụng các nút nhanh để thực hiện các thao tác thường xuyên.
                </p>
            </div>
        </div>
    </div>
</div>
    </div>

<jsp:include page="footer.jsp"></jsp:include>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-cVKIPhG81r3pKUpQ1h8RRAfGvW8zWFP2iHG8N3PePIpFEM6rlM/c0VB5GPqK6gD7"
            crossorigin="anonymous"></script>
</body>
</html>
