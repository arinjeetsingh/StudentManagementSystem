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

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


@MultipartConfig
public class AddCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse res) throws IOException, ServletException {
        String cname = request.getParameter("courseName");
        String des = request.getParameter("courseDescription");
        
        
        // Retrieve the uploaded file part
        Part filePart = request.getPart("coursepic");
        
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

            // Insert user details along with the file name into the 'student' table
            PreparedStatement pst = con.prepareStatement("INSERT INTO courses(course, description, course_pic) values(?,?,?)");
            pst.setString(1, cname);
            pst.setString(2, des);
            pst.setString(3, fileName);
            
            int result = pst.executeUpdate();
            PrintWriter pw = res.getWriter();
            
            
            
            if ((result > 0)) {
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
