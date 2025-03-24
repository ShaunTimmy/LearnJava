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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
.content {
    margin-left: 250px; /* Điều chỉnh khoảng cách phù hợp với sidebar */
    padding: 20px;
    min-height: 100vh;
    background-color: #f8f9fa;
}
.card-order {
    transition: all 0.3s ease-in-out;
}
.card-order:hover {
    transform: scale(1.05);
}
.content {
    margin-left: 250px; /* Khoảng cách sidebar */
    padding: 20px;
    min-height: 100vh;
    background-color: #f8f9fa;
    overflow: hidden; /* Ngăn tràn nội dung */
}
.row.gx-3.overflow-hidden {
    margin-left: 94px;
}
.content.border.border-secondary.rounded.shadow-lg.p-4.mt-4 {
    margin-left: 274px;
}
.row.gx-3.overflow-hidden {
    width: 105%;
    margin-left: -11px;
}

</style>
</head>
<body>
    <jsp:include page="sidebar.jsp"></jsp:include>
    <div class="content border border-secondary rounded shadow-lg p-4 mt-4" style="min-height: 500px; width: 78%;">
        <div class="container-fluid" style="max-width: 1200px;">

            <h1 class="text-center">Danh Sách Đơn Hàng</h1>
            <div class="d-flex justify-content-center align-items-center mb-4">
                <div class="card p-2 shadow-sm w-50 w-md-30">
                    <form action="donhang?action=search" method="post" class="input-group">
                        <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm đơn hàng..." required
                        value="${keyword}">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            </div>
            <div class="row gx-3 overflow-hidden">

                <% List<Orders> listDH = (List<Orders>) request.getAttribute("listDH");
                DecimalFormat df = new DecimalFormat("#,###");
                if (listDH != null && !listDH.isEmpty()) {
                    for (Orders dh : listDH) { %>
                    <div class="col-md-4 mb-4">
                        <div class="card shadow-sm card-order">
                            <div class="card-body">
                                <h5 class="card-title">Mã ĐH: <%= dh.getCodeorder() %></h5>
                                <p class="card-text"><strong>Ngày đặt:</strong> <%= dh.getOrderdate() %></p>
                                <p class="card-text"><strong>Trạng thái:</strong> <%= dh.getStatu() %></p>
                                <form method="post" action="donhang?action=update">
                                    <input type="hidden" name="idorder" value="<%= dh.getIdorder() %>">
                                   <select name="statu" class="form-select form-select-sm"
										style="width: 150px; color: <%="Pending".equals(dh.getStatu()) ? "#ffc107"
		: "Processing".equals(dh.getStatu()) ? "#007bff"
				: "Completed".equals(dh.getStatu()) ? "#28a745"
						: "Cancelled".equals(dh.getStatu()) ? "#dc3545" : "black"%>;">
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
                                    <button type="submit" class="btn btn-outline-primary btn-sm mt-2">
                                    <i class="fa-solid fa-floppy-disk"></i> Lưu</button>
                                </form>
                                <div class="mt-3 d-flex justify-content-between">
                                    <a href="donhang?action=details&idorder=<%= dh.getIdorder() %>" class="btn btn-outline-success btn-sm"> <i
									class="fas fa-info-circle"></i> Chi Tiết</a>
                                    <a href="donhang?action=delete&idorder=<%= dh.getIdorder() %>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có muốn xóa đơn hàng này không?')">
                                      <i class="fas fa-trash me-1"></i>Xóa</a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } } else { %>
                <div class="col-12">
                    <div class="alert alert-warning text-center">Không có đơn hàng nào</div>
                </div>
                <% } %>
            </div>
            <div class="d-flex justify-content-center mt-3">
                <% Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                if (currentPage == null) currentPage = 1;
                if (totalPages == null) totalPages = 1;
                if (currentPage > 1) { %>
                <a href="donhang?action=list&page=<%= currentPage - 1 %>" class="btn btn-outline-success mx-1">Trang Trước</a>
                <% } %>
                <span class="btn btn-outline-secondary disabled mx-1">Trang <%= currentPage %> / <%= totalPages %></span>
                <% if (currentPage < totalPages) { %>
                <a href="donhang?action=list&page=<%= currentPage + 1 %>" class="btn btn-outline-success mx-1">Trang Kế Tiếp</a>
                <% } %>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
