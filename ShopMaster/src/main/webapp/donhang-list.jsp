<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.*"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Đơn Hàng</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	<style type="text/css">
<style type="text/css">
.card-body {
    flex: 1 1 auto;
    padding: 1rem 1rem;
    width: 101%;
    height: 278px;
}
</style>
</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>
	<div class="content border border-secondary rounded shadow p-4 mt-4">
		<div class="container mt-5">
			<h1 class="text-center">Danh Sách Đơn Hàng</h1>

			<!-- Card containers for each order -->
			<div class="row mt-4">
				<%
				// Hiển thị danh sách đơn hàng
				List<Orders> listDH = (List<Orders>) request.getAttribute("listDH");
				DecimalFormat df = new DecimalFormat("#,###");
				if (listDH != null && !listDH.isEmpty()) {
					int stt = 1;
					for (Orders dh : listDH) {
						Sanpham sp = dh.getSanpham();
				%>
				<div class="col-md-4 mb-4">
					<div class="card shadow-sm">
						<div class="card-body">
							<!-- Order Info -->
							<h5 class="card-title">
								Đơn Hàng 0<%=stt++%></h5>
							<p class="card-text">
								<i class="fas fa-barcode"></i> <strong>Mã Đơn Hàng:</strong>
								<%=dh.getCodeorder()%><br> <i class="fas fa-calendar-day"></i>
								<strong>Thời Gian Đặt Hàng:</strong>
								<%=dh.getOrderdate()%><br>
							</p>

							<!-- Order Status -->
							<form method="post" action="donhang?action=update">
								<input type="hidden" name="idorder"
									value="<%=dh.getIdorder()%>" />
								<div class="d-flex justify-content-between align-items-center">
									<select name="statu" class="form-select form-select-sm"
										style="width: 150px;">
										<option value="Pending"
											<%="Pending".equals(dh.getStatu()) ? "selected" : ""%>>Chờ
											xử lý</option>
										<option value="Processing"
											<%="Processing".equals(dh.getStatu()) ? "selected" : ""%>>Đang
											xử lý</option>
										<option value="Completed"
											<%="Completed".equals(dh.getStatu()) ? "selected" : ""%>>Hoàn
											thành</option>
										<option value="Cancelled"
											<%="Cancelled".equals(dh.getStatu()) ? "selected" : ""%>>Đã
											hủy</option>
									</select>
									<button type="submit"
										class="btn btn-outline-primary btn-sm mt-2">
										<i class="fas fa-save"></i> Lưu
									</button>
								</div>
							</form>

							<!-- View Details Button -->
							<div class="mt-3 d-flex justify-content-between">
								<a href="donhang?action=details&idorder=<%=dh.getIdorder()%>"
									class="btn btn-outline-success btn-sm"> <i
									class="fas fa-info-circle"></i> Chi Tiết
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
				<a href="donhang?action=list&page=<%=currentPage - 1%>"
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
				<a href="donhang?action=list&page=<%=currentPage + 1%>"
					class="btn btn-outline-success mx-1"> Trang Kế Tiếp <i
					class="fas fa-arrow-right ms-1"></i>
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<br>
	<jsp:include page="footer.jsp"></jsp:include>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"
		integrity="sha384-eMNipT+Gkv8bI6Zn3VJOaiLwxm2KX2pnqV9KA6w5K2BYnkjf59k6IxJHyfxq6ZqT"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhG81u2ZhI8r9H8a6p7K6gI5QIqH5b62e9K5p6z7lHe+S68sgb0u46jBOWSR"
		crossorigin="anonymous"></script>
</body>
</html>
