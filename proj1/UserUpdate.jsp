<HTML>
<HEAD>


<TITLE>User Update</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*" %>
<% 
	String userName = (String) session.getAttribute("USERNAME");

	if (userName == null) {
		userName = "";
		out.println("<p>Unauthorized access</p>");
		response.sendRedirect("RISlogin.html");
	}

        if(request.getParameter("UserUpdate1") != null)
        {

	        //get the user input from the update page
	        String oldpasswd = (request.getParameter("PASSWD")).trim();
		String newpasswd = (request.getParameter("NEWPASSWD")).trim();	
		String newfname = (request.getParameter("FNAME")).trim();
	        String newlname = (request.getParameter("LNAME")).trim();
		String newadd = (request.getParameter("ADD")).trim();	
		String newemail = (request.getParameter("EMAIL")).trim();
	        String newphone = (request.getParameter("PHONE")).trim();


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
	        out.println(sql);
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
	        if(oldpasswd.equals(truepwd)){
		        out.println("<p><b>Your Update is Successful!</b></p>");
			String sql1 = "";
			sql1 = "Select password, FIRST_NAME, LAST_NAME, ADDRESS, EMAIL, PHONE from users, persons where user_name = '"+userName+"' & users.Person_ID==persons.Person_ID";
			out.println(sql1);
			Statement newstmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
              		ResultSet newrset = newstmt.executeQuery(sql1);
			newstmt = conn.createStatement();
			newrset = newstmt.executeQuery(sql1);
		}
        	else
	        	out.println("<p><b>Either your userName or Your password is inValid!</b></p>");

                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
        }

%>



</BODY>
</HTML>

