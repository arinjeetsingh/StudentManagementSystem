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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author arinj
 */

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException
	{
		String username= req.getParameter("email");
		String password=req.getParameter("pwd");
		System.out.println(username+password);
		
		String role = DataBaseUtil.getRole(username,password);
		System.out.println(role);
		
		if(role!=null)
		{
			HttpSession session= req.getSession();
			session.setAttribute("uname", username);
			session.setAttribute("role", role);
			if("admin".equals(role))
			{
				try {
					res.sendRedirect("AdminServlet");
				} catch (IOException e) {					
					e.printStackTrace();
				}
			}
			else if("student".equals(role))
			{
				try {
					System.out.println("inside student.equalsrole");
					int sid= DataBaseUtil.getSID(username,password);
					System.out.println(sid);
					session.setAttribute("sid", sid);
					res.sendRedirect("StudentServlet");
					
				} catch (IOException e) {					
					e.printStackTrace();
				}
			}
			else if("faculty".equals(role))
			{
				try {
					res.sendRedirect("FacultyServlet");
					
				} catch (IOException e) {					
					e.printStackTrace();
				}
			}
			else
			{
				try {
					res.sendRedirect("Login.jsp");
				} catch (IOException e) {					
					e.printStackTrace();
				}
			}
		}
		else
		{
			System.out.println("No role found ");
		}
		
	}
}
