<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản Lý Sản Phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet" crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css"
	rel="stylesheet">
<script>
	// Validation form trước khi submit
	function validateForm(event) {
		const proName = document.getElementById("proName").value.trim();
		const price = document.getElementById("price").value.trim();
		const stock = document.getElementById("stock").value.trim();
		const description = document.getElementById("description").value.trim();
		let valid = true;

		if (proName === "") {
			showError("proNameError", "Tên sản phẩm không được để trống.");
			valid = false;
		} else {
			clearError("proNameError");
		}

		if (price === "" || isNaN(price) || parseFloat(price) < 0) {
			showError("priceError", "Giá sản phẩm phải là số và lớn hơn 0.");
			valid = false;
		} else {
			clearError("priceError");
		}

		if (stock === "" || isNaN(stock) || parseInt(stock) <= 0) {
			showError("stockError", "Số lượng sản phẩm phải là số không âm.");
			valid = false;
		} else {
			clearError("stockError");
		}

		if (description === "") {
			showError("desError", "Mô tả không được để trống.");
			valid = false;
		} else {
			clearError("desError");
		}

		if (!valid) {
			event.preventDefault();
		}
	}

	function showError(elementId, message) {
		document.getElementById(elementId).textContent = message;
		document.getElementById(elementId).style.display = "block";
	}

	function clearError(elementId) {
		document.getElementById(elementId).textContent = "";
		document.getElementById(elementId).style.display = "none";
	}
</script>
<style>
.error-message {
	color: red;
	font-size: 0.9em;
	display: none;
}

.mb-3 img {
	width: 20%;
}

.content.border.border-secondary.rounded.shadow-lg.p-4.mt-4 {
	margin-left: 280px;
}

