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
		String groupName = request.getParameter("GroupName");
		String friendName = request.getParameter("FriendName");
		String notice = request.getParameter("Notice");
		String id="";
		
		String checkName = "select * from groups where '" + groupName + "' = group_name and user_name = '" + username + "'";
		
		String getID = "select group_id from groups where group_name = '" + groupName + "'";
			

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
	    	 flag1=true;

	     }
	   else	{
		
		rset1 = stmt.executeQuery(getID);		
			if (rset1.next())
				id = rset1.getString(1);
		String checkName1 = "select * from group_lists where '" + friendName + "' = friend_id and group_id = " + id;
		rset1 = stmt.executeQuery(checkName1);

		if (rset1.next() || friendName.isEmpty())
			flag1=true;
		else{	
			
			String addFriend = "insert into group_lists values(" + id + " , '" + friendName + "' , sysdate, '" + notice + "')";
			rset1 = stmt.executeQuery(addFriend);
		}
			
		
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
       if(flag1 == true){
	      %>
			<H1><CENTER>Adding Failed</CENTER></H1>
			<H1><CENTER>Group Name does not exist OR Friend Name already existed</CENTER></H1>
	      		<meta http-equiv="refresh" content="3; url = createGroup.jsp">
			
	      <%
       }
       else{
	     %>
			<H1><CENTER>Adding Success</CENTER></H1>
			<meta http-equiv="refresh" content="3; url = createGroup.jsp">
	      <%
	     }
	%>
</body>
</html>
