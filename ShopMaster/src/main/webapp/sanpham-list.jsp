<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Sản Phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	rel="stylesheet">


</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>
	<div class="content">
		<div class="container mt-5">
			<h1 class="text-center">Danh Sách Sản Phẩm</h1>
			<div
				class="mb-3 d-flex flex-column flex-md-row justify-content-between align-items-center">
				<!-- Nút thêm loại danh mục -->
				<a href="sanpham?action=new"
					class="btn btn-outline-dark mb-3 mb-md-0">Thêm Sản Phẩm Mới</a>

				<!-- Form tìm kiếm -->
				<div class="card p-2 shadow-sm w-50 w-md-30">
					<form action="sanpham?action=search" method="post"
						class="input-group">
						<input type="hidden" name="action" value="search"> <input
							type="text" name="keyword" class="form-control"
							placeholder="Bạn cần tìm gì..." required>
						<button type="submit" class="btn btn-primary">
							<i class="fab fa-searchengin"></i>
						</button>
					</form>
				</div>
			</div>
			<!-- BẢNG DANH SÁCH------- -->
			<table class="table table-bordered table-striped mt-4">
				<thead class="table table-dark">
					<tr>
						<th>STT</th>
						<th>Tên Sản Phẩm</th>
						<th>Hình Ảnh</th>
						<th>Giá Niêm Yết</th>
						<th>Số Lượng</th>
						<th>Thời Gian Giao Hàng</th>
						<th>Thể Loại</th>
						<th style="width: 25%;">Quản Lý</th>

					</tr>
				</thead>
				<tbody>
					<%
					// Lấy danh sách từ attribute
					List<Sanpham> listSP = (List<Sanpham>) request.getAttribute("listSP");

					// Kiểm tra nếu danh sách tài khoản không null
					if (listSP != null && !listSP.isEmpty()) {
						int stt = 1;
						for (Sanpham sp : listSP) {
					%>
					<tr>
						<td><%=stt++%></td>
						<td><%=sp.getProName()%></td>
						<!-- --HIỂN THỊ ẢNH  -->
<td>
                    <% 
                        byte[] imgData = sp.getImgfile();
                        if (imgData != null) {
                            String base64Image = java.util.Base64.getEncoder().encodeToString(imgData);
                    %>
                            <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image" style="width: 100px; height: 100px;">
                    <% 
                        } else {
                    %>
                            <span>Không có ảnh</span>
                    <% 
                        } 
                    %>
                </td>
						<td>
							<%
							// Định dạng giá trị
							int price = sp.getPrice();
							DecimalFormat decimalFormat = new DecimalFormat("#,###");
							String formattedPrice = decimalFormat.format(price);
							%> <%=formattedPrice%> VND
						</td>
						<td><%=sp.getStock()%></td>
						<!-- ------CỘT THỜI GIAN GIAO HÀNG -->
						<td>
							<%
							String thoigianGH = sp.getThoigianGH(); // Lấy giá trị thời gian giao hàng
							String hienThi = ""; // Biến để hiển thị giá trị chuyển đổi

							switch (thoigianGH) {
							case "fast":
								hienThi = "1-3 ngày";
								break;
							case "steady":
								hienThi = "2-5 ngày";
								break;
							case "slow":
								hienThi = "3-7 ngày";
								break;
							case "quick":
								hienThi = "Ngày mai"; // Ví dụ thêm cho "quick"
								break;
							default:
								hienThi = "Không xác định"; // Xử lý trường hợp không khớp
								break;
							}
							%> <%=hienThi%>
						</td>

						<!-- --CỘT THỂ LOẠI  -->
						<td>
							<%
							String theloai = sp.getTheloai(); // Lấy giá trị thời gian giao hàng
							String tloai = ""; // Biến để hiển thị giá trị chuyển đổi

							switch (theloai) {
							case "dientu":
								tloai = "Điện tử";
								break;
							case "giadung":
								tloai = "Gia dụng";
								break;
							case "phukien":
								tloai = "Phụ kiện";
								break;
							default:
								tloai = "Không xác định"; // Xử lý trường hợp không khớp
								break;
							}
							%> <%=tloai%>
						</td>
						<!-- --------------------------- -->

						<td>
							<div class="d-flex align-items-center">
								<a href="sanpham?action=edit&idproduct=<%=sp.getIdproduct()%>"
									class="btn btn-outline-info btn-sm me-2">Cập nhật</a> <span
									class="mx-1">|</span> <a
									href="sanpham?action=delete&idproduct=<%=sp.getIdproduct()%>"
									class="btn btn-outline-danger btn-sm"
									onclick="return confirm('Bạn có muốn xóa dữ liệu này không ?')">Xóa</a>
							</div>
						</td>

					</tr>
					<%
					} // Kết thúc vòng lặp
					} else {
					%>
					<tr>
						<td colspan="7" class="text-center">Không có sản phẩm nào
							trong danh sách</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<!-- Phân trang -->
			<div class="d-flex justify-content-center mt-3">
				<%
				// Lấy currentPage và totalPages từ request
				Integer currentPage = (Integer) request.getAttribute("currentPage");
				Integer totalPages = (Integer) request.getAttribute("totalPages");

				// Gán giá trị mặc định nếu null
				if (currentPage == null) {
					currentPage = 1;
				}
				if (totalPages == null) {
					totalPages = 1;
				}

				// Tạo liên kết "Trang Trước" nếu không phải là trang đầu tiên
				if (currentPage > 1) {
				%>
				<a href="sanpham?action=list&page=<%=currentPage - 1%>"
					class="btn btn-outline-success mx-1">Trang Trước</a>
				<%
				}

				// Hiển thị số trang hiện tại
				%>
				<span class="btn btn-outline-secondary disabled mx-1">Trang <%=currentPage%>
					/ <%=totalPages%></span>
				<%
				// Tạo liên kết "Trang Sau" nếu không phải là trang cuối cùng
				if (currentPage < totalPages) {
				%>
				<a href="sanpham?action=list&page=<%=currentPage + 1%>"
					class="btn btn-outline-success mx-1">Trang Kế Tiếp</a>
				<%
				}
				%>
			</div>
			<!-- ---------- -->
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>