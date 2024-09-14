package institute;

import java.io.IOException;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import institute.*;

public class SendOtpServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        // Generate a random 6-digit OTP
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);

        // Save the OTP in the session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
         System.out.println("SendOtpservlet " + otp);
        // Send the OTP to the user's email (pseudo-code)
        EmailVerifyServlet.sendOtpEmail(email, otp);

        response.getWriter().write("OTP sent");
    }
}
