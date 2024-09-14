package institute;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;


public class CoursesServlet {

    private String jdbcURL = "jdbc:mysql://localhost:3306/institutemanagementsystem";
    private String jdbcUsername = "root";
    private String jdbcPassword = "arinjeet12345@";

    private static final String SELECT_ALL_COURSES = "SELECT * FROM courses";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public List<Course> selectAllCourses() {
        List<Course> courses = new ArrayList<>();
        
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_COURSES);) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("cid");
                String name = rs.getString("course");
                String description = rs.getString("description");
                String imageUrl = rs.getString("course_pic");
                courses.add(new Course(id, name, description, imageUrl));
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Course> courses = selectAllCourses();  // Fetch courses from the database
        request.setAttribute("courses", courses);  // Set the course list as a request attribute
        RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");  // Forward to JSP
        dispatcher.forward(request, response);
    }
}
