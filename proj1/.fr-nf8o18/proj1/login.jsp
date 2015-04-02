<HTML>
<BODY>
 <%@ page import="java.sql.*" %> 
 <% if(request.getParameter("bSubmit") != null) { 
	 //get the user input from the login page 
	 String oracleID = "qyu4"; 
	 String oraclePwd =   "yuqiang123"; 
	 //session.setAttribute("ORACLE_ID",oracleID);
	 //session.setAttribute("ORACLE_PWD",oraclePwd);
	 //out.println("Your input User Name is "+oracleID+""); 
	 //out.println("Your input password is "+oraclePwd+""); 


	 String pwd=(String)session.getAttribute("ORACLE_PWD");
	 out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh0-------------"+ pwd);
	}
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
	 	 out.println("------------" + ex.getMessage() + "-----------------");
	 	}

	try{ 
		//establish the connection 
		conn = DriverManager.getConnection(dbstring, request.getParameter("USERID").trim(), request.getParameter("PASSWD").trim()); 
		conn.setAutoCommit(false); 
		} 
	catch(Exception ex){ 
		out.println("--------------" + ex.getMessage() + "---------------"); 
		}
		


 %> 
</BODY>
</HTML>