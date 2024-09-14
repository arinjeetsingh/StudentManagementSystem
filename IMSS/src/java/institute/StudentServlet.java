package institute;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session != null && "student".equals(session.getAttribute("role"))) {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            PreparedStatement ps2= null;
            ResultSet rs2 = null;

            try {
                int sid = (int) session.getAttribute("sid");
                conn = DataBaseUtil.getConnection();
                

                // Fetching student details
                String sql = "SELECT * FROM student WHERE sid = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, sid);

                rs = ps.executeQuery();
                
               
                String email="";
                

                if (rs.next()) {
                    String name = rs.getString("name");
                    email = rs.getString("email");
                    String gender = rs.getString("gender");
                    String qual = rs.getString("highestqualification");
                    String profilepic = rs.getString("profile_pic");

                    req.setAttribute("sid", sid);
                    req.setAttribute("name", name);
                    req.setAttribute("email", email);
                    req.setAttribute("gender", gender);
                    req.setAttribute("qual", qual);
                    req.setAttribute("profilepic", profilepic);
                }
                String sql3= "SELECT id FROM users WHERE email=?";
                ps2= conn.prepareStatement(sql3);
                ps2.setString(1, email);
                rs2 = ps2.executeQuery();
                if(rs2.next())
                {
                 int id = rs2.getInt("id");
                
                 req.setAttribute("id", id);
                }
                

                // Fetching student's courses
                List<String> studentCourses = selectCoursesByStudentId(sid, conn);
                req.setAttribute("studentCourses", studentCourses);
                
                // Forwarding to the student panel JSP
                req.getRequestDispatcher("/WEB-INF/jsp/StudentPanel.jsp").forward(req, res);

            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Close resources
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        } else {
            req.getRequestDispatcher("/index.jsp").forward(req, res);
        }
    }

    public List<String> selectCoursesByStudentId(int studentId, Connection conn) {
        List<String> courses = new ArrayList<>();
        PreparedStatement ps2 = null;
        ResultSet rs2 = null;

        try {
            String sql2 = "SELECT courses.course " +
                          "FROM student " +
                          "INNER JOIN student_courses ON student_courses.sid = student.sid " +
                          "INNER JOIN courses ON courses.cid = student_courses.cid " +
                          "WHERE student.sid = ?";
            ps2 = conn.prepareStatement(sql2);
            ps2.setInt(1, studentId);
             
            rs2 = ps2.executeQuery();

            while (rs2.next()) {
                String courseName = rs2.getString("course");
                courses.add(courseName);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (rs2 != null) try { rs2.close(); } catch (SQLException ignore) {}
            if (ps2 != null) try { ps2.close(); } catch (SQLException ignore) {}
        }
        return courses;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        Connection conn = null;

        try {
            conn = DataBaseUtil.getConnection();
            List<String> studentCourses = selectCoursesByStudentId(studentId, conn);
            request.setAttribute("studentCourses", studentCourses);
            // Forwarding to the JSP page can be handled here if needed
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
