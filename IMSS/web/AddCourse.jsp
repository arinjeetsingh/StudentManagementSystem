<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Course</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
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
        }
        .navbar-brand {
            font-size: 24px;
        }
        .navbar-menu {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .navbar-item {
            margin-left: 20px;
        }
        .navbar-item a {
            color: white;
            text-decoration: none;
        }
        .navbar-item a:hover {
            text-decoration: underline;
        }
        .background-image {
            background-image: url('addcoursebg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: calc(100vh - 60px); /* Adjust based on navbar height */
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            
        }
        .form-container {
           background-color: rgba(255, 255, 255, 0.5); /* White background with 80% opacity */
           margin-left:200px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            font-size: 0.875rem; /* Decrease font size to 14px (0.875rem) */
            margin-top: 50px;
           
        }
        .form-container label,
        .form-container input,
        .form-container select {
            font-size: 0.875rem; /* Decrease font size to 14px (0.875rem) */
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="navbar-brand">Skills</div>
        <ul class="navbar-menu">
            <li class="navbar-item"><a href="index.jsp">Home</a></li>
            <li class="navbar-item"><a href="">Courses</a></li>
            <li class="navbar-item"><a href="Login.jsp">Login</a></li>
            <li class="navbar-item"><a href="Register.jsp">Register</a></li>
        </ul>
    </nav>
    <div class="background-image">
        <div class="form-container">
            <h1 class="mb-4">Enter course details to add -</h1>
            <form action="AddCourseServlet" method="post" enctype="multipart/form-data">
                <div class="form-group">
                 <label for="courseName">Course Name</label>
                 <input type="text" class="form-control" id="courseName" name="courseName" placeholder="Enter course name here" required>
                </div>

                <div class="form-group">
                  <label for="courseDescription">Course Description</label>
                  <textarea class="form-control" id="courseDescription" name="courseDescription" placeholder="Enter course description here" rows="4" maxlength="1000" required></textarea>
                  <small class="form-text text-muted">Maximum 1000 characters.</small>
                </div>                 
                
                <div class="form-group">
                    <label for="profilePic">Upload Course picture</label>
                    <input type="file" class="form-control-file" id="coursepic" name="coursepic" accept="image/*">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
                <button type="button" class="btn btn btn-primary" onclick="location.href='SelectEditCourse.jsp'">Edit Course</button>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
