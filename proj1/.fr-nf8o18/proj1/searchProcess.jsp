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
      String username = (String) session.getAttribute("USERNAME");
      Connection m_con;
      String createString;
      String selectString = "select itemName, description from item";
      Statement stmt;
      
        String keyw = request.getParameter("key").trim();
        String[] keyword = (keyw).split(" ");

        String beginDate = request.getParameter("date1").trim();
        String[] bdate = (beginDate).split(" ");

        String endDate = request.getParameter("date2").trim();
        String[] edate = (endDate).split(" ");

        String photo_id= "";

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
//--------------------------------------below for sort by time-----------------------------------------------------
  try{
  if (request.getParameter("searchT") != null)
          {
    if (!(request.getParameter("key").equals(""))){
        if (!(keyw.equals("")) && endDate.equals("") && beginDate.equals("")){

        for(int i=0; i<keyword.length; i++){
           PreparedStatement doSearch = m_con.prepareStatement("SELECT DISTINCT (score(1)+ 6  *score(2)+ 3*score(3)) as score1, a.description, a.timing, a.subject , a.place,  a.photo_id ,rank() over (order by a.timing asc) rnk FROM images a, group_lists b WHERE (owner_name ='"+username+"' or permitted = 1 or OWNER_NAME <> '"+ username+ "' AND A.PERMITTED = B.GROUP_ID AND '"+username+"' = B.FRIEND_ID) and (contains(a.description, ? , 1) > 0 or contains(a.subject, ? , 2) > 0 or contains(a.place, ? , 3) > 0) order by score1 desc, rnk asc");
        
        doSearch.setString(1,keyword[i]);
        doSearch.setString(2,keyword[i]);
        doSearch.setString(3,keyword[i]);
        ResultSet rset2 = doSearch.executeQuery();
      
                  out.println("<p>This is for keyword "+keyword[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>description</th>");
                  out.println("<th>Score</th>");
                  out.println("<th>Date</th>");
                  out.println("<th>subject</th>");
                  out.println("<th>place</th>");
                  out.println("<th>photo id</th>");
                  out.println("<th>photo</th>");

                  out.println("</tr>");
      while(rset2.next())
                    {
                    photo_id= (rset2.getObject(6)).toString();
        //out.println("joeeeeeeee");
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getObject(1));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(3));
                    out.println("</td>");


                    out.println("<td>"); 
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(5));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(6));
                    out.println("</td>");

                    out.println("<td>");
                    out.println("<a href=\"/proj1/displaySinglePhoto.jsp?"+photo_id+"\">");// specify the servlet for the themernail
                    out.println("<img src=\"/proj1/displayblob.jsp?thumbnail"+photo_id+"\"></a>");
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
                }
              }
//-----------------------------------------------------------------------------------------------------------
     // else if(!(keyw == null && beginDate == null && endDate== null)){
      else if (!(keyw.equals("") && endDate.equals("") && beginDate.equals(""))){
        //out.println("love");
        for(int i=0; i<keyword.length; i++){
           PreparedStatement doSearch = m_con.prepareStatement("SELECT DISTINCT (score(1)+ 6  *score(2)+ 3*score(3)) as score1, a.description, a.timing, a.subject , a.place,  a.photo_id ,rank() over (order by a.timing asc) rnk FROM images a, group_lists b WHERE  (owner_name ='"+username+"' or permitted = 1 or OWNER_NAME <> '"+ username+ "' AND A.PERMITTED = B.GROUP_ID AND '"+username+"' = B.FRIEND_ID) and (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) and (contains(description, ? , 1) > 0 or contains(subject, ? , 2) > 0 or contains(place, ? , 3) > 0) order by rnk, score1 desc");

        doSearch.setString(1,keyword[i]);
        doSearch.setString(2,keyword[i]);
        doSearch.setString(3,keyword[i]);
        ResultSet rset2 = doSearch.executeQuery();
      
         // ResultSet rset2 = doSearch.executeQuery();
                  out.println("<p>This is for keyword "+keyword[i]+":</p>");         
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>description</th>");
                  out.println("<th>Score</th>");
                  out.println("<th>Date</th>");
                  out.println("<th>subject</th>");
                  out.println("<th>place</th>");
                  out.println("<th>photo id</th>");
                  out.println("<th>photo</th>");

                  out.println("</tr>");
      while(rset2.next())
                    {
                    photo_id= (rset2.getObject(6)).toString();
        //out.println("joeeeeeeee");
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getObject(1));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(3));
                    out.println("</td>");


                    out.println("<td>"); 
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(5));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(6));
                    out.println("</td>");

                    out.println("<td>");
                    out.println("<a href=\"/proj1/displaySinglePhoto.jsp?"+photo_id+"\">");// specify the servlet for the themernail
                    out.println("<img src=\"/proj1/displayblob.jsp?thumbnail"+photo_id+"\"></a>");
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
                }
              }
