

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Panel</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        
        .navbar {
            background-color: rgba(0, 0, 0, 1);
            padding: 10px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1;
            position: relative;
            height: 70px;
            margin-bottom: 60px;
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

        /* Background Image */
        body {
            background-image: url('sbgggg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: repeat;
            height: 100vh;
            margin: 0;
            padding: 0;
        }

        /* Transparent Card Styles */
        .card {
           
            width: 30rem;
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.7);
        }

        .card img.profile-img {
            border-radius: 10px 10px 0 0;
        }

        .card-body {
            padding: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="navbar-brand">Skills</div>
        <ul class="navbar-menu">
            <li class="navbar-item"><a href="index.jsp">Home</a></li>          
            <li class="navbar-item">
            <a href="EditStudent.jsp?sid=<%= request.getAttribute("sid") %>&id=<%= request.getAttribute("id") %>">Edit Profile</a>
               </li>
            <li class="navbar-item"><a href="LogoutServlet">Logout</a></li>
        </ul>
    </nav>

    <div class="container d-flex justify-content-center align-items-center mt-5" style="margin-bottom: 10px; padding-bottom: 50px;" >
        <div class="card">
            <img src="upload/<%= request.getAttribute("profilepic") != null ? request.getAttribute("profilepic") : "default.png" %>" alt="Profile Picture" class="profile-img">
            <div class="card-body">
                <h5 class="card-title"><%= request.getAttribute("name") %></h5>
                <p class="card-text">
                    <strong>Email:</strong> <%= request.getAttribute("email") %><br>
                    <strong>Gender:</strong> <%= request.getAttribute("gender") %><br>
                    <strong>Qualification:</strong> <%= request.getAttribute("qual") %><br>
                     
                    <strong>Courses Registered: </strong>
                    <ul>
                        <%
                            List<String> courses = (List<String>) request.getAttribute("studentCourses");
                            if (courses != null) {
                                for (String course : courses) {
                                    out.println("<li>" + course + "</li>");
                                }
                            } else {
                                out.println("<li>No courses registered</li>");
                            }
                        %>
                    </ul>
                </p>
            </div>
        </div>
    </div>
</body>
</html>
