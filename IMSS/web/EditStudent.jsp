<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page import="institute.DataBaseUtil" %>
<%@ page import="institute.EditUserServlet" %>

<%
    
   /* session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp");
        return;
    }
    */

    
    String idStr = request.getParameter("id");
    String sidStr= request.getParameter("sid");
 
    if (idStr == null || idStr.isEmpty()) {
        out.println("Invalid user ID.");
        return;
    }
    
    int id;
    int sid;
    try {
        id = Integer.parseInt(idStr);
        sid= Integer.parseInt(sidStr);
        session= request.getSession();
        session.setAttribute("id",id);

    } catch (NumberFormatException e) {
        out.println("Invalid user ID format.");
        return;
    }

    Connection conn = null;
    Connection conn2=null;
    ResultSet rs = null;
    ResultSet rs2 =null;
    PreparedStatement pst = null;
    PreparedStatement pst2 = null;

    String username = "", email = "", role = "", profilePic = "", gender="", qual="";

    try {
        conn = DataBaseUtil.getConnection();
        String sql = "SELECT * FROM users WHERE id = ?";
        pst = conn.prepareStatement(sql);
        pst.setInt(1, id);
        rs = pst.executeQuery();
        
        if (rs.next()) {
            username = rs.getString("name");
            email = rs.getString("email");
            role = rs.getString("role");
            profilePic = rs.getString("profile_pic");
        } else {
            out.println("User not found.");
            return;
        }
        
        conn2 = DataBaseUtil.getConnection();
        String sql2 = "SELECT * FROM student WHERE email = ?";
        pst2 = conn2.prepareStatement(sql2);
        pst2.setString(1, email);
        rs2 = pst2.executeQuery();
        
        if (rs2.next()) {
            gender = rs2.getString("gender");
            qual = rs2.getString("highestqualification");
            
        } else {
            out.println("User not found.");
            return;
        }
        
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit User</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    .profile-img {
        width: 50px;
        height: 50px;
        object-fit: cover;
        border-radius: 50%;
    }

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
            background-image: url('bg2.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            min-height: 100vh;
            box-sizing: border-box;
            
        }
        .form-container {
            background-color: rgba(255, 255, 255, 0.4);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 50%;
            margin: 40px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
   
</style>
</head>
<body>
        <nav class="navbar">
        <div class="navbar-brand">Skills</div>
        
    </nav>
    
    <div class="background-image">
<div class="form-container">
    <h3 class="mb-4"><b>Edit your Details</b></h3>
    <form action="EditStudentServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="sid" value="<%= sid %>">
        <div class="form-group">
            <label for="username">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= username %>" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
        </div>
        <div class="form-group">
            <label for="role">Role</label>
            <span id="role" class="form-control-static"><b><%= role %></b></span>
        </div>
        
      <div class="form-group">
    <label for="gender">Select your Gender</label><br>
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" id="male" name="gender" value="male" 
               <%= "male".equals(gender) ? "checked" : "" %>>
        <label class="form-check-label" for="male">Male</label>
    </div>
    <div class="form-check form-check-inline">
        <input class="form-check-input" type="radio" id="female" name="gender" value="female" 
               <%= "female".equals(gender) ? "checked" : "" %>>
        <label class="form-check-label" for="female">Female</label>
    </div>
</div>
        
        <div class="form-group">
    <label for="qual">Select your Highest Qualification</label>
    <select class="form-control" id="qual" name="qual">
        <option value="10th" <%= "10th".equals(qual) ? "selected" : "" %>>10th</option>
        <option value="12th" <%= "12th".equals(qual) ? "selected" : "" %>>12th</option>
        <option value="Bachelors" <%= "Bachelors".equals(qual) ? "selected" : "" %>>Bachelors</option>
        <option value="Masters" <%= "Masters".equals(qual) ? "selected" : "" %>>Masters</option>
        <option value="Phd" <%= "Phd".equals(qual) ? "selected" : "" %>>Phd</option>
    </select>
</div>
        
        
        
        <div class="form-group">
            <label for="profilePic">Profile Picture</label>
            <input type="file" class="form-control" id="profilePic" name="profilePic">
            <img src="upload/<%= profilePic != null ? profilePic : "default.png" %>" alt="Profile Picture" class="profile-img mt-2">
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
    </form>
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
        if (pst != null) try { pst.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
