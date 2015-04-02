
<HTML>
<BODY>
 <%@ page import="java.sql.*" %> 
 <% if(request.getParameter("bRegister") != null) { 
	 //get the user input from the login page 
	 /*
								 User Name: <input type="text" id="username"><div>
								 First Name: <input type="text" id="firstname"><div>
								 Last Name: <input type="text" id="lastname"><div>
								 Address: <input type="text" id="address"><div>
								 Email: <input type="text" id="email"><div>
								 Phone: <input type="text" id="phone"><div>
								Pass Word: <input type="password" id="password"><div>
								Password Again: <input type="password" id="Rpassword"><div>
	 */
	 String username = 		(request.getParameter("USERNAME")).trim();

	 String firstname =   	(request.getParameter("firstname")).trim();
	 String lastname = 		(request.getParameter("lastname")).trim(); 
	 String address =   	(request.getParameter("address")).trim();
	 String email = 		(request.getParameter("email")).trim(); 
	 String phone =   		(request.getParameter("phone")).trim();
	 String password = 		(request.getParameter("password")).trim(); 
	 String rpassword =   	(request.getParameter("Rpassword")).trim();


	 String oracle_ID="qyu4";
	 String oracle_Pwd="yuqiang123";

%><br><br><br><br><br><%


	 //select the user table from the underlying db and validate the user name and password 
	 Connection conn= null;
	 String driverName = "oracle.jdbc.driver.OracleDriver"; 
	 String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS"; 
%><br><br><br><br><br><%

	try{ 
		//establish the connection 
		Class drvClass = Class.forName(driverName); 
		DriverManager.registerDriver((Driver) drvClass.newInstance());
		conn = DriverManager.getConnection(dbstring, oracle_ID, oracle_Pwd);//(request.getParameter("ORACLE_ID")).trim(), (request.getParameter("ORACLE_PWD")).trim()); 
		out.println("ok in jdbc connection");%><br><%
		conn.setAutoCommit(false); 

		} 
	catch(Exception ex){ 
		
		out.println("oracle ID is "+ oracle_ID);%><br><%
		out.println("oracle PWD is "+ oracle_Pwd);%><br><%
		out.println("1--------------" + ex.getMessage() + "---------------"); 
		}

%><br><br><br><br><br><%
/*

CREATE TABLE persons (
   user_name  varchar(24),
   first_name varchar(24),
   last_name  varchar(24),
   address    varchar(128),
   email      varchar(128),
   phone      char(10),
   PRIMARY KEY(user_name),
   UNIQUE (email),
   FOREIGN KEY (user_name) REFERENCES users
   	 String username = 		(request.getParameter("username")).trim(); 
	 String firstname =   	(request.getParameter("firstname")).trim();
	 String lastname = 		(request.getParameter("lastname")).trim(); 
	 String address =   	(request.getParameter("addresss")).trim();
	 String email = 		(request.getParameter("email")).trim(); 
	 String phone =   		(request.getParameter("phone")).trim();
	 String password = 
);
*/
	 String sqlParent = "insert into users values('"+username+"','"+password+"', sysdate)";
 	 String sql 	   = "insert into persons values('"+username+"','"+firstname+"','"+lastname+"','"+ address+"','"+ email+"','"+phone+"')"; 

	 Statement stmt = null;
	 Statement stmtParent = null;
	 ResultSet rset = null;
	 ResultSet rsetParent= null;
	 /*try{
	 	stmtParent = conn.createStatement();
	 	rsetParent = stmtParent.excuteQuery(sqlParent);
	}catch(Exception ex){
		out.println("problem in insert parent table:	"+ ex.getMessage()+ "");%><br><%
		}*/

	 try{
	 	stmt = conn.createStatement();
	 	rset = stmt.executeQuery(sqlParent); 
	 	stmtParent= conn.createStatement();
		rsetParent = stmtParent.executeQuery(sql);
%>
	<meta http-equiv="refresh" content="0; url = login.html">
<%
		} 
	 	catch(Exception ex){
	 		out.println("problem in database:    " + ex.getMessage() + "");%><br><%
	 		} 
%><br><br><br><br><br><%
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