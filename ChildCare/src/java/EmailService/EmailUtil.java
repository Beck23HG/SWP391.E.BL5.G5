/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package EmailService;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Admin
 */
public class EmailUtil {
    public static void sendEmail(String toEmail, String subject, String messageText) {
        // Cấu hình các thuộc tính cho email
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP server của Gmail
        props.put("mail.smtp.port", "587"); // Cổng SMTP
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // Sử dụng TLS để bảo mật

        // Xác thực thông tin Gmail của bạn
        final String fromEmail = "bachtkhg627@gmail.com"; // Email của bạn
        final String password = "ishggiqkscquelbv"; // Mật khẩu của bạn (có thể cần mật khẩu ứng dụng)

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Tạo đối tượng Message và cấu hình thông tin người gửi, người nhận
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail)); // Người gửi
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail)); // Người nhận
            message.setSubject(subject); // Tiêu đề email
            message.setText(messageText); // Nội dung email

            // Gửi email
            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}