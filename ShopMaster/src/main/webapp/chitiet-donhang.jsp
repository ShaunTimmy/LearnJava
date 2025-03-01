<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.*"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết đơn hàng</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.content {
	background: #f8f9fa;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

.product-img {
	height: 200px;
	width: 100%;
	object-fit: cover;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.card {
	border: none;
	background: #ffffff;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.card-header {
	background-color: #6c757d;
	color: black;
	font-weight: bold;
	text-align: center;
	border-top-left-radius: 8px;
	border-top-right-radius: 8px;
}

.btn-outline-secondary {
	border-radius: 30px;
	padding: 10px 20px;
}
.container.mt-5 {
    margin-left: 184px;
}
</style>
</head>
<body>
	<jsp:include page="sidebar.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="content">
			<h2 class="text-center mb-4">Chi Tiết Đơn Hàng</h2>
			<%
			Orders chitiet = (Orders) request.getAttribute("chitiet");
			DecimalFormat decimalFormat = new DecimalFormat("#,###");
			if (chitiet != null) {
				Sanpham sp = chitiet.getSanpham();
				Taikhoan tk = chitiet.getTaikhoan();
			%>
			<div class="card">
				<div class="card-header">
					Mã đơn hàng:
					<%=chitiet.getCodeorder()%>
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col-md-4">
							<img
								src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sp.getImgfile())%>"
								class="product-img" alt="<%=sp.getProName()%>">
						</div>
						<div class="col-md-8">
							<p>
								<strong>Người đặt hàng:</strong>
								<%=tk.getUsername()%></p>
							<p>
								<strong>Địa chỉ giao hàng:</strong>
								<%=tk.getAddress()%></p>
							<p>
								<strong>Điện thoại liên hệ:</strong>
								<%=tk.getSdt()%></p>
							<p>
								<strong>Tên sản phẩm:</strong>
								<%=sp.getProName()%></p>
							<p>
								<strong>Số lượng:</strong>
								<%=chitiet.getQuantity()%></p>
							<p>
								<strong>Tổng tiền:</strong>
								<%=decimalFormat.format(chitiet.getTotalprice())%>
								VND
							</p>
							<%
							String statu = chitiet.getStatu();
							String badgeColor = ""; 

							if ("Cancelled".equals(statu)) {
								badgeColor = "bg-danger"; // Màu đỏ
							} else if ("Pending".equals(statu)) {
								badgeColor = "bg-warning"; // Màu vàng
							} else if ("Processing".equals(statu)) {
								badgeColor = "bg-primary"; // Màu xanh dương
							} else if ("Completed".equals(statu)) {
								badgeColor = "bg-success"; // Màu xanh lá
							}
							%>

							<p>
								<strong>Trạng thái đơn hàng:</strong> <span
									class="badge <%=badgeColor%>"><%=statu%></span>
							</p>
							<p>
								<strong>Ngày đặt hàng:</strong>
								<%=chitiet.getOrderdate()%></p>
						</div>
					</div>
				</div>
			</div>
			<div class="text-center mt-4">
    <button class="btn btn-outline-primary" onclick="printInvoice(event)">In Hóa Đơn</button>
    <a href="donhang?action=list" class="btn btn-outline-secondary">Quay Lại</a>
</div>

			<%
			} else {
			%>
			<div class="alert alert-warning text-center mt-4" role="alert">
				Không tìm thấy chi tiết đơn hàng.</div>
			<%
			}
			%>
		</div>
	</div>
	  <jsp:include page="footer.jsp"></jsp:include>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<button class="btn btn-outline-primary" onclick="printInvoice()">In Hóa Đơn</button>

<script>
function printInvoice(event) {
    var content = document.querySelector(".col-md-8").cloneNode(true); // Sao chép nội dung cần in

    // Xóa phần "Trạng thái đơn hàng"
    var paragraphs = content.getElementsByTagName("p");
    for (var i = 0; i < paragraphs.length; i++) {
        if (paragraphs[i].innerText.includes("Trạng thái đơn hàng:")) {
            paragraphs[i].remove();
            break;
        }
    }

    var printWindow = window.open('', '', 'width=800,height=600');
    printWindow.document.write(`
        <html>
        <head>
            <title>Hóa Đơn</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
            <style>
                body { font-family: Arial, sans-serif; padding: 20px; }
                .invoice-container { max-width: 600px; margin: auto; background: #fff; padding: 20px; border: 2px solid #007bff; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }
                .invoice-header { text-align: center; font-size: 24px; font-weight: bold; color: #007bff; margin-bottom: 20px; }
                .invoice-content p { font-size: 16px; margin: 8px 0; }
                .invoice-footer { text-align: center; font-size: 14px; margin-top: 20px; font-style: italic; color: #888; }
            </style>
        </head>
        <body>
            <div class="container">
                <h1 class="text-center" style="margin-left:70px">Thông Tin Đơn Hàng</h1>
                <div class="invoice-container p-4 border rounded">
    `);

    // ✅ Thêm nội dung HTML vào cửa sổ in
    printWindow.document.write(content.innerHTML);

    // ✅ Đóng HTML và gọi lệnh in
    printWindow.document.write(`
                </div>
                <div class="invoice-footer text-center mt-4">
                    Cảm ơn quý khách đã mua hàng!
                </div>
            </div>
        </body>
        </html>
    `);

    printWindow.document.close();
    printWindow.print();
}

</script> 
	
</body>
</html>
