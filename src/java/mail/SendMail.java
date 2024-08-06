package mail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendMail {
    public static void sendMail(String email, String subject, String body) {

        String host = "smtp.gmail.com";
        final String user = "kms.se1808.g6@gmail.com";// sender
        final String password = "eedl vvfu btms voya";// app password
        // Get the session object
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", "587");
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });
        // Compose the message
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject(subject);
            message.setText(body);
            // send the message
            Transport.send(message);
            System.out.println("message sent successfully...");
        } catch (MessagingException e) {
            System.out.println("Error sending mail :" + e);
            e.printStackTrace();
        }
    }

}
