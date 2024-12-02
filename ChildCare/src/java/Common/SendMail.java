package Common;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {
    public static void sendMail(String email, String value, String msg) {
        
        final String fromEmail = "linhtinh1104@outlook.com";
        final String password = "Linhtinh.123456";
        // Config SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.office365.com"); // smtp.office365.com
        props.put("mail.smtp.port", "587");

        Authenticator auth = new Authenticator() {
			//override the getPasswordAuthentication method
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		};

        // Create session
        Session session = Session.getInstance(props,auth);

        // send email
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));
            message.setSubject("Verify");
            message.setText(msg + " : " + value);

            Transport.send(message);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
