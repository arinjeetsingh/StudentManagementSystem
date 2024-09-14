<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page import="institute.*" %>

<%
    // Retrieve the user ID from the request
    String userId = request.getParameter("id");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String message = "";

    if (userId != null && !userId.isEmpty()) {
        try {
            conn = DataBaseUtil.getConnection();
            
            // Step 1: Fetch the user's role
            String role = "";
            String uname="";
            String pwd="";
            int sid;
            String sql = "SELECT * FROM users WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(userId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                role = rs.getString("role");
                uname= rs.getString("email");
                pwd= rs.getString("password");
            }
            sid = DataBaseUtil.getSID(uname, pwd);
            
            // Close the ResultSet and PreparedStatement
            rs.close();
            pstmt.close();

            // Step 2: Delete from student table if the role is 'student'
            if ("student".equalsIgnoreCase(role)) {
            
                sql = "DELETE FROM student_courses WHERE sid = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, sid);
                pstmt.executeUpdate();
                pstmt.close();
            
            
            
                sql = "DELETE FROM student WHERE sid = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, sid);
                pstmt.executeUpdate();
                pstmt.close();
            }

            // Step 3: Delete from users table
            sql = "DELETE FROM users WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(userId));
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                message = "User deleted successfully.";
            } else {
                message = "User not found or could not be deleted.";
            }

        } catch (SQLException e) {
            e.printStackTrace();
            message = "An error occurred while trying to delete the user.";
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    } else {
        message = "Invalid user ID.";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete User</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="alert <%= (message.contains("successfully")) ? "alert-success" : "alert-danger" %>">
            <%= message %>
        </div>
        <form action="<%= request.getContextPath() %>/DeleteUserServlet" method="post">
    <button type="submit" class="btn btn-primary">Back to Admin Panel</button>
</form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
