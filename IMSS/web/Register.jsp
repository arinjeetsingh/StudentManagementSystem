<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="institute.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
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
            z-index: 1;
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
            background-image: url('polygons-geometric-blur-background-connected-dots-3840x2160-1740.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            box-sizing: border-box;
            padding: 40px;
        }
        .form-container {
            background-color: rgba(255, 255, 255, 0.6);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 50%;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        #otpbtn {
            background-color: #007bff; /* Blue */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        #otpbtn:hover {
            background-color: #0056b3;
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
        <% String errorMessage = (String) request.getAttribute("error"); %>
        <% if (errorMessage != null) { %>
            <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 11;">
                <div id="errorToast" class="toast align-items-center text-white bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            <%= errorMessage %>
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            </div>
        <% } %>
        

        <div class="form-container">
            
            <%
    String error = (String) session.getAttribute("error");
    if (error != null) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    <%= error %>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<%
        session.removeAttribute("error");
    }
%>
            
            
            
            <h1 style="font-family: sans-serif"><b>Enter your details to register</b></h1>
            <form onsubmit="return validateForm()" action="RegisterServlet" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="name">Enter your name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name here">
                </div>
                <div class="form-group">
                    <label for="email">Enter your Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your E-mail here">
                    <button type="button" class="btn btn-secondary mt-2" id="otpbtn" onclick="sendOtp()">Send OTP</button>
                </div>
                <div class="form-group">
                    <label for="otp">Enter OTP</label>
                    <input type="text" class="form-control" id="otp" name="otp" placeholder="Enter the OTP you received">
                </div>
                <div class="form-group">
                    <label for="pwd">Password</label>
                    <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Create your password here">
                </div>
                <div class="form-group">
                    <label for="repwd">Please re-enter your password</label>
                    <input type="password" class="form-control" id="repwd" name="repwd" placeholder="Re-enter your password here">
                </div>
                <div id="password-match-message" style="color: red;"></div>
                <div class="form-group">
                    <label for="gender">Select your Gender</label><br>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="male" name="gender" value="male">
                        <label class="form-check-label" for="male">Male</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="female" name="gender" value="female">
                        <label class="form-check-label" for="female">Female</label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="qual">Select your Highest Qualification</label>
                    <select class="form-control" id="qual" name="qual">
                        <option value="10th">10th</option>
                        <option value="12th">12th</option>
                        <option value="Bachelors">Bachelors</option>
                        <option value="Masters">Masters</option>
                        <option value="Phd">Phd</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Choose course:</label><br>
                    <%
                        CoursesServlet courseDAO = new CoursesServlet();
                        List<Course> courses = courseDAO.selectAllCourses();
                        for (Course course : courses) {
                    %>
                        <input type="checkbox" id="options[]" name="options[]" value="<%= course.getId() %>">
                        <label for=""><%= course.getId() %>.</label>
                        <label for=""><%= course.getName() %></label><br>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="profilePic">Upload your Profile Picture</label>
                    <input type="file" class="form-control-file" id="profilePic" name="profilePic" accept="image/*">
                </div>
                <button type="submit" class="btn btn-primary btn-block">Register</button>
            </form>
            <div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="passwordModalLabel">Password Mismatch</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Passwords and re-type password do not match.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        var otpSent = false; // Flag to check if OTP is sent

        function sendOtp() {
            var email = document.getElementById("email").value;
            if (email === "") {
                alert("Please enter your email first.");
                return;
            }
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "SendOtpServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    otpSent = true; // Set flag to true when OTP is sent
                    alert("OTP sent to your email. Please check your inbox.");
                }
            };
            xhr.send("email=" + encodeURIComponent(email));
        }

        function validateForm() {
            var name = document.getElementById("name").value;
            var email = document.getElementById("email").value;
            var otp = document.getElementById("otp").value;
            var password = document.getElementById("pwd").value;
            var confirmPassword = document.getElementById("repwd").value;
            var gender = document.querySelector('input[name="gender"]:checked');
            var qualification = document.getElementById("qual").value;
            var courses = document.querySelectorAll('input[name="options[]"]:checked');

            // Check if any required field is empty
            if (name === "" || email === "" || otp === "" || password === "" || confirmPassword === "" || !gender || qualification === "" || courses.length === 0) {
                alert("Please fill in all required fields.");
                return false;  // Prevent form submission
            }

            // Check if OTP was sent
            if (!otpSent) {
                alert("Please generate the OTP and fill it before submitting the form.");
                return false;  // Prevent form submission
            }

            // Check if passwords match
            if (password !== confirmPassword) {
                $('#passwordModal').modal('show');
                return false;  // Prevent form submission
            }

            return true;  // Allow form submission
        }
    </script>
</body>
</html>
