<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page import="institute.DataBaseUtil" %>
<%@ page import="institute.EditUserServlet" %>

<%
    
 /*  session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp");
        return;
    }
    */

    // Fetch user ID from request and validate it
    String idStr = request.getParameter("id");
    
    // 
    
   
    
    if (idStr == null || idStr.isEmpty()) {
        out.println("Invalid user ID.");
        return;
    }
    
    int id;
    try {
        id = Integer.parseInt(idStr);
        
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

    String username = "", email = "", role = "", profilePic = "", gender="", qual="" ,sid=""; 

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
            sid= rs2.getString("sid");
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
</style>
</head>
<body>
<div class="container">
    <h3 class="mb-4">Edit User</h3>
    <form action="EditUserServlet" method="post" enctype="multipart/form-data">
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
            <label for="gender">Gender</label>
            <input type="text" class="form-control" id="gender" name="gender" value="<%= gender %>" required>
        </div>
        <div class="form-group">
            <label for="qual">Highest Qualification</label>
            <input type="text" class="form-control" id="qual" name="qual" value="<%= qual %>" required>
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
