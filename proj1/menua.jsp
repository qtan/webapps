<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.lang.System"%>
<HTML>
<HEAD>

<TITLE>Main Menu</TITLE>
</HEAD>
<BODY>
<%
		if (session.getAttribute("USERNAME") == null){
			response.sendRedirect("RISlogin.html");
		}else{
			String userName = (String)session.getAttribute("USERNAME");
			out.println("Welcome Admin "+userName+" to the Menu");	
		}
		String secClass = (String) session.getAttribute("SECCLASS");
		//out.println("<p><b> Your classtype is "+secClass+" </b></p>");
		char checkClass = secClass.charAt(0);
	
		if (checkClass != 'a') {
			secClass = "";
			out.println("<p>Unauthorized access</p>");
			response.sendRedirect("RISlogin.html");
		}
		if(request.getParameter("menuDir") == null)
		{
                out.println("<form method=post action=menua.jsp>");
                out.println("<input type=radio name=dir value=USERUPDATE >Update your user information<br>");
                out.println("<input type=radio name=dir value=USERMANAGE >Manage user information<br>");
		out.println("<input type=radio name=dir value=REPORT >Generate reports<br>");
		out.println("<input type=radio name=dir value=SEARCH >Search the RIS<br>");
		out.println("<input type=radio name=dir value=ANALYSIS >Generate data analysis report<br>");
		out.println("<input type=radio name=dir value=LOGOUT checked>Logout of the RIS<br>");
                out.println("<input type=submit name=menuDir value=Submit>");
                out.println("</form>");
		}
	        else if ((request.getParameter("menuDir")) != null)
		{
			String menuSelect = (request.getParameter("dir")).trim();
			//out.println("<p>Your input menu choice is "+menuSelect+"</p>");

			if (menuSelect.equals("USERUPDATE"))
			{
			    response.sendRedirect("UserUpdate.html");
			}
			else if (menuSelect.equals("USERMANAGE"))
			{
			    response.sendRedirect("UserManage.jsp");
			}
			else if (menuSelect.equals("REPORT"))
			{
			    response.sendRedirect("Report.html");
			}
			else if (menuSelect.equals("SEARCH"))
			{
			    response.sendRedirect("search.html");
			}
			else if (menuSelect.equals("ANALYSIS"))
			{
			    response.sendRedirect("Analysis.jsp");
			}
			else if (menuSelect.equals("LOGOUT"))
			{
			    session.setAttribute("USERNAME","1");
	 	            session.setAttribute("PASSWORD","1");
			    session.setAttribute("SECCLASS","1");
			    response.sendRedirect("RISlogin.html");
			}
		}
%>
</BODY>
</HTML>
