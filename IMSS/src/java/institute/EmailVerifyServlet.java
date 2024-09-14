package institute;


import jakarta.servlet.http.HttpServlet;
import java.util.*;
import javax.mail.Session;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class EmailVerifyServlet extends HttpServlet {
 
    public static void sendOtpEmail(String to, int otp) {
        
        
        String subject = "OTP Code for Student Registration";
        String msg = "Your OTP code for registration with StudentManagementSystem is: " + otp;
       
        try
         {  
         // Sender Email Credentials -
         String from = "arinjeet1111@gmail.com";
         String host= "smtp.gmail.com";
         
         // Setup mail server properties -
         Properties properties = System.getProperties();
         
         properties.setProperty("mail.smtp.host",host);
         properties.setProperty("mail.smtp.port","587");
         properties.setProperty("mail.smtp.auth", "true");
         properties.setProperty("mail.smtp.starttls.enable","true");
         
         String password="fwjk fxjo weax vhep";
         // Get the session object-
         Session session = Session.getInstance(properties,new Authenticator()
         {
             @Override
             protected PasswordAuthentication getPasswordAuthentication()
             {
                return new PasswordAuthentication(from,password);
             }
         
         });
         
        
            Message message =new MimeMessage(session);
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setFrom(new InternetAddress(from));
            message.setSubject(subject);
            message.setText(msg);

            Transport.send(message);
            
             
         }
         
         catch(Exception ec)
         {
             System.out.println(ec.getMessage());
         }
     }
}
