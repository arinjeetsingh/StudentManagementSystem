package institute;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


@MultipartConfig
public class AddAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse res) throws IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        String repwd = request.getParameter("repwd");
        
        
        // Retrieve the uploaded file part
        Part filePart = request.getPart("profilePic");
        
        // Specify the directory to save the uploaded file (absolute path to 'upload' directory)
        String uploadDir = "upload";
        String absolutePath = getServletContext().getRealPath("/") + File.separator + uploadDir; // Full path to 'upload' directory
        File uploadDirFile = new File(absolutePath);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }
        
        // Get the file name and write the file to the specified directory
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

        try {
            Connection con = DataBaseUtil.getConnection();

            
            // Insert user details into the 'users' table
            PreparedStatement pst2 = con.prepareStatement("INSERT INTO users(name, email, password, role, profile_pic) values(?,?,?,?,?)");
            pst2.setString(1, name);
            pst2.setString(2, email);
            pst2.setString(3, pwd);
            pst2.setString(4, "admin");
            pst2.setString(5, fileName); // Store only the file name
            
            int result2 = pst2.executeUpdate();
            PrintWriter pw=res.getWriter();
            
            if ((result2 > 0) && (result2 > 0)) {
                pw.println("Record Inserted Successfully");
               request.getRequestDispatcher("/WEB-INF/jsp/AdminPanel.jsp").forward(request, res);
            } else {
                pw.println("Record cannot be Inserted");
            }
        } catch (SQLException e) {
            PrintWriter pw = res.getWriter();
            pw.println(e.getMessage());
        }
    }
}
