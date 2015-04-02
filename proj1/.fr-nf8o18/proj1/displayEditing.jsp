
<HTML>
<BODY>
 <%@ page import ="java.text.*"%> 
 <%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %>

 <% if(request.getParameter(".submit") != null) { 
 /*********************************************************************/
	 String photo_id  	= (request.getParameter("pic_id")).trim();//Integer.parseInt(id);
	 String owner_name 	= (request.getParameter("owner_name")).trim();
	 String permitted;
	 if(request.getParameter("permitted").equals("-1")){
	 permitted 	= "";
	 }else{
	 permitted =(request.getParameter("permitted")).trim();
	}
	 //int 	permittedInt= Integer.parseInt(permitted);
	 String subject,place,description,timing;
	 if(request.getParameter("subject").equals(null)){
	 subject 	= "";
	 }else{
	 subject =(request.getParameter("subject")).trim();
	}
	if(request.getParameter("place").equals(null)){
	 place 	= "";
	 }else{
	 place =(request.getParameter("place")).trim();
	}
	if(request.getParameter("description").equals(null)){
	 description 	= "";
	 }else{
	 description =(request.getParameter("description")).trim();
	}
	if(request.getParameter("timing").equals(null)){
		timing = "";

	 }else{
	 timing =(request.getParameter("timing")).trim();
	}
	if(request.getParameter("subject").equals("") & request.getParameter("place").equals("") & request.getParameter("description").equals("")){
	 permitted 	= "2";
	 out.println("set permitted to 2");
	 }
	 String oracle_ID="qyu4";
	 String oracle_Pwd="yuqiang123";
	 Connection conn= null;
	 String driverName = "oracle.jdbc.driver.OracleDriver"; 
	 String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS"; 
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

/****************************************************************************************/
			String groupName; 
			if(request.getParameter("DeleteName").equals("noGroup")) groupName="";
			
			else groupName=(request.getParameter("DeleteName")).trim();
		//String checkName = "select * from GROUPS where '" + groupName + "' = group_name and user_name = '" + username + "'";
		//String deleteGroup = "delete from GROUPS where '" + groupName + "' = group_name";
      		Statement stmt = null;
      		ResultSet rset1 = null;
      		Boolean flag1 = false;
      		String groupID = null;
	if(permitted.equals("0")){
	 try{

	    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		rset1 = stmt.executeQuery("select group_id from groups where group_name ='" + groupName + "'");
		rset1.next();		
	 	groupID = rset1.getString(1);
	 	//groupIDInt= Integer.parseInt(groupID);
	 	permitted = groupID;
	 	out.println("-------------------------"+permitted+"----------------------------after if-----");
       } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
       }
       finally{
       		try{
       			rset1.close();
       			stmt.close();
       			
       			}
       		catch(Exception  e){}
       }
       }

/***********************************************************************************/
	 String updateImage = "	UPDATE images SET 	owner_name = '"+owner_name+"', permitted = "+permitted+", subject = '"+subject+"', place = '"+place+"', timing =date '"+timing+"', description = '"+description +"' WHERE photo_id = "+photo_id +"";

	 out.println(updateImage); %><br><%
	 Statement stmt1 = null;
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
	 	stmt1 = conn.createStatement();
	 	rset = stmt1.executeQuery(updateImage); 
	 	response.sendRedirect("displayAll.jsp");
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

%> 
</BODY>
</HTML>
