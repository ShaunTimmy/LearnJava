<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="quantri.com.entity.Sanpham"%>
<%@ page import="quantri.com.entity.CartItem"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>ShopCapy - Giỏ Hàng</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- Bootstrap Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
<style>
.cart-table img {
    border-radius: 8px;
    width: 80px; /* Giảm kích thước ảnh cho phù hợp */
}

.cart-table tr:hover {
    background-color: #f0f0f0; /* Thêm hiệu ứng hover cho dòng */
}

.cart-summary {
    font-size: 1.1rem;
}

.empty-cart {
    font-size: 1.5rem;
    color: #777;
}

section.hero-section {
    padding: 50px 0;
    background-color: #70a1ff;
    color: #fff;
}

section.hero-section h1 {
    font-size: 2.5rem;
    font-weight: bold;
}

.cart-table td, .cart-table th {
    vertical-align: middle;
    text-align: center;
}

.cart-actions a {
    margin: 0 5px;
}
</style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="menu.jsp"></jsp:include>

    <!-- Hero Section -->
    <section class="hero-section text-center">
        <div class="container">
            <h1>Giỏ Hàng Của Bạn</h1>
            <p>Tại đây, bạn có thể xem và quản lý các sản phẩm yêu thích đã thêm vào giỏ hàng. <br>Hãy kiểm tra kỹ trước khi tiến hành thanh toán!</p>
        </div>
    </section>

    <div class="container my-4">
        <table class="table table-hover cart-table">
            <thead class="table-dark">
                <tr>
                    <th>STT</th>
                    <th>Hình ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th>Giá Sản Phẩm</th>
                    <th>Số lượng</th>
                    <th>Thành Tiền</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<CartItem> listGH = (List<CartItem>) request.getAttribute("listGH");
                DecimalFormat df = new DecimalFormat("#,###");
                double totalAmount = 0; // Khởi tạo biến tổng tiền
                int stt = 1;
                %>
                <%
                if (listGH != null && !listGH.isEmpty()) {
                    for (CartItem item : listGH) {
                        Sanpham sp = item.getSanpham();
                        double itemTotal = sp.getPrice() * item.getSlg(); // Tính tổng giá mỗi sản phẩm
                        totalAmount += itemTotal; // Cộng vào tổng tiền
                %>
                <tr>
                    <td><%=stt++%></td>
                    <td><img src="data:image/jpeg;base64,<%=java.util.Base64.getEncoder().encodeToString(sp.getImgfile())%>" alt="<%=sp.getProName()%>" /></td>
                    <td><%=sp.getProName()%></td>
                    <td><%=df.format(sp.getPrice())%> VND</td>
                    <td>
                        <div class="cart-actions">
                            <a href="cart?action=decrease&iditem=<%=item.getIditem()%>" class="btn btn-sm btn-outline-dark"><i class="fas fa-minus"></i></a>
                            <%=item.getSlg()%>
                            <a href="cart?action=increase&iditem=<%=item.getIditem()%>" class="btn btn-sm btn-outline-info"><i class="fas fa-plus"></i></a>
                        </div>
                    </td>
                    <td><%=df.format(itemTotal)%> VND</td>
                    <td><a href="cart?iditem=<%=item.getIditem()%>&action=delete" class="btn btn-sm btn-outline-danger"
                    onclick="return confirm('Bạn có muốn xóa giỏ hàng này không ?')"><i class="fas fa-trash"></i></a></td>
                </tr>
                <%
                    }
                %>
                <tr>
                    <td colspan="4" class="text-end fw-bold">TỔNG TIỀN:</td>
                    <td colspan="2" class="text-start text-danger fw-bold"><%=df.format(totalAmount)%> VND</td>
                </tr>
                <%
                } else {
                %>
                <tr>
                    <td colspan="7" class="text-center empty-cart">Giỏ hàng của bạn đang trống.</td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>

        <div class="d-flex justify-content-between align-items-center mt-4">
            <a href="product" class="btn btn-outline-primary"><i class="fas fa-arrow-left"></i> Tiếp tục mua sắm</a>
            <%
            if (listGH != null && !listGH.isEmpty()) {
            %>
            <a href="cart?action=checkout" class="btn btn-outline-success"><i class="fas fa-check"></i> Thanh toán</a>
            <%
            }
            %>
        </div>
    </div>

    <jsp:include page="footerpage.jsp"></jsp:include>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js" integrity="sha384-eMNJoM94Us0i0n5LN1d2Pj9g1rK/HZ3f5PyLr92/9loZ9FqeKk6/7LvK1q/NBXkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhG81rQug4K9ORjNJz8f4pCWIwX1RsjtM6dPZJ29p6EGGoI1LVF2XKD1z04z" crossorigin="anonymous"></script>
</body>
</html>
