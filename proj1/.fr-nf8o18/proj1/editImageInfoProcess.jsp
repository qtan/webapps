
<HTML>
<BODY>
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %>  
 <%
  HttpSession sess =  request.getSession(false);  
  String photo_id = sess.getAttribute("pic_id").toString();
  out.println(""+photo_id);
  
%> 
<%    String currentName = (String)session.getAttribute("USERNAME");

    //String getGroup = "select group_id, group_name from groups where user_name = '" + currentName +"'";
    String createCount = "insert into popularity values ("+ photo_id+",0,'"+currentName+"')";
    //String updatePop= " UPDATE popularity SET count=" +countResult+"' WHERE photo_id = "+photo_id +"";

    String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    String m_driverName = "oracle.jdbc.driver.OracleDriver";
    
    String m_userName = "qyu4";
    String m_password = "yuqiang123";

    Connection m_con = null;
    Statement stmt = null;
    Statement stmt1=null;
    ResultSet rset = null;
 
          Boolean flag = false;
  

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
        m_con = DriverManager.getConnection(m_url, m_userName, m_password);
        stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        stmt1= m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rset = stmt.executeQuery(createCount);
        out.println(createCount+"");
        } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
        }
         
            try
             {
                stmt = m_con.createStatement();
                stmt1 = m_con.createStatement();
                rset = stmt.executeQuery("select photo_id from images where owner_name = 'admin'");
                while (rset.next()){
                int curID = rset.getInt(1);
                out.println("photo_id is "+ curID);%><br><%
                try{
                stmt1.executeQuery("insert into popularity values ("+ curID+",0,'"+currentName+"')");%><br><%
              }catch(Exception ex){ out.println("exception");%><br><%}
                out.println("insert into popularity values ("+ curID+",0,'"+currentName+"')");%><hr><%

              }

            }catch(Exception ex)
            {
            out.println(""+ ex.getMessage()+"");
            }finally{
            try{
              rset.close();
              stmt.close();
              m_con.close();
              out.println("ok in close db");
              }
            catch(Exception  e){}
            response.sendRedirect("editImageInformation.jsp");
         }%>



</BODY>
</HTML>