//-----------------------------------------------------------------------------------------------------------
      //else if (keyw.equals("") && !(endDate.equals("")) && !(beginDate.equals(""))){

            }
//----------------------------------------------------------------------------------------------------------------
    if (request.getParameter("key").equals("")){
      if (keyw.equals("") && !(endDate.equals("")) && !(beginDate.equals(""))){
        //out.println("bb");
        //out.println(beginDate+" "+endDate);
        for(int i=0; i<keyword.length; i++){
           PreparedStatement doSearch = m_con.prepareStatement("SELECT DISTINCT a.description, a.timing, a.subject , a.place,  a.photo_id ,rank() over (order by a.timing asc) rnk FROM images a, group_lists b WHERE (owner_name ='"+username+"' or permitted = 1 or OWNER_NAME <> '"+ username+ "' AND A.PERMITTED = B.GROUP_ID AND '"+username+"' = B.FRIEND_ID) and (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) order by rnk asc");
  
        ResultSet rset2 = doSearch.executeQuery();
         // ResultSet rset2 = doSearch.executeQuery();
                  out.println("<p>This is for keyword "+keyword[i]+":</p>");        
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>description</th>");
                  out.println("<th>Date</th>");
                  out.println("<th>subject</th>");
                  out.println("<th>place</th>");
                  out.println("<th>photo id</th>");
                  out.println("<th>photo</th>");

                  out.println("</tr>");
      while(rset2.next())
                    {
                    photo_id= (rset2.getObject(5)).toString();
        //out.println("joeeeeeeee");
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

                    out.println("<td>"); 
                    out.println(rset2.getString(5));
                    out.println("</td>");


                    out.println("<td>");
                    out.println("<a href=\"/proj1/displaySinglePhoto.jsp?"+photo_id+"\">");// specify the servlet for the themernail
                    out.println("<img src=\"/proj1/displayblob.jsp?thumbnail"+photo_id+"\"></a>");
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
                }
              }
              else
              {
                  JFrame frame = new JFrame("JOptionPane showMessageDialog Error");
                  JOptionPane.showMessageDialog(frame,"Plase enter two date!!!");
                  response.sendRedirect("search.html");
              }
            }
   }
//--------------------------------------------------------------------------------------------------------------
  if (request.getParameter("searchTF") != null)
          {
    if (!(request.getParameter("key").equals(""))){
        if (!(keyw.equals("")) && endDate.equals("") && beginDate.equals("")){
      //if (!(keyw==null)&& beginDate == null && endDate == null){
           //   out.println("jojojojojojojo");
        for(int i=0; i<keyword.length; i++){
           PreparedStatement doSearch = m_con.prepareStatement("SELECT DISTINCT (score(1)+ 6  *score(2)+ 3*score(3)) as score1, a.description, a.timing, a.subject , a.place,  a.photo_id ,rank() over (order by a.timing desc) rnk FROM images a, group_lists b WHERE (owner_name ='"+username+"' or permitted = 1 or OWNER_NAME <> '"+ username+ "' AND A.PERMITTED = B.GROUP_ID AND '"+username+"' = B.FRIEND_ID) and (contains(a.description, ? , 1) > 0 or contains(a.subject, ? , 2) > 0 or contains(a.place, ? , 3) > 0) order by score1 desc, rnk asc");

        doSearch.setString(1,keyword[i]);
        doSearch.setString(2,keyword[i]);
        doSearch.setString(3,keyword[i]);
        ResultSet rset2 = doSearch.executeQuery();
      
         // ResultSet rset2 = doSearch.executeQuery();
                  out.println("<p>This is for keyword "+keyword[i]+":</p>");         
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>description</th>");
                  out.println("<th>Score</th>");
                  out.println("<th>Date</th>");
                  out.println("<th>subject</th>");
                  out.println("<th>place</th>");
                  out.println("<th>photo id</th>");
                  out.println("<th>photo</th>");

                  out.println("</tr>");
      while(rset2.next())
                    {
                    photo_id= (rset2.getObject(6)).toString();
        //out.println("joeeeeeeee");
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getObject(1));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(3));
                    out.println("</td>");


                    out.println("<td>"); 
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(5));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(6));
                    out.println("</td>");

                    out.println("<td>");
                    out.println("<a href=\"/proj1/displaySinglePhoto.jsp?"+photo_id+"\">");// specify the servlet for the themernail
                    out.println("<img src=\"/proj1/displayblob.jsp?thumbnail"+photo_id+"\"></a>");
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
                }
              }
