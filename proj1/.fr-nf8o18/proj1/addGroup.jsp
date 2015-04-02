<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %> 
<html>
<body>
	<br><br>
	<%
		long id = System.currentTimeMillis();    
		String username = (String)session.getAttribute("USERNAME");

		String groupName = request.getParameter("AddName");
		String checkName = "select * from groups where group_name =  '" + groupName + "' and user_name = '" + username + "'";
		String addGroup = "insert into groups values(" + id + " , '" + username + "' , '" + groupName + "' , sysdate)";
		String addOwnerName = "insert into group_lists values(" + id + " , '" + username + "' , sysdate, null)";




      		Statement stmt = null;
      		ResultSet rset1 = null;
      		Statement stmt2 = null;
      		ResultSet rset2 = null;
      		Boolean flag1 = false;
      		
      		String oracle_ID="qyu4";
	 		String oracle_Pwd="yuqiang123";
	 		Connection conn= null;
	 		String driverName = "oracle.jdbc.driver.OracleDriver"; 
	 		String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

	try{ 
		//establish the connection 
		Class drvClass = Class.forName(driverName); 
		DriverManager.registerDriver((Driver) drvClass.newInstance());
		

		} 
	catch(Exception ex){ 
		out.println("1--------------" + ex.getMessage() + "---------------"); 
		}
	

	 try
	 {
		conn = DriverManager.getConnection(dbstring, oracle_ID, oracle_Pwd);//(request.getParameter("ORACLE_ID")).trim(), (request.getParameter("ORACLE_PWD")).trim()); 
		out.println("ok in jdbc connection");
		conn.setAutoCommit(false); 


		}
	 	catch(Exception ex){
	 		out.println("problem in database:    " + ex.getMessage() + "");
	 		}
       // rset1 = stmt.executeQuery(addGroup);

	 try
	 {
	 		stmt = conn.createStatement();

	 		rset1 = stmt.executeQuery(checkName);
	     %>
			<H1><CENTER>Adding Success</CENTER></H1>
			<meta http-equiv="refresh" content="3; url = createGroup.jsp">
	      <%
	}catch(Exception ex)
	{
	out.println(""+ ex.getMessage()+"");
}

out.println("sql:   "+ checkName);



	 try
	 {


	    if (rset1.next() || groupName.isEmpty()){
	    	 flag1=true;
	    	 out.println("group invalid");
	     }
	   else	
	   		stmt = conn.createStatement();
	     	rset1 = stmt.executeQuery(addGroup);
	    	try
			    {
			      	stmt2 = conn.createStatement();
		        	rset2 = stmt2.executeQuery(addOwnerName);

		        } catch(SQLException ex) {
		              out.println("SQLException: " +
		              ex.getMessage());
		       }
      
       } catch(SQLException ex) {
              out.println("SQLException: " + ex.getMessage());
       }
       finally{
       		try{
       			rset1.close();
       			stmt.close();
       			conn.close();
       			}
       		catch(Exception  e){}
       }
 
%>
</body>
</html>
