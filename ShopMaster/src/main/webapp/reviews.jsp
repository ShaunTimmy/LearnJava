<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="quantri.com.entity.*"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đánh giá sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #f8f9fa, #e9ecef);
            font-family: Arial, sans-serif;
        }

        .review-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .review-container:hover {
            transform: translateY(-5px);
        }

        h1 {
            font-family: 'Dancing Script', cursive;
            font-size: 40px;
            color: #007bff;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }

        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #ced4da;
            transition: border-color 0.2s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.3);
        }

        .btn-submit {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
            font-weight: 500;
            padding: 12px;
            border: none;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #218838 0%, #1e7e34 100%);
            color: #ffffff;
        }

        .btn-back {
            background-color: #6c757d;
            color: #fff;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .btn-back:hover {
            background-color: #5a6268;
            color: #ffffff;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #842029;
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="menu.jsp"></jsp:include>

<div class="container">
    <div class="review-container" data-aos="fade-up">
        <h1>Đánh Giá Sản Phẩm</h1>

        <%
            Taikhoan taikhoan = (Taikhoan) session.getAttribute("taikhoan");
            Integer idproduct = (Integer) session.getAttribute("idproduct");

            if (taikhoan == null) {
        %>
            <div class="alert alert-danger">
                Bạn cần <a href="dangnhap.jsp" class="alert-link">đăng nhập</a> để đánh giá sản phẩm.
            </div>
        <%
            } else if (idproduct == null) {
        %>
            <div class="alert alert-danger">
                Sản phẩm không hợp lệ. Vui lòng chọn sản phẩm trước khi đánh giá.
            </div>
        <%
            } else {
        %>
        <!-- Form đánh giá -->
        <form action="review?action=danhgia" method="POST">
            <input type="hidden" name="idtaikhoan" value="<%= taikhoan.getIdtaikhoan() %>">
            <input type="hidden" name="idproduct" value="<%= idproduct %>">

            <!-- Đánh giá sao -->
            <div class="mb-3">
                <label for="ratting" class="form-label">Bạn hài lòng với sản phẩm không?</label>
                <select id="ratting" name="ratting" class="form-select" required>
                    <option value="" disabled selected>--- Chọn đánh giá ---</option>
                    <option value="1">Rất không hài lòng</option>
                    <option value="2">Không hài lòng</option>
                    <option value="3">Bình thường</option>
                    <option value="4">Hài lòng</option>
                    <option value="5">Rất hài lòng</option>
                </select>
            </div>

            <!-- Nhận xét -->
            <div class="mb-3">
                <label for="comments" class="form-label">Nhận xét:</label>
                <textarea id="comments" name="comments" class="form-control" rows="4" required placeholder="Viết nhận xét của bạn ở đây..."></textarea>
            </div>

            <!-- Nút gửi -->
            <div class="text-center">
                <button type="submit" class="btn-submit w-100">Gửi đánh giá</button>
            </div>
        </form>
        <%
            }
        %>

        <!-- Nút quay lại -->
        <div class="d-flex justify-content-center mt-3">
            <a href="javascript:history.back()" class="btn-back">Quay Về</a>
        </div>
    </div>
</div>

<jsp:include page="footerpage.jsp"></jsp:include>

<!-- Hiệu ứng AOS -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init();
</script>

</body>
</html>