//-----------------------------------------------------------------------------------------------------------
     // else if(!(keyw == null && beginDate == null && endDate== null)){
      else if (!(keyw.equals("") && endDate.equals("") && beginDate.equals(""))){
        //out.println("love");
        for(int i=0; i<keyword.length; i++){
           PreparedStatement doSearch = m_con.prepareStatement("SELECT DISTINCT (score(1)+ 6  *score(2)+ 3*score(3)) as score1, a.description, a.timing, a.subject , a.place,  a.photo_id ,rank() over (order by a.timing desc) rnk FROM images a, group_lists b WHERE  (owner_name ='"+username+"' or permitted = 1 or OWNER_NAME <> '"+ username+ "' AND A.PERMITTED = B.GROUP_ID AND '"+username+"' = B.FRIEND_ID) and (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) and (contains(description, ? , 1) > 0 or contains(subject, ? , 2) > 0 or contains(place, ? , 3) > 0) order by rnk, score1 desc");

        doSearch.setString(1,keyword[i]);
        doSearch.setString(2,keyword[i]);
        doSearch.setString(3,keyword[i]);
        ResultSet rset2 = doSearch.executeQuery();
      
         // ResultSet rset2 = doSearch.executeQuery();
                  out.println("<p>This is for keyword "+keyword[i]+":</p>");         
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>description</th>");
                  out.println("<th>Score</th>");
                  out.println("<th>Date</th>");
                  out.println("<th>subject</th>");
                  out.println("<th>place</th>");
                  out.println("<th>photo id</th>");
                  out.println("<th>photo</th>");

                  out.println("</tr>");
      while(rset2.next())
                    {
                    photo_id= (rset2.getObject(6)).toString();
        //out.println("joeeeeeeee");
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getObject(1));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(3));
                    out.println("</td>");


                    out.println("<td>"); 
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(5));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(6));
                    out.println("</td>");


                    out.println("<td>");
                    out.println("<a href=\"/proj1/displaySinglePhoto.jsp?"+photo_id+"\">");// specify the servlet for the themernail
                    out.println("<img src=\"/proj1/displayblob.jsp?thumbnail"+photo_id+"\"></a>");
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
                }
              }
//-----------------------------------------------------------------------------------------------------------
      //else if (keyw.equals("") && !(endDate.equals("")) && !(beginDate.equals(""))){

            }
