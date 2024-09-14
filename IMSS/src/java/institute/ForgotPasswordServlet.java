package institute;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String sql = "SELECT password FROM users WHERE email=?";
        String upassword = "";
        boolean emailExists = false;

        try {
            Connection con = DataBaseUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                upassword = rs.getString("password");
                emailExists = true;
            }

            if (emailExists) {
                // Send email
                String subject = "Forgot Password for S.M.S Account";
                String msg = "Your Login Password for StudentManagementSystem is: " + upassword;
                String from = "arinjeet1111@gmail.com";
                String host = "smtp.gmail.com";

                Properties properties = System.getProperties();
                properties.setProperty("mail.smtp.host", host);
                properties.setProperty("mail.smtp.port", "587");
                properties.setProperty("mail.smtp.auth", "true");
                properties.setProperty("mail.smtp.starttls.enable", "true");

                String password = "fwjk fxjo weax vhep";

                Session session = Session.getInstance(properties, new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, password);
                    }
                });

                Message message = new MimeMessage(session);
                message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setFrom(new InternetAddress(from));
                message.setSubject(subject);
                message.setText(msg);

                Transport.send(message);

                // Redirect to login.jsp with success toast message
                req.getSession().setAttribute("message", "Your password has been sent to your registered email.");
                res.sendRedirect("Login.jsp");
            } else {
                // Redirect to Registration.jsp with error message
                req.getSession().setAttribute("error", "No such email exists. Please register.");
                res.sendRedirect("Register.jsp");
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
