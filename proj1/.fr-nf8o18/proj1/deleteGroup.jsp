<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %> 
<html>
<body>
	<br><br>
	<%   
		String username = (String)session.getAttribute("USERNAME");
		if(username == null){
%>
	<meta http-equiv="refresh" content="0; url = login.html">
<%
}
		String groupName = request.getParameter("DeleteName");
		String checkName = "select * from GROUPS where '" + groupName + "' = group_name and user_name = '" + username + "'";
		String deleteGroup = "delete from GROUPS where '" + groupName + "' = group_name";
		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
     		String m_driverName = "oracle.jdbc.driver.OracleDriver";

      		String m_userName = "qyu4";
       		String m_password = "yuqiang123";

      		Connection m_con = null;
      		Statement stmt = null;
      		ResultSet rset1 = null;
      		Boolean flag1 = false;
	

       try
       {
              Class drvClass = Class.forName(m_driverName);
              DriverManager.registerDriver((Driver)
              drvClass.newInstance());

       } catch(Exception e)
       {
              System.err.print("ClassNotFoundException: ");
              System.err.println(e.getMessage());

       }
	 try
	 {
	      m_con = DriverManager.getConnection(m_url, m_userName,
              m_password);
	      stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
              rset1 = stmt.executeQuery(checkName);
	    if (!rset1.next() || groupName.isEmpty()){
	    	 flag1=false;
		 
	     }
	   else	{
		rset1 = stmt.executeQuery("select group_id from groups where group_name ='" + groupName + "'");
		rset1.next();		
		String groupID = rset1.getString(1);
		rset1 = stmt.executeQuery("update images set permitted = 2 where permitted = " + groupID);
		String deleteGroupList = "delete from group_lists where group_id = " + groupID;
		stmt.executeQuery(deleteGroupList);
	     	rset1 = stmt.executeQuery(deleteGroup);
		flag1=true;
	   }
      
       } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
       }
       finally{
       		try{
       			rset1.close();
       			stmt.close();
       			m_con.close();
       			}
       		catch(Exception  e){}
       }
       if(flag1 == false){
	      %>
			<H1><CENTER>Deleting Failed</CENTER></H1>
			<H1><CENTER>Group Name does not exist</CENTER></H1>
	      		<meta http-equiv="refresh" content="3; url = createGroup.jsp">
			
	      <%
       }
       else{
	     %>
			<H1><CENTER>Deleting Success</CENTER></H1>
			<meta http-equiv="refresh" content="3; url = createGroup.jsp">
	      <%
	     }
	%>
</body>
</html>
