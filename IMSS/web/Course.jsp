<%@ page import="java.util.List" %>
<%@ page import="institute.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Courses</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
       
    html, body {
    height: 100%;
    margin: 0;
}
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-image: url('pngtree-abstract-technology-background-line-high-tech-electricity-image_430309.jpg'); 
            background-size: cover; 
            background-position: center; 
            background-repeat: repeat; 
        }

        .navbar {
            background-color: rgba(0, 0, 0, 1);
            padding: 10px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1; /* Ensures the navbar stays on top of the background */
            position: relative;
            height: 70px;
           margin-bottom: 30px;
        }
        .navbar-brand {
            font-size: 24px;
             font-weight: bolder;
        }
        .navbar-menu {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .navbar-item {
            margin-left: 20px;
             margin-right: 10px;
        }
        .navbar-item a {
            color: white;
            text-decoration: none;
        }
        .navbar-item a:hover {
            text-decoration: underline;
        }
    
        
        .card {
            margin: 15px;
            height: 600px;
            background-color: black;
            color: white;
            border-radius: 20px;
            border-color: white;
            margin-bottom: 40px;
        }
        .card:hover
        {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="navbar-brand">Skills</div>
        <ul class="navbar-menu">
            <li class="navbar-item"><a href="index.jsp">Home</a></li>
            <li class="navbar-item"><a href="Login.jsp">Login</a></li>
            <li class="navbar-item"><a href="Register.jsp">Register</a></li>
        </ul>
    </nav>
    
    
<div class="container">
    <div class="row">
        <%
            CoursesServlet courseDAO = new CoursesServlet();
            List<Course> courses = courseDAO.selectAllCourses();

            for (Course course : courses) {
        %>
        <div class="col-md-4">
            <div class="card">
                <!-- <img class="card-img-top" src="<%= course.getImageUrl() %>" alt="Course image">  -->
                <img class="card-img-top" style="border-radius: 20px;" src="upload/<%= course.getImageUrl() != null ? course.getImageUrl() : "course.jpg" %>" alt="Profile Picture" class="profile-img">
                <div class="card-body">
                    <h5 class="card-title" style="color: red"><b><%= course.getName() %></b></h5>
                    <p class="card-text" ><%= course.getDescription() %></p>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
