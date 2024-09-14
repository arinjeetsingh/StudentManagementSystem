package institute;

import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


@MultipartConfig
public class EditUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
     //   String role = request.getParameter("role");
        String qual = request.getParameter("qual");
        String gender= request.getParameter("gender");
        int sid=Integer.parseInt(request.getParameter("sid"));

        // Get the uploaded file part
        Part filePart = request.getPart("profilePic");
        String fileName = filePart.getSubmittedFileName();

        String filePath = null;
        if (fileName != null && !fileName.isEmpty()) {
            // Specify the directory to save the uploaded file (absolute path to 'upload' directory)
            String uploadDir = "upload";
            String absolutePath = getServletContext().getRealPath("/") + File.separator + uploadDir;
            File uploadDirFile = new File(absolutePath);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            // Create the full path for the file
            filePath = absolutePath + File.separator + fileName;

            // Write the uploaded file to the specified directory
            try (InputStream fileContent = filePart.getInputStream();
                 FileOutputStream fos = new FileOutputStream(filePath)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }
        }

        Connection conn = null;
        PreparedStatement pst = null;
        PreparedStatement pst2= null;
        PreparedStatement pst3=null;

        try {
            conn = DataBaseUtil.getConnection();

            // Update user details, including the profile picture if provided
            String sql = "UPDATE users SET name=?, email=?";
            if (filePath != null) {
                sql += ", profile_pic=?";
            }
            sql += " WHERE id=?";

            pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, email);
        //    pst.setString(3, role);
            if (filePath != null) {
                pst.setString(3, fileName); // Store only the file name
                pst.setInt(4, id);
            } else {
               pst.setInt(3, id);
            }
            
            
            
            
            
            
            
            
          String sql2 = "UPDATE student SET name=?, email=?, gender=?, highestqualification=?";
            if (filePath != null) {
                sql2 += ", profile_pic=?";
            }
            sql2 += " WHERE sid=?";

            pst2 = conn.prepareStatement(sql2);
            pst2.setString(1, name);
            pst2.setString(2, email);
            pst2.setString(3, gender);
            pst2.setString(4, qual);
        
            if (filePath != null) {
                pst2.setString(5, fileName); 
                pst2.setInt(6, sid);
            } else {
               pst2.setInt(5, sid);
            }
            
            
            
            
            
            
            
            
            
            
            int result2= pst2.executeUpdate();

            int result = pst.executeUpdate();
       //     int result2=pst2.executeUpdate();
            if ((result > 0)&&(result2>0)) {
            	request.getRequestDispatcher("/WEB-INF/jsp/AdminPanel.jsp").forward(request, response);
            } else {
                response.getWriter().println("User update failed.");
            }
        } catch (SQLException e) {
            response.getWriter().println(e.getMessage());
        } finally {
            if (pst != null) try { pst.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
