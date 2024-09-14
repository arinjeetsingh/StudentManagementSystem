package institute;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class AdminServlet extends HttpServlet {
		
		
	private static final long serialVersionUID = 1L;
		
        @Override
		protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
		{
			HttpSession session= req.getSession(false);
			if(session!=null && "admin".equals(session.getAttribute("role")))
			{
			
				req.getRequestDispatcher("/WEB-INF/jsp/AdminPanel.jsp").forward(req, res);
			}
			else
			{
				req.getRequestDispatcher("/index.jsp").forward(req, res);
			}
		}

	}


