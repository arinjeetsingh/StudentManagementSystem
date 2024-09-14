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
public class EditCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cid = Integer.parseInt(request.getParameter("id"));
        String cname = request.getParameter("cname");
        String des = request.getParameter("des");
     
        Part filePart = request.getPart("profilePic");
        String fileName = filePart.getSubmittedFileName();

        String filePath = null;
        if (fileName != null && !fileName.isEmpty()) {
           
            String uploadDir = "upload";
            String absolutePath = getServletContext().getRealPath("/") + File.separator + uploadDir;
            File uploadDirFile = new File(absolutePath);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            
            filePath = absolutePath + File.separator + fileName;

            
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

        try {
            conn = DataBaseUtil.getConnection();

            
            String sql = "UPDATE courses SET course=?, description=?";
            if (filePath != null) {
                sql += ", course_pic=?";
            }
            sql += " WHERE cid=?";

            pst = conn.prepareStatement(sql);
            pst.setString(1, cname);
            pst.setString(2, des);
        
            if (filePath != null) {
                pst.setString(3, fileName);
                pst.setInt(4, cid);
            } else {
               pst.setInt(3, cid);
            }      

            int result = pst.executeUpdate();

            if ((result > 0)) {
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
