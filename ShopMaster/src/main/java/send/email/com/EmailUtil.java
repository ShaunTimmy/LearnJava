package send.email.com;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
    public static void sendEmail(String toEmail, String subject, String messageBody) throws MessagingException {
        final String fromEmail = "dinhhaidang1511@gmail.com";
        final String password = "dpnl xjhq xuov mtis"; // Mật khẩu ứng dụng (App Password)

        // Cấu hình SMTP Server (Gmail)
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // Cấu hình để bỏ qua SSL error

        // Debug TLS để kiểm tra chi tiết lỗi
        System.setProperty("javax.net.debug", "all");
        

        // Tạo phiên làm việc với tài khoản email
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(messageBody);
         // **QUAN TRỌNG**: Đặt nội dung email là HTML
         // **Sửa lỗi: Đặt nội dung email là HTML đúng cách**
            message.setContent(messageBody, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            throw e;
        }
    }
}

