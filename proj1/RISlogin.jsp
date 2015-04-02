<HTML>
<HEAD>


<TITLE>Your Login Result</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*" %>
<% 
	int check1 = 0;
        if(request.getParameter("Submit") != null)
        {
	        //get the user input from the login page
        	String userName = (request.getParameter("USERID")).trim();
	        String passwd = (request.getParameter("PASSWD")).trim();
        	//out.println("<p>Your input User Name is "+userName+"</p>");
        	//out.println("<p>Your input password is "+passwd+"</p>");
		session.setAttribute("USERNAME",userName);
	 	session.setAttribute("PASSWORD",passwd);


	        //establish the connection to the underlying database
        	Connection conn = null;
	
	        String driverName = "oracle.jdbc.driver.OracleDriver";
            	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	
	        try{
		        //load and register the driver
        		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());
        	}
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
	
	        }
	
        	try{
	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,"murdock","Marty8979cat");
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){
	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	

	        //select the user table from the underlying db and validate the user name and password
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql = "select password from users where user_name = '"+userName+"'";
	        //out.println(sql);
        	try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}

	        String truepwd = "";
	
        	while(rset != null && rset.next())
	        	truepwd = (rset.getString(1)).trim();
	
        	//display the result
	        if(passwd.equals(truepwd)){
		        out.println("<p><b>Your Login is Successful!</b></p>");
			String sql1 = "";
			sql1 = "select class from users where user_name = '"+userName+"'";
			//out.println(sql1);
			Statement newstmt = null;
			ResultSet newrset = null;
			newstmt = conn.createStatement();
			newrset = newstmt.executeQuery(sql1);
			String secureclass = "";
			while(newrset != null && newrset.next())
				secureclass = (newrset.getString(1)).trim();
				out.println(secureclass);
			//out.println("<p><b> Your classtype is "+secureclass+" </b></p>");
			session.setAttribute("SECCLASS",secureclass);
			if(secureclass.equals("a")){
				response.sendRedirect("menua.jsp");
			}
			else if (secureclass.equals("p")){
				response.sendRedirect("menup.jsp");
			}
			else if (secureclass.equals("d")){
				response.sendRedirect("menud.jsp");
			}
			else
				response.sendRedirect("menur.jsp");
			
		}
        	else
	        	out.println("<p><b>Either your userName or Your password is inValid!</b></p>");
			check1 = 1;

                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
        }
        if (check1 == 1)
        {
		check1 = 0;
                out.println("<form method=post action=RISlogin.jsp>");
                out.println("UserName: <input type=text name=USERID maxlength=20><br>");
                out.println("Password: <input type=password name=PASSWD maxlength=20><br>");
                out.println("<input type=submit name=Submit value=Submit>");
                out.println("</form>");
        }      
%>


</BODY>
</HTML>

