<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  <title>Search</title>
  </head>

  <body>
    <%@ page import="javax.swing.ImageIcon"%>
    <%@ page import="javax.swing.JFrame"%>
    <%@ page import="javax.swing.JOptionPane"%>
    <%
//--------------------------------------connection-----------------------------------
      String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
      String m_driverName = "oracle.jdbc.driver.OracleDriver";
      
      String m_userName = "qyu4"; //supply username
      String m_password = "yuqiang123"; //supply password
      
      String addItemError = "";

      Connection m_con;
      String createString;
      String selectString = "select itemName, description from item";
      Statement stmt;
      
        String user = request.getParameter("user").trim();
        String[] users = (user).split(" ");

        String subject = request.getParameter("subject").trim();
        String[] subjects = (subject).split(" ");

        String beginDate = request.getParameter("date1").trim();
        String[] bdate = (beginDate).split(" ");

        String endDate = request.getParameter("date2").trim();
        String[] edate = (endDate).split(" ");

      try
      {
      
        Class drvClass = Class.forName(m_driverName);
        DriverManager.registerDriver((Driver)
        drvClass.newInstance());
        m_con = DriverManager.getConnection(m_url, m_userName, m_password);
        //out.println("GOOD");
        
      }
      catch(Exception e)
      {      
        out.print("Error displaying data: ");
        out.println(e.getMessage());
        return;
      }

  try{
  if (request.getParameter("submitAnalysis") != null){
    if (endDate.equals("") && beginDate.equals("")){
//-------------------------------------------user------------------------------------------------
      if (!(request.getParameter("user").equals(""))&& request.getParameter("subject").equals("")){
//-------------------------------------------case 1------------------------------------------------
          if (request.getParameter("format").equals("default")){
            for(int i=0; i<users.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select owner_name, count(*) from images where owner_name='"+users[i]+"' group by owner_name");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>owner name</th>");
                  out.println("<th>image count</th>");

                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }}
//out.println(request.getParameter("format"));
//-------------------------------------case 6------------------------------------------------------
          else if (request.getParameter("format").equals("yearly")){
          //out.println("fasdfasfasdfasdfadsfasdf");
            for(int i=0; i<users.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select owner_name,count(*), to_char(timing, 'YYYY') from images where owner_name='"+users[i]+"' group by (owner_name, to_char(timing, 'YYYY')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>owner name</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>year</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }}
//-------------------------------------case 7------------------------------------------------------
          else if (request.getParameter("format").equals("monthly")){
            for(int i=0; i<users.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select owner_name,count(*), to_char(timing, 'YYYY-MM') from images where owner_name='"+users[i]+"' group by owner_name, to_char(timing, 'YYYY-MM')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for keyword "+users[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>owner name</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>month</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }}
//-------------------------------------case 8------------------------------------------------------
          else if (request.getParameter("format").equals("weekly")){
            for(int i=0; i<users.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select owner_name,count(*), to_char(timing, 'YYYY-ww') from images where owner_name='"+users[i]+"' group by owner_name, to_char(timing, 'YYYY-ww')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>owner name</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>week</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }}
    }
//-------------------------------------subject------------------------------------------------------
      else if (!(request.getParameter("subject").equals(""))&& request.getParameter("user").equals("")){
//-------------------------------------------case 2-----------------------------------------------
          if (request.getParameter("format").equals("default")){
            for(int i=0; i<subjects.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select subject , count(*) from images where subject like '%"+subjects[i]+"%' group by subject");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+subjects[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");

                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 

                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
                }
          }
//out.println(request.getParameter("format"));
//-------------------------------------case 9------------------------------------------------------
          else if (request.getParameter("format").equals("yearly")){
            for(int i=0; i<subjects.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY') from images where subject like '%"+subjects[i]+"%' group by subject, to_char(timing, 'YYYY')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+subjects[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>year</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }}
//-------------------------------------case 10------------------------------------------------------
          else if (request.getParameter("format").equals("monthly")){
            for(int i=0; i<subjects.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY-MM') from images where subject like '%"+subjects[i]+"%' group by subject, to_char(timing, 'YYYY-MM')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+subjects[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>month</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }}
//-------------------------------------case 11------------------------------------------------------
          else if (request.getParameter("format").equals("weekly")){
            for(int i=0; i<subjects.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY-ww') from images where subject like '%"+subjects[i]+"%' group by subject, to_char(timing, 'YYYY-ww')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+subjects[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>week</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
    }}
//-----------------------------------user and subject-------------------------------------------
    else if (!(request.getParameter("subject").equals(""))&& !(request.getParameter("user").equals(""))){
//-------------------------------------------case 15-----------------------------------------------
          if (request.getParameter("format").equals("default")){
          for(int i=0; i<users.length ; i++){
            for(int j=0; j<subjects.length ; j++){
            PreparedStatement analysis = m_con.prepareStatement("select subject, count(*), owner_name from images where subject like '%"+subjects[j]+"%' and owner_name='"+users[i]+"' group by owner_name, subject");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+" with "+subjects[j]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>user</th>");

                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
        }
      }
//out.println(request.getParameter("format"));
//-------------------------------------case 12------------------------------------------------------
          else if (request.getParameter("format").equals("yearly")){
          for(int i=0; i<users.length ; i++){
            for(int j=0; j<subjects.length ; j++){
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY'), owner_name from images where subject like '%"+subjects[j]+"%' and owner_name='"+users[i]+"' group by owner_name ,subject, to_char(timing, 'YYYY')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+" with "+subjects[j]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>year</th>");
                  out.println("<th>user</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }}}
//-------------------------------------case 13------------------------------------------------------
          else if (request.getParameter("format").equals("monthly")){
          for(int i=0; i<users.length ; i++){
                    for(int j=0; j<subjects.length ; j++){
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY-MM'), owner_name from images where subject like '%"+subjects[j]+"%' and owner_name='"+users[i]+"'group by subject, to_char(timing, 'YYYY-MM'),owner_name");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+" with "+subjects[j]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>month</th>");
                  out.println("<th>user</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
        }}
//-------------------------------------case 14------------------------------------------------------
          else if (request.getParameter("format").equals("weekly")){
          for(int i=0; i<users.length ; i++){
                    for(int j=0; j<subjects.length ; j++){
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY-ww'), owner_name from images where subject like '%"+subjects[j]+"%' and owner_name='"+users[i]+"'group by subject, to_char(timing, 'YYYY-ww'),owner_name");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+" with "+subjects[j]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>week</th>");
                  out.println("<th>user</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
    }
  }}
    else if (request.getParameter("user").equals("")  && request.getParameter("subject").equals("")){
//-------------------------------------------error---------------------------------------------------
        //out.println("fasdfasfasdfasdfadsfasdf");
          if (request.getParameter("format").equals("default")){
                  JFrame frame = new JFrame("JOptionPane showMessageDialog Error");
                  JOptionPane.showMessageDialog(frame,"Plase enter information!!!");
                  response.sendRedirect("dataAnalysis.html");
          }
//out.println(request.getParameter("format"));
//-------------------------------------case 3------------------------------------------------------
          else if (request.getParameter("format").equals("yearly")){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select count(*), to_char(timing, 'YYYY') from images group by to_char(timing, 'YYYY')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>Result by year:</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>year</th>");
                  out.println("<th>image count</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
//-------------------------------------case 4------------------------------------------------------
          else if (request.getParameter("format").equals("monthly")){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select count(*), to_char(timing, 'YYYY-MM') from images group by (to_char(timing, 'YYYY-MM'))");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>Result by month:</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>month</th>");
                  out.println("<th>image count</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
//-------------------------------------case 8------------------------------------------------------
          else if (request.getParameter("format").equals("weekly")){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select count(*), to_char(timing, 'YYYY-ww') from images group by to_char(timing, 'YYYY-ww')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>Result by week:</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>week</th>");
                  out.println("<th>image count</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
    }
  }// end if for without time period
//-------------------------------------with time -----------------------------------------------   
if (!(endDate.equals("") && beginDate.equals(""))){
//-------------------------------------------user------------------------------------------------
      if (!(request.getParameter("user").equals(""))&& request.getParameter("subject").equals("")){
//-------------------------------------------case 1------------------------------------------------
          if (request.getParameter("format").equals("default")){
            for(int i=0; i<users.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select owner_name, count(*) from images where (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) and owner_name='"+users[i]+"' group by owner_name");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>owner name</th>");
                  out.println("<th>image count</th>");

                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
            }
          }
//out.println(request.getParameter("format"));
//-------------------------------------case 6------------------------------------------------------
          else if (request.getParameter("format").equals("yearly")){
            for(int i=0; i<users.length; i++){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select owner_name,count(*), to_char(timing, 'YYYY') from images where ((to_char(timing,'yyyy') between(extract(year from to_date ('2012-01-01','yyyy-mm-dd'))) and extract(year from to_date('2012-12-01','yyyy-mm-dd')))) and owner_name='"+users[i]+"' group by(owner_name, to_char(timing, 'YYYY'))");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>owner name</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>year</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
            }
          }
//-------------------------------------case 7------------------------------------------------------
          else if (request.getParameter("format").equals("monthly")){
          for(int i=0; i<users.length; i++){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select owner_name,count(*), to_char(timing, 'YYYY-mm') from images where ((to_char(timing,'yyyy') between(extract(year from to_date ('"+beginDate+"','yyyy-mm-dd'))) and extract(year from to_date('"+endDate+"','yyyy-mm-dd')))) and ((to_char(timing,'mm') between(extract(month from to_date ('"+beginDate+"','yyyy-mm-dd'))) and extract(month from to_date('"+endDate+"','yyyy-mm-dd')))) and owner_name='"+users[i]+"' group by(owner_name, to_char(timing, 'YYYY-mm'))");

            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>owner name</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>month</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
            }
          }
//-------------------------------------case 8------------------------------------------------------
          else if (request.getParameter("format").equals("weekly")){
          for(int i=0; i<users.length; i++){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select owner_name,count(*), to_char(timing, 'YYYY-ww') from images where (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) and owner_name='"+users[i]+"' group by owner_name, to_char(timing, 'YYYY-ww')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>owner name</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>week</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
            }
          }
    }
//-------------------------------------subject------------------------------------------------------
      else if (!(request.getParameter("subject").equals(""))&& request.getParameter("user").equals("")){
//-------------------------------------------case 2-----------------------------------------------
          if (request.getParameter("format").equals("default")){
            for(int i=0; i<subjects.length; i++){
            PreparedStatement analysis = m_con.prepareStatement("select subject, count(*) from images where (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) and subject like '%"+subjects[i]+"%' group by subject");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+subjects[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");

                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
              }
          }
//out.println(request.getParameter("format"));
//-------------------------------------case 9------------------------------------------------------
          else if (request.getParameter("format").equals("yearly")){
            for(int i=0; i<subjects.length; i++){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY') from images where ((to_char(timing,'yyyy') between(extract(year from to_date ('2012-01-01','yyyy-mm-dd'))) and extract(year from to_date('2012-12-01','yyyy-mm-dd')))) and subject like '%"+subjects[i]+"%' group by subject, to_char(timing, 'YYYY')");

            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+subjects[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>year</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
            }
          }
//-------------------------------------case 10------------------------------------------------------
          else if (request.getParameter("format").equals("monthly")){
            for(int i=0; i<subjects.length; i++){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY-MM') from images where ((to_char(timing,'yyyy') between(extract(year from to_date ('"+beginDate+"','yyyy-mm-dd'))) and extract(year from to_date('"+endDate+"','yyyy-mm-dd')))) and ((to_char(timing,'mm') between(extract(month from to_date ('"+beginDate+"','yyyy-mm-dd'))) and extract(month from to_date('"+endDate+"','yyyy-mm-dd')))) and subject like '%"+subjects[i]+"%' group by subject, to_char(timing, 'YYYY-MM')");

            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+subjects[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>month</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
            }
          }
//-------------------------------------case 11------------------------------------------------------
          else if (request.getParameter("format").equals("weekly")){
            for(int i=0; i<subjects.length; i++){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY-ww') from images where (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) and subject like '%"+subjects[i]+"%' group by subject, to_char(timing, 'YYYY-ww')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+subjects[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>week</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
            }
          }
    }//!!@#@!@!@!@@!@!@
//-----------------------------------user and subject-------------------------------------------
    else if (!(request.getParameter("subject").equals(""))&& !(request.getParameter("user").equals(""))){
//-------------------------------------------case 15---------------------------------------------
          if (request.getParameter("format").equals("default")){
          for(int i=0; i<users.length ; i++){
            for(int j=0; j<subjects.length ; j++){
            PreparedStatement analysis = m_con.prepareStatement("select subject, count(*), owner_name from images where (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) and subject like '%"+subjects[j]+"%' and owner_name='"+users[i]+"' group by owner_name, subject");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+" with "+subjects[j]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>user</th>");

                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
              }
            }
          }
//out.println(request.getParameter("format"));
//-------------------------------------case 12------------------------------------------------------
          else if (request.getParameter("format").equals("yearly")){
          for(int i=0; i<users.length ; i++){
            for(int j=0; j<subjects.length ; j++){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY'), owner_name from images where ((to_char(timing,'yyyy') between(extract(year from to_date ('2012-01-01','yyyy-mm-dd'))) and extract(year from to_date('2012-12-01','yyyy-mm-dd')))) and subject like '%"+subjects[j]+"%' and owner_name='"+users[i]+"' group by owner_name ,subject, to_char(timing, 'YYYY')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+" with "+subjects[j]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>year</th>");
                  out.println("<th>user</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
              }
            }
          }
//-------------------------------------case 13------------------------------------------------------
          else if (request.getParameter("format").equals("monthly")){
          for(int i=0; i<users.length ; i++){
            for(int j=0; j<subjects.length ; j++){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY-MM'), owner_name from images where ((to_char(timing,'yyyy') between(extract(year from to_date ('"+beginDate+"','yyyy-mm-dd'))) and extract(year from to_date('"+endDate+"','yyyy-mm-dd')))) and ((to_char(timing,'mm') between(extract(month from to_date ('"+beginDate+"','yyyy-mm-dd'))) and extract(month from to_date('"+endDate+"','yyyy-mm-dd')))) and subject like '%"+subjects[j]+"%' and owner_name='"+users[i]+"'group by subject, to_char(timing, 'YYYY-MM'),owner_name");

            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+" with "+subjects[j]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>month</th>");
                  out.println("<th>user</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
              }
            }
          }
//-------------------------------------case 14------------------------------------------------------
          else if (request.getParameter("format").equals("weekly")){
          for(int i=0; i<users.length ; i++){
            for(int j=0; j<subjects.length ; j++){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select subject,count(*), to_char(timing, 'YYYY-ww'), owner_name from images where (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) and subject like '%"+subjects[j]+"%' and owner_name='"+users[i]+"'group by subject, to_char(timing, 'YYYY-ww'),owner_name");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>This is for "+users[i]+" with "+subjects[j]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>subject</th>");
                  out.println("<th>image count</th>");
                  out.println("<th>week</th>");
                  out.println("<th>user</th>");
                  out.println("</tr>");

                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(3));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
              }
            }
          }
    }
    else if (request.getParameter("user").equals("")  && request.getParameter("subject").equals("")){
//-------------------------------------------error---------------------------------------------------
        //out.println("fasdfasfasdfasdfadsfasdf");
          if (request.getParameter("format").equals("default")){
                  JFrame frame = new JFrame("JOptionPane showMessageDialog Error");
                  JOptionPane.showMessageDialog(frame,"Plase enter more information!!!");
                  response.sendRedirect("dataAnalysis.html");
          }
//out.println(request.getParameter("format"));
//-------------------------------------case 3------------------------------------------------------
          else if (request.getParameter("format").equals("yearly")){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select count(*), to_char(timing, 'YYYY') from images where ((to_char(timing,'yyyy') between(extract(year from to_date ('2012-01-01','yyyy-mm-dd'))) and extract(year from to_date('2012-12-01','yyyy-mm-dd')))) group by to_char(timing, 'YYYY')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>Result by year:</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>year</th>");
                  out.println("<th>image count</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
//-------------------------------------case 4------------------------------------------------------
          else if (request.getParameter("format").equals("monthly")){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select count(*), to_char(timing, 'YYYY-MM') from images where ((to_char(timing,'yyyy') between(extract(year from to_date ('"+beginDate+"','yyyy-mm-dd'))) and extract(year from to_date('"+endDate+"','yyyy-mm-dd')))) and ((to_char(timing,'mm') between(extract(month from to_date ('"+beginDate+"','yyyy-mm-dd'))) and extract(month from to_date('"+endDate+"','yyyy-mm-dd')))) group by to_char(timing, 'YYYY-MM')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>Result by month:</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>month</th>");
                  out.println("<th>image count</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
//-------------------------------------case 8------------------------------------------------------
          else if (request.getParameter("format").equals("weekly")){
          //out.println("fasdfasfasdfasdfadsfasdf");
            PreparedStatement analysis = m_con.prepareStatement("select count(*), to_char(timing, 'YYYY-ww') from images where (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) group by to_char(timing, 'YYYY-ww')");
            ResultSet rset2 = analysis.executeQuery();

                  out.println("<p>Result by week:</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>week</th>");
                  out.println("<th>image count</th>");
                  out.println("</tr>");
                  while(rset2.next())
                    {
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getString(1));
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
          }
    }
  }// end if for with time period
//--------------------------------------end time----------------------------------------- 
  }
   m_con.close();
  }
  catch(SQLException e)
      {
          out.println("SQLException: " +e.getMessage());
          m_con.rollback();
        }
%>
<br>
<br>
<br>
   </form>
  </body>
</html>