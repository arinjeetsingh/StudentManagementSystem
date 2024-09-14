<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<!-- Bootstrap CSS -->
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
        background-image: url('loginbg.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .form-container {
        background-color: rgba(255, 255, 255, 0.3); /* White background with 80% opacity */
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        font-size: 0.875rem; /* Decrease font size to 14px (0.875rem) */
        max-width: 500px; /* Optional: Limit the width of the form */
        width: 100%; /* Ensures the form is responsive */
    }
   
    .form-container label,
    .form-container input,
    .form-container select {
        font-size: 16px; /* Decrease font size to 14px (0.875rem) */
    }
    
    .btn-custom-primary {
        background-color: #9368b0;
         /* Primary color */
        border-color: #43006f;
        color: #000000;
        font-weight: bold;
    }
    .btn-custom-primary:hover {
        background-color: #5e0084;
        border-color: #2e0649;
        color: white;
    }
    .btn-custom-secondary {
        background-color: #383131; 
        border-color: #6c757d;
        color:white;
        font-weight: bold;
    }
    .btn-custom-secondary:hover {
        background-color: #000000; 
        border-color: #000000;
        color: white;
    }
</style>
</head>
<body>
<nav class="navbar">
    <div class="navbar-brand">Skills</div>
    <ul class="navbar-menu">
        <li class="navbar-item"><a href="index.jsp">Home</a></li>
        <li class="navbar-item"><a href="#">Courses</a></li>
        <li class="navbar-item"><a href="Login.jsp">Login</a></li>
        <li class="navbar-item"><a href="Register.jsp">Register</a></li>
    </ul>
</nav>
<div class="background-image">
    <div class="form-container">
        <%
            String message = (String) session.getAttribute("message");
            if (message != null) {
        %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= message %>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
                session.removeAttribute("message");
            }
        %>

        <h1 class="mb-4 text-center"><img src="key.png" style="height: 50px;">&nbsp;Login</h1>
        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="uname">Username</label>
                <input type="email" class="form-control" name="email" placeholder="Enter your E-mail" required>
            </div>
            <div class="form-group">
                <label for="pwd">Password</label>
                <input type="password" class="form-control" name="pwd" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn btn-custom-primary btn-block">Submit</button>
            <a href="Register.jsp" class="btn btn-custom-secondary btn-block">Sign Up</a>
            <a href="ForgotPassword.jsp" class="btn btn-custom-secondary btn-block">Forgot Password</a>
        </form>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
