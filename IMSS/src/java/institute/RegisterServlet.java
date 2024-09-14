package institute;

import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


@MultipartConfig
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse res) throws IOException, ServletException {
        
        String enteredOtp = request.getParameter("otp");
        
         HttpSession session = request.getSession();
        String generatedOtp = session.getAttribute("otp").toString();

        if (!enteredOtp.equals(generatedOtp)) {
            request.setAttribute("error", "Invalid OTP. Please try again.");
            request.getRequestDispatcher("Register.jsp").forward(request, res);
            return;
        }

        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        String repwd = request.getParameter("repwd");
        String gender = request.getParameter("gender");
        String qualification = request.getParameter("qual");
        String[] selectedCourses = request.getParameterValues("options[]");
        
        Part filePart = request.getPart("profilePic");
        String uploadDir = "upload";
        String absolutePath = getServletContext().getRealPath("/") + File.separator + uploadDir;
        File uploadDirFile = new File(absolutePath);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }
        
        String fileName = filePart.getSubmittedFileName();
        String filePath = absolutePath + File.separator + fileName;

        try (InputStream fileContent = filePart.getInputStream();
             FileOutputStream fos = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }

        PrintWriter pw = res.getWriter();
        Connection con = null;
        PreparedStatement pst = null;
        PreparedStatement pst2 = null;
        ResultSet rs = null;
        try {
            con = DataBaseUtil.getConnection();

            // Insert student details and retrieve the generated student ID
            pst = con.prepareStatement("INSERT INTO student(name, email, password, gender, highestqualification, profile_pic) values(?,?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, pwd);
            pst.setString(4, gender);
            pst.setString(5, qualification);
            pst.setString(6, fileName);
            
            int result = pst.executeUpdate();
            
            // Get the generated student ID (sid)
            rs = pst.getGeneratedKeys();
            int newsid = -1;
            if (rs.next()) {
                newsid = rs.getInt(1);
            }

            // Insert into 'users' table
            pst2 = con.prepareStatement("INSERT INTO users(name, email, password, profile_pic) values(?,?,?,?)");
            pst2.setString(1, name);
            pst2.setString(2, email);
            pst2.setString(3, pwd);
            pst2.setString(4, fileName);
            
            int result2 = pst2.executeUpdate();

            // If both inserts are successful
            if (result > 0 && result2 > 0) {
                // Insert selected courses into 'student_courses' table
                String sql = "INSERT INTO student_courses (sid, cid) VALUES (?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    for (String courseId : selectedCourses) {
                        ps.setInt(1, newsid);
                        ps.setInt(2, Integer.parseInt(courseId));
                        ps.executeUpdate();
                    }
                }

                pw.println("Record Inserted Successfully");
                RequestDispatcher rd = request.getRequestDispatcher("/Login.jsp");
                rd.forward(request, res);
            } else {
                pw.println("Record cannot be Inserted");
            }
        } catch (SQLException e) {
            pw.println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pst != null) pst.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pst2 != null) pst2.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
