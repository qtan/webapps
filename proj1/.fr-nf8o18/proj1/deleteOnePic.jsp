<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import= "java.util.* "%>
<%@ page import= "java.lang.System.* "%>
<%
  if(request.getParameter(".delete")!=null){
  String photo_id   = (request.getParameter("pic_id")).trim();
  HttpSession sess =  request.getSession(false);
  String oracle_ID="qyu4";
  String oracle_Pwd="yuqiang123";
  String deletePic = "delete from images where photo_id ="+photo_id;
  Connection conn= null;
  String driverName = "oracle.jdbc.driver.OracleDriver"; 
  String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
  Statement stmt= null;
  ResultSet rset1=null;
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
       try
   {

        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
          rset1 = stmt.executeQuery(deletePic);
          response.sendRedirect("displayAll.jsp");
      
       } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
       }
       finally{
          try{
            conn.close();
            rset1.close();
            stmt.close();
            
            }
          catch(Exception  e){}
       }
      %>
      <H1><CENTER>Deleting Success</CENTER></H1>
      <meta http-equiv="refresh" content="3; url = displayAll.jsp">
      <%

}
%>