package quantri.com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataConnection {
	 private static final String jdbcURL = "jdbc:mysql://localhost:3306/webshopdb";
	    private static final String jdbcUsername = "root";
	    private static final String jdbcPassword = "";
	    private static final String jdbcDriver = "com.mysql.cj.jdbc.Driver";

	    
	    public static Connection getConnection() throws SQLException {
	        try {
	            // Nạp driver MySQL
	           Class.forName(jdbcDriver);
	            // Tạo kết nối tới cơ sở dữ liệu
	            Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
	            
	            // In thông tin kết nối để kiểm tra
	            System.out.println("Kết nối cơ sở dữ liệu thành công!");
	            return connection;
	        } catch (ClassNotFoundException e) {
	            // Xử lý trường hợp không tìm thấy driver MySQL
	            throw new SQLException("Không tìm thấy driver MySQL: " + e.getMessage(), e);
	        } catch (SQLException e) {
	            // Xử lý lỗi khi không thể kết nối đến cơ sở dữ liệu
	            throw new SQLException("Lỗi kết nối cơ sở dữ liệu: " + e.getMessage(), e);
	        }
	    }

}
