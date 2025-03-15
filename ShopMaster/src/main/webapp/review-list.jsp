<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.*"%>
<%@ page import="quantri.com.entity.Taikhoan"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Đánh Giá</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet" crossorigin="anonymous">
<!-- Thêm Font Awesome cho các biểu tượng -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<style type="text/css">
.card-body {
    flex: 1 1 auto;
    padding: 1rem 1rem;
    width: 101%;
    height: 278px;
}.row.gx-3.overflow-hidden {
    margin-left: 94px;
}
.content.border.border-secondary.rounded.shadow.p-4.mt-4 {
    width: 78%;
    margin-left: 276px;
}
.row.gx-3.overflow-hidden {
    margin-left: -39px;
}
</style>
</head>
<body>
<jsp:include page="sidebar.jsp"></jsp:include>
<div class="content border border-secondary rounded shadow p-4 mt-4">
		<div class="container mt-5">
			<h1 class="text-center"> Reiew Từ Khách Hàng</h1>

			<!-- Card containers for each order -->
			  <div class="row gx-3 overflow-hidden">
				<%
				// Hiển thị danh sách đơn hàng
				List<Reviews> listNX = (List<Reviews>) request.getAttribute("listNX");
				if (listNX != null && !listNX.isEmpty()) {
					int stt = 1;
					for (Reviews cmt : listNX) {
						Sanpham sp = cmt.getSanpham();
				%>
				<div class="col-md-4 mb-4">
					<div class="card shadow-sm">
						<div class="card-body">
							<!-- Order Info -->
							<h5 class="card-title">
								Review 0<%=stt++%></h5>
							<p class="card-text">
								<i class="fas fa-barcode"></i> <strong>Mã Sản Phẩm:</strong>
								<%=sp.getIdproduct() %><br>
								 <i class="fas fa-calendar-day"></i>
								<strong>Thời Gian :</strong>
								<%=cmt.getTgian() %><br>
								
								<i class="fa-solid fa-star"></i>
								<strong>Số sao :</strong>
								<%=cmt.getRatting() %><br>
							</p>

							<!-- View Details Button -->
							<div class="mt-3 d-flex justify-content-between">
								<a href="danhgia?action=details&idreview=<%=cmt.getIdreview() %>"
									class="btn btn-outline-success btn-sm"> <i
									class="fas fa-info-circle"></i> Chi Tiết
								</a>
								
								<a href="danhgia?action=delete&idreview=<%=cmt.getIdreview() %>" class="btn btn-outline-danger btn-sm"
                                   onclick="return confirm('Bạn có muốn xóa dữ liệu này không ?')">
                                    <i class="fas fa-trash me-1"></i>Xóa
                                </a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				} else {
				%>
				<div class="col-12">
					<div class="alert alert-warning text-center" role="alert">
						Không có đơn hàng nào</div>
				</div>
				<%
				}
				%>
			</div>

			<!-- Pagination -->
			<div class="d-flex justify-content-center mt-3">
				<%
				Integer currentPage = (Integer) request.getAttribute("currentPage");
				Integer totalPages = (Integer) request.getAttribute("totalPages");
				if (currentPage == null)
					currentPage = 1;
				if (totalPages == null)
					totalPages = 1;

				if (currentPage > 1) {
				%>
				<a href="danhgia?action=list&page=<%=currentPage - 1%>"
					class="btn btn-outline-success mx-1"> <i
					class="fas fa-arrow-left me-1"></i>Trang Trước
				</a>
				<%
				}
				%>
				<span class="btn btn-outline-secondary disabled mx-1"> Trang
					<%=currentPage%> / <%=totalPages%>
				</span>
				<%
				if (currentPage < totalPages) {
				%>
				<a href="danhgia?action=list&page=<%=currentPage + 1%>"
					class="btn btn-outline-success mx-1"> Trang Kế Tiếp <i
					class="fas fa-arrow-right ms-1"></i>
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>
  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>