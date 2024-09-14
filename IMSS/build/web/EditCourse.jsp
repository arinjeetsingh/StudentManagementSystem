<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page import="institute.DataBaseUtil" %>
<%@ page import="institute.EditUserServlet" %>

<%

    String idStr = request.getParameter("id");
  
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
    ResultSet rs = null;
    PreparedStatement pst = null;

    String cname = "", des = "", profilePic = "";

    try {
        conn = DataBaseUtil.getConnection();
        String sql = "SELECT * FROM courses WHERE cid = ?";
        pst = conn.prepareStatement(sql);
        pst.setInt(1, id);
        rs = pst.executeQuery();
        
        if (rs.next()) {
            cname = rs.getString("course");
            des = rs.getString("description");
            profilePic = rs.getString("course_pic");
        } else {
            out.println("Course not found.");
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
    .background-image {
            background-image: url('addcoursebg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: calc(100vh); /* Adjust based on navbar height */
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            
        }
</style>
</head>
<body>
    <div class="background-image">
<div class="container">
    <h3 class="mb-4">Edit User</h3>
    <form action="EditCourseServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= id %>">
        <div class="form-group">
            <label for="cname">Name</label>
            <input type="text" class="form-control" id="cname" name="cname" value="<%= cname %>" required>
        </div>
        <div class="form-group">
            <label for="des">Description</label>
            <input type="text" class="form-control" id="des" name="des" value="<%= des %>" required>
        </div>
        
        <div class="form-group">
            <label for="profilePic">Course Picture</label>
            <input type="file" class="form-control" id="profilePic" name="profilePic">
            <img src="upload/<%= profilePic != null ? profilePic : "course.jpg" %>" alt="Profile Picture" class="profile-img mt-2">
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
    </form>
</div>
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
