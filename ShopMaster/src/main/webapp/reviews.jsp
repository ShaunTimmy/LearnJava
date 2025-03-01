<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đánh giá sản phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"
	rel="stylesheet">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&display=swap"
	rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa;
    }
    .review-container {
        max-width: 800px;
        margin: 30px auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .review-container h1 {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        text-align: center;
    }
    .form-label {
        font-weight: 600;
        color: #495057;
    }
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }
    .btn-primary:hover {
        background-color: #0056b3;
        border-color: #004085;
    }
    .alert-danger {
        background-color: #f8d7da;
        color: #842029;
    }
    .review-container h1 {
	font-family: 'Dancing Script', cursive;
	font-size: 38px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="menu.jsp"></jsp:include>
	
	<div class="container mt-4">
        <div class="review-container" data-aos="fade-up">
            <h1>Cảm nhận về sản phẩm 
           
            </h1>
            <!-- Form đánh giá -->
            <form action="review?action=danhgia" method="POST" class="mt-4">
                <!-- Kiểm tra session -->
                <%
                    Taikhoan taikhoan = (Taikhoan) session.getAttribute("taikhoan");
                    Integer idproduct = (Integer) session.getAttribute("idproduct");

                    if (taikhoan == null) {
                %>
                    <div class="alert alert-danger text-center">
                        Bạn cần <a href="dangnhap.jsp" class="alert-link">đăng nhập</a> để đánh giá sản phẩm.
                    </div>
                <%
                    } else if (idproduct == null) {
                %>
                    <div class="alert alert-danger text-center">
                        Sản phẩm không hợp lệ. Vui lòng chọn sản phẩm trước khi đánh giá.
                    </div>
                <%
                    } else {
                %>
                <!-- Truyền idtaikhoan và idproduct -->
                <input type="hidden" name="idtaikhoan" value="<%= taikhoan.getIdtaikhoan() %>">
                <input type="hidden" name="idproduct" value="<%= idproduct %>">

                <div class="mb-3">
                    <label for="ratting" class="form-label">Bạn hài lòng với sản phẩm không ?</label>
                    <select id="ratting" name="ratting" class="form-select" required>
                        <option value="" disabled selected>---Cảm nhận của bạn---</option>
                        <option value="1">Rất không hài lòng</option>
                        <option value="2">Không hài lòng</option>
                        <option value="3">Bình thường (Trung lập)</option>
                        <option value="4">Hài lòng</option>
                        <option value="5">Rất hài lòng</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="comments" class="form-label">Nhận xét:</label>
                    <textarea id="comments" name="comments" class="form-control" rows="4" placeholder="Viết nhận xét của bạn ở đây..." required></textarea>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-outline-success px-4">Gửi đánh giá</button>
                </div>
                <%
                    }
                %>
            </form>
            <div class="d-flex justify-content-start mt-3 gap-2">
					<a href="javascript:history.back()" class="btn btn-outline-secondary btn-sm">Quay Về</a>
			
				</div>
        </div>
    </div>
	<jsp:include page="footerpage.jsp"></jsp:include>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init();
    </script>
</body>
</html>
