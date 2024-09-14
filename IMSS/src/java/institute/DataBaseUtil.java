/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package institute;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author arinj
 */
public class DataBaseUtil extends HttpServlet {

   static String url= "jdbc:mysql://localhost:3306/institutemanagementsystem";
	static String root= "root";
	static String pwddd= "arinjeet12345@";
	static String role=null;
	static
	{
	
	try
	{
     Class.forName("com.mysql.cj.jdbc.Driver");
	}
   catch(Exception ec)
   {
	System.out.println(ec.getMessage());
   }
	
	}
	
	public static Connection getConnection() throws SQLException
	{
		return DriverManager.getConnection(url,root,pwddd);
	}
	
	public static String getRole(String uname,String pwd)
	{
		System.out.println("hello world");
		
		String sql="SELECT role from users where email=? and password=?";
		try
		{
			Connection con= getConnection();
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, uname);
			ps.setString(2, pwd);
			System.out.println("hello world2");
			try
			{
			ResultSet rs= ps.executeQuery();
			if(rs.next())
			{
				System.out.println("inside if 54");
				role= rs.getString("role");
				System.out.println(role);
				
			}
			else
			{
				System.out.println("no role found from database");
				// role="student";
			}
			
			}
			catch(Exception ec2)
			{
				System.out.println(ec2.getMessage());
			}
		}
		catch(Exception ec1)
		{
			System.out.println(ec1.getMessage());
		}
		return role;
	}
	public static int getSID(String uname,String pwd)
	{
		int id= 0;
		String sql="SELECT sid from student where email=? and password=?";
		try
		{
			Connection con= getConnection();
			PreparedStatement ps= con.prepareStatement(sql);
			ps.setString(1, uname);
			ps.setString(2, pwd);
			
			try
			{
			ResultSet rs= ps.executeQuery();
			if(rs.next())
			{
				id= rs.getInt("sid");
				
			}
			else
			{
				System.out.println("no role found from database");
			}
			
			}
			catch(Exception ec2)
			{
				System.out.println(ec2.getMessage());
			}
		}
		catch(Exception ec1)
		{
			System.out.println(ec1.getMessage());
		}
		return id;
	}
}
