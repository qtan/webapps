
<HTML>
<BODY>
 <%@ page import="java.sql.*" %> 
 <% if(request.getParameter("bSubmit") != null) { 
	 //get the user input from the login page 
	 String userName = (request.getParameter("USERID")).trim(); 
	 String passwd =   (request.getParameter("PASSWD")).trim();
	 session.setAttribute("USERNAME",userName);
	 session.setAttribute("PASSWORD",passwd);
			
	 
	 String oracle_ID="qyu4";
	 String oracle_Pwd="yuqiang123";



	 out.println("Your input User Name is "+userName+""); %><br><%
	 out.println("Your input password is "+passwd+""); 




	 //select the user table from the underlying db and validate the user name and password 

	 Connection conn= null;
	 String driverName = "oracle.jdbc.driver.OracleDriver"; 
	 String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS"; 


	try{ 
		//establish the connection 
		Class drvClass = Class.forName(driverName); 
		DriverManager.registerDriver((Driver) drvClass.newInstance());
		conn = DriverManager.getConnection(dbstring, oracle_ID, oracle_Pwd);//(request.getParameter("ORACLE_ID")).trim(), (request.getParameter("ORACLE_PWD")).trim()); 

		conn.setAutoCommit(false); 

		} 
	catch(Exception ex){ 
		out.println("1--------------" + ex.getMessage() + "---------------"); 
		}



 	 String sql = "select password from users where user_name = '"+userName+"'"; 

	 Statement stmt = null; 
	 ResultSet rset = null;
	 try{
	 	stmt = conn.createStatement(); 
		rset = stmt.executeQuery(sql);

		} 
	 	catch(Exception ex){
	 		out.println("problem in database:    " + ex.getMessage() + "");%><br><%
	 		} 


	 String truepwd = null; 

	 while(rset != null && rset.next()) 
	 	{
	 	truepwd = (rset.getString(1)).trim();

	 	} 
	 //display the result 
	
	 if(passwd.equals(truepwd)){
	 	%><H1><CENTER>Your Login is Successful!</CENTER></H1><%
		response.sendRedirect("displayAll.jsp");
		//response.sendRedirect("register.jsp");
		} 
	 else{
		%><H1><CENTER>Either your userName or Your password is inValid!</CENTER></H1><%

		%>
		<meta http-equiv="refresh" content="3; url = login.html">
		<%
		}
	 try{
	 	conn.close();
	 	} 
	 	catch(Exception ex){ 
	 	out.println(" " + ex.getMessage() + ""); } 
	 
	}
	


//select the user table from the underlying db and validate the user name and password 

%> 
</BODY>
</HTML>