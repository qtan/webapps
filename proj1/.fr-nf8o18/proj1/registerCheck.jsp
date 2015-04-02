<HTML>
<BODY>
 <%@ page import="java.sql.*" %> 
 <% if(request.getParameter("bRegister") != null) { 

	 String oracleID = "qyu4"; 
	 String oraclePwd =   "yuqiang123"; 

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
		conn = DriverManager.getConnection(dbstring, oracleID, oraclePwd); 
		conn.setAutoCommit(false); 
		} 
	catch(Exception ex){ 
		out.println("--------------" + ex.getMessage() + "---------------"); 
		}
		response.sendRedirect("register.html");
		
	}

 %> 
</BODY>
</HTML>