//----------------------------------------------------------------------------------------------------------------
    if (request.getParameter("key").equals("")){
      if (keyw.equals("") && !(endDate.equals("")) && !(beginDate.equals(""))){
        //out.println("bb");
        //out.println(beginDate+" "+endDate);
        for(int i=0; i<keyword.length; i++){
           PreparedStatement doSearch = m_con.prepareStatement("SELECT DISTINCT a.description, a.timing, a.subject , a.place,  a.photo_id ,rank() over (order by a.timing desc) rnk FROM images a, group_lists b WHERE (owner_name ='"+username+"' or permitted = 1 or OWNER_NAME <> '"+ username+ "' AND A.PERMITTED = B.GROUP_ID AND '"+username+"' = B.FRIEND_ID) and (timing BETWEEN to_date ('"+beginDate+"','yyyy-mm-dd') and to_date('"+endDate+"','yyyy-mm-dd')) order by rnk asc");
    
        ResultSet rset2 = doSearch.executeQuery();
      
                  out.println("<p>This is for keyword "+keyword[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>description</th>");
                  out.println("<th>Date</th>");
                  out.println("<th>subject</th>");
                  out.println("<th>place</th>");
                  out.println("<th>photo id</th>");
                  out.println("<th>photo</th>");

                  out.println("</tr>");
      while(rset2.next())
                    {
                    photo_id= (rset2.getObject(5)).toString();
        //out.println("joeeeeeeee");
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

                    out.println("<td>"); 
                    out.println(rset2.getString(5));
                    out.println("</td>");

                    out.println("<td>");
                    out.println("<a href=\"/proj1/displaySinglePhoto.jsp?"+photo_id+"\">");// specify the servlet for the themernail
                    out.println("<img src=\"/proj1/displayblob.jsp?thumbnail"+photo_id+"\"></a>");
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
                }
              }
              else
              {
                  JFrame frame = new JFrame("JOptionPane showMessageDialog Error");
                  JOptionPane.showMessageDialog(frame,"Plase enter two date!!!");
                  response.sendRedirect("search.html");
              }
            }
   }
//-----------------------------------below for sort by score----------------------------------------------------
  if (request.getParameter("searchS") != null)
          {
    if ((!(request.getParameter("key").equals(""))&&endDate.equals("") && beginDate.equals(""))){

      for(int i=0; i<keyword.length; i++){
        PreparedStatement doSearch = m_con.prepareStatement("SELECT DISTINCT (score(1)+ 6  *score(2)+ 3*score(3)) as score1, a.description, a.timing, a.subject , a.place,  a.photo_id FROM images a, group_lists b WHERE (owner_name ='"+username+"' or permitted = 1 or OWNER_NAME <> '"+ username+ "' AND A.PERMITTED = B.GROUP_ID AND '"+username+"' = B.FRIEND_ID) and (contains(a.description, ? , 1) > 0 or contains(a.subject, ? , 2) > 0 or contains(a.place, ? , 3) > 0) order by score1 desc, photo_id");

        doSearch.setString(1,keyword[i]);
        doSearch.setString(2,keyword[i]);
        doSearch.setString(3,keyword[i]);
        ResultSet rset2 = doSearch.executeQuery();
      
         // ResultSet rset2 = doSearch.executeQuery();
                  out.println("<p>This is for keyword "+keyword[i]+":</p>");
                  out.println("<table border=1>");
                  out.println("<tr>");
      
                  out.println("<th>description</th>");
                  out.println("<th>Score</th>");
                  out.println("<th>Date</th>");
                  out.println("<th>subject</th>");
                  out.println("<th>place</th>");
                  out.println("<th>photo id</th>");
                  out.println("<th>photo</th>");

                  out.println("</tr>");
      while(rset2.next())
                    {
                    photo_id= (rset2.getObject(6)).toString();
        //out.println("joeeeeeeee");
                    out.println("<tr>");
                    out.println("<td>"); 
                    out.println(rset2.getString(2));
                    out.println("</td>");

                    out.println("<td>");
                    out.println(rset2.getObject(1));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(3));
                    out.println("</td>");


                    out.println("<td>"); 
                    out.println(rset2.getString(4));
                    out.println("</td>");

                    out.println("<td>"); 
                    out.println(rset2.getString(5));
                    out.println("</td>");
                    out.println("<td>"); 
                    out.println(rset2.getString(6));
                    out.println("</td>");


                    out.println("<td>");
                    out.println("<a href=\"/proj1/displaySinglePhoto.jsp?"+photo_id+"\">");// specify the servlet for the themernail
                    out.println("<img src=\"/proj1/displayblob.jsp?thumbnail"+photo_id+"\"></a>");
                    out.println("</td>");

                    out.println("</tr>");
                    } 
                  out.println("</table>");
                }
              }

//-----------------------------------------------------------------------------------------------
// more work here
    else if (request.getParameter("key").equals("") && !(endDate.equals("")) && !(beginDate.equals(""))){
                  JFrame frame = new JFrame("JOptionPane showMessageDialog Error");
                  JOptionPane.showMessageDialog(frame,"Plase enter the key!!!");
                  response.sendRedirect("search.html");
              }
    else if ((!(request.getParameter("key").equals("")) && endDate.equals("") && !(beginDate.equals("")))||(!(request.getParameter("key").equals("")) && !(endDate.equals("")) && beginDate.equals(""))){
                  JFrame frame = new JFrame("JOptionPane showMessageDialog Error");
                  JOptionPane.showMessageDialog(frame,"Plase enter two date!!!");
                  response.sendRedirect("search.html");
              }

   }
   m_con.close();
  }
        catch(SQLException e)
        {
          out.println("SQLException: " +
          e.getMessage());
    m_con.rollback();
        }
  
%>
<br>
<br>
<br>
   </form>
  </body>
</html>