.container.mt-4 {
	width: 102%;
	margin-left: -84px;
	transform: translateY(-39px);
}
</style>
</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>
	<div class="content border border-secondary rounded shadow-lg p-4 mt-4"
		style="min-height: 500px; width: 78%;">
		<div class="container mt-4">
			<div class="content">
				<h2 class="text-center mb-4">
					<%
					String action = request.getParameter("action");
					if ("edit".equals(action)) {
						out.print("Cập Nhật Thông Tin Sản Phẩm");
					} else {
						out.print("Thêm Sản Phẩm Mới");
					}
					%>
				</h2>
				<form
					action="sanpham?action=<%=(action != null && action.equals("edit")) ? "update" : "insert"%>"
					method="POST" class="mx-auto" style="max-width: 700px;"
					enctype="multipart/form-data" onsubmit="validateForm(event)">

					<%
					if ("edit".equals(action)) {
					%>
					<input type="hidden" name="idproduct"
						value="<%=request.getParameter("idproduct")%>">
					<%
					}
					%>

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="proName" class="form-label">Tên Sản Phẩm</label> <input
								type="text" class="form-control" id="proName" name="proName"
								placeholder="Nhập tên sản phẩm"
								value="<%=(request.getAttribute("sanpham") != null) ? ((Sanpham) request.getAttribute("sanpham")).getProName() : ""%>">
							<div id="proNameError" class="error-message"></div>
						</div>
						<div class="col-md-6">
							<label for="price" class="form-label">Giá Sản Phẩm</label> <input
								type="number" class="form-control" id="price" name="price"
								placeholder="Nhập giá sản phẩm"
								value="<%=(request.getAttribute("sanpham") != null) ? ((Sanpham) request.getAttribute("sanpham")).getPrice() : ""%>">
							<div id="priceError" class="error-message"></div>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="stock" class="form-label">Số Lượng Sản Phẩm</label> <input
								type="number" class="form-control" id="stock" name="stock"
								placeholder="Nhập số lượng sản phẩm"
								value="<%=(request.getAttribute("sanpham") != null) ? ((Sanpham) request.getAttribute("sanpham")).getStock() : ""%>">
							<div id="stockError" class="error-message"></div>
						</div>
						<div class="col-md-6">
							<label for="thoigianGH" class="form-label">Thời Gian Giao
								Hàng</label> <select class="form-select" id="thoigianGH"
								name="thoigianGH">
								<option value="" selected disabled>Chọn thời gian giao
									hàng</option>
								<option value="fast"
									<%=(request.getAttribute("sanpham") != null
		&& ((Sanpham) request.getAttribute("sanpham")).getThoigianGH().equals("fast")) ? "selected" : ""%>>1-3
									ngày</option>
								<option value="steady"
									<%=(request.getAttribute("sanpham") != null
		&& ((Sanpham) request.getAttribute("sanpham")).getThoigianGH().equals("steady")) ? "selected" : ""%>>2-5
									ngày</option>
								<option value="slow"
									<%=(request.getAttribute("sanpham") != null
		&& ((Sanpham) request.getAttribute("sanpham")).getThoigianGH().equals("slow")) ? "selected" : ""%>>3-7
									ngày</option>
								<option value="quick"
									<%=(request.getAttribute("sanpham") != null
		&& ((Sanpham) request.getAttribute("sanpham")).getThoigianGH().equals("quick")) ? "selected" : ""%>>Ngày
									mai</option>
							</select>
						</div>
					</div>

					<div class="mb-3">
						<label for="description" class="form-label">Mô Tả Sản Phẩm</label>
						<textarea class="form-control" id="description" name="description"
							rows="4"><%=(request.getAttribute("sanpham") != null) ? ((Sanpham) request.getAttribute("sanpham")).getDescription() : ""%></textarea>
						<div id="desError" class="error-message"></div>
					</div>

					<div class="mb-3">
						<label for="File" class="form-label fw-bold">📷 Chọn Ảnh</label>
						<div class="image-upload-container text-center">
							<label for="File" class="upload-box"> <input type="file"
								class="form-control d-none" id="File" name="imgfile"
								accept="image/*" onchange="imgpreview(event)">
								<div id="uploadArea">
									<i class="bi bi-cloud-upload fs-1"></i>
									<p class="mt-2">Nhấp để tải ảnh lên</p>
								</div> <img id="previewImage" src="#" alt="Ảnh Xem Trước"
								class="img-fluid mt-3 rounded shadow"
								style="display: none; width: 100%; height: auto; border-radius: 10px;" />
							</label>
						</div>

						<%
						if ("edit".equals(action)) {
						%>
						<p class="text-danger mt-2">Ảnh hiện tại sẽ được giữ nếu không
							tải ảnh mới.</p>
						<%
						}
						%>
					</div>


					<div class="mb-3">
						<label for="theloai" class="form-label">Loại Sản Phẩm</label> <select
							class="form-select" id="theloai" name="theloai">
							<option value="" selected disabled>Chọn loại sản phẩm</option>
							<option value="dientu"
								<%=(request.getAttribute("sanpham") != null
		&& ((Sanpham) request.getAttribute("sanpham")).getTheloai().equals("dientu")) ? "selected" : ""%>>Điện
								tử</option>
							<option value="giadung"
								<%=(request.getAttribute("sanpham") != null
		&& ((Sanpham) request.getAttribute("sanpham")).getTheloai().equals("giadung")) ? "selected" : ""%>>Gia
								dụng</option>
							<option value="phukien"
								<%=(request.getAttribute("sanpham") != null
		&& ((Sanpham) request.getAttribute("sanpham")).getTheloai().equals("phukien")) ? "selected" : ""%>>Phụ
								kiện</option>
						</select>
					</div>

					<div class="d-flex justify-content-center">
						<button type="submit" class="btn btn-primary me-2"><%=("edit".equals(action)) ? "Cập Nhật" : "Thêm Sản Phẩm"%></button>
						<a href="sanpham?action=list" class="btn btn-secondary">Hủy</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
	<script>
		function imgpreview(event) {
			const input = event.target;
			const preview = document.getElementById("previewImage");

			if (input.files && input.files[0]) {
				const reader = new FileReader();
				reader.onload = function(e) {
					preview.src = e.target.result;
					preview.style.display = "block";
				};
				reader.readAsDataURL(input.files[0]);
			} else {
				preview.src = "#";
				preview.style.display = "none";
			}
		}
	</script>
</body>
</html>
