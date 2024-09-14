<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600&display=swap" rel="stylesheet">
        <title>Forgot Password</title>
        <style>
            html, body {
                height: 100%;
                margin: 0;
                font-family: 'Open Sans', sans-serif;
                font-size: 18px;
            }
            body {
                margin: 0;
                padding: 0;
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
                font-size: 22px;
            }
            .navbar-brand {
                font-size: 28px;
                font-weight: 600;
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
                background-color: rgba(255, 255, 255, 0.4);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                max-width: 900px;
                width: 100%;
            }
            .form-group {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .form-group label {
                font-size: 20px;
                font-weight: 600;
                color: #333;
                margin-bottom: 10px;
                text-align: center;
            }
            .form-group input {
                font-size: 18px;
                padding: 10px;
                max-width: 400px;
                width: 100%;
            }
            .btn-block {
                max-width: 400px;
                margin: 0 auto;
            }
        </style>
    </head>
    <body>
        <nav class="navbar">
            <div class="navbar-brand">Skills</div>
            <ul class="navbar-menu">
                <li class="navbar-item"><a href="index.jsp">Home</a></li>
            </ul>
        </nav>
        <div class="background-image">
            <div class="form-container">
                <form action="ForgotPasswordServlet" method="post">
                    <div class="form-group">
                        <label for="uname">Enter your Email and We will send your password to your Registered E-mail Id!</label>
                        <input type="email" class="form-control" name="email" placeholder="Enter your E-mail" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Send Password</button>
                </form>
            </div>
        </div>
    </body>
</html>
