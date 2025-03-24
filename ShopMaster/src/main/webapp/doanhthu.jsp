<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Set" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống Kê Doanh Thu</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style type="text/css">
    .content.border.border-secondary.rounded.shadow.p-4.mt-4 {
    width: 78%;
    margin-left: 279px;
}
    </style>
</head>
<body>
<jsp:include page="sidebar.jsp"></jsp:include>
<div class="content border border-secondary rounded shadow p-4 mt-4">
    <h3 class="text-center">Biểu Đồ Thống Kê Doanh Thu Theo Tháng</h3>
    <canvas id="lineChart"></canvas>
</div>

<% 
    Map<String, Integer> doanhThuData = (Map<String, Integer>) request.getAttribute("doanhThuData");
    String labels = "";
    String values = "";
    
    if (doanhThuData != null) {
        for (Map.Entry<String, Integer> entry : doanhThuData.entrySet()) {
            labels += "'" + entry.getKey() + "',";
            values += entry.getValue() + ",";
        }
        // Xóa dấu phẩy cuối cùng
        if (!labels.isEmpty()) {
            labels = labels.substring(0, labels.length() - 1);
            values = values.substring(0, values.length() - 1);
        }
    }
%>
  <jsp:include page="footer.jsp"></jsp:include>
<script>
    const labels = [<%= labels %>];  // Nhận dữ liệu từ JSP
    const values = [<%= values %>];

    const ctx = document.getElementById('lineChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Doanh thu (VND)',
                data: values,
                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1,
                barThickness: 30, // Độ dày cố định của cột
                maxBarThickness: 40 // Độ dày tối đa
            }]
        },
        options: {
            responsive: true,
            scales: {
            	  x: {
                      ticks: {
                          autoSkip: false,
                          maxRotation: 45,
                          minRotation: 0
                      }
                  },
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
</body>
</html>
