<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404,Sorry</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
	
</head>
<body>
<jsp:include page="sidebar.jsp"></jsp:include>
<div class="content">
<div class="error-container">
    <h1>404</h1>
    <p>Xin lỗi, trang bạn tìm kiếm không tồn tại hoặc đã bị di chuyển.</p>
    <a href="admin" class="btn btn-primary">Quay về trang chủ</a>
</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>