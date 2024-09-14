<%@ page import="java.sql.*" %>
 
<%@ page session="true" %>
<%@ page import="institute.*" %>

<%
  /*  
    session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null || !session.getAttribute("role").equals("admin")) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
*/
    // Database connection parameters
   
    
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    

    try {
        
        conn = DataBaseUtil.getConnection();
        stmt = conn.createStatement();
        String sql = "SELECT * FROM users";
         rs = stmt.executeQuery(sql);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .navbar {
            margin-bottom: 20px;
        }
        .profile-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
        }
       body {
            background-image: url('adpbg.png');
            background-size: cover;
            background-position: center;
            background-repeat: repeat;
            height: 100vh;
            margin: 0;
            padding: 0;
            color: white;
        } 
       
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Admin Panel</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="AddAdmin.jsp"> Add New Admin</a>
                </li>
                 <li class="nav-item">
                    <a class="nav-link" href="Course.jsp">Courses</a>
                </li>
                    <li class="nav-item">
                    <a class="nav-link" href="AddCourse.jsp">Add/Edit Course</a>
                </li>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet">Logout</a>
                </li>
            </ul>
        </div>
    </nav>
    <div class="container">
        <h3 class="mb-4">Admin Panel</h3>
        <table class="table table-bordered table-hover table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Profile Picture</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id=talbum style="color: white">
                <%
                    while (rs.next()) {
                        String username = rs.getString("name");
                        String email = rs.getString("email");
                        String role = rs.getString("role");
                        String profilePic = rs.getString("profile_pic");
                %>
                <tr>
                    <td><%= username %></td>
                    <td><%= email %></td>
                    <td><%= role %></td>
                    <td><img src="upload/<%= profilePic != null ? profilePic : "default.png" %>" alt="Profile Picture" class="profile-img"></td>
                    
                   <!-- <img src="upload/<%= profilePic != null ? profilePic : "default.png" %>" alt="Profile Picture" class="profile-img">  --> 
                    <td>
                        <a href="editusernew.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="DeleteUser.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm">Delete</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>