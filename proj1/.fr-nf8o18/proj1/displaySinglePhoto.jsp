<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import= "java.util.* "%>
<%@ page import= "java.lang.System.* "%>
<html><head>
<title>edit image</title>
</head>
<body>
	<%String photo_id  = request.getQueryString();%>
  
	<%String currentName = (String)session.getAttribute("USERNAME");
    int photoToInt  = -1;
		String getGroup = "select group_id, group_name from groups where user_name = '" + currentName +"'";
		String getCount = "select max(count) from popularity where photo_id ="+ photo_id+"";
    String getRealOwner = "select owner_name, subject, place, timing, description from images where photo_id ="+photo_id+"";
    String getCountUser= "select user_name from popularity where photo_id ="+photo_id+"";
    
	  
		ArrayList<String> group_id = new ArrayList<String>();
		ArrayList<String> group_name = new ArrayList<String>();

		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
     		String m_driverName = "oracle.jdbc.driver.OracleDriver";
		
      		String m_userName = "qyu4";
       		String m_password = "yuqiang123";

      		Connection m_con = null;
      		Statement stmt = null;
          ResultSet rset1 = null;
     		  Statement stmt2 = null;      		
      		ResultSet rset2 = null;
          Statement stmt3 = null;
          ResultSet rset3 = null;
          Statement stmt4 = null;
          ResultSet rset4 = null;
          Statement stmt5 = null;
          ResultSet rset5 = null;
          String realOwner=null;
          String imgSub = null;
          String imgPlace=null;
          String imgTiming=null;
          String imgDesc=null;
          String countNumber = null;
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
	 

      /*retrieve all groupid*/
	     try
	     {
	      m_con = DriverManager.getConnection(m_url, m_userName,
              m_password);
	      stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
              rset1 = stmt.executeQuery(getGroup);
	      while (rset1.next()){
			group_id.add(rset1.getString(1));	
			group_name.add(rset1.getString(2));	
	      }
   

       } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
       }
       /*retrieve count*/
	     try
	     {
	      stmt2 = m_con.createStatement();
        rset2 = stmt2.executeQuery(getCount);
        rset2.next();
        countNumber = rset2.getString(1);
        } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
       }


        try
        {
        stmt5 = m_con.createStatement();
        rset5 = stmt5.executeQuery(getCountUser);
        while (rset5.next()){
            if (rset5.getString(1).equals(currentName) || currentName.equals("admin")) flag = true;
            }
        } catch(SQLException ex) {
              out.println("SQLException: find same user or admin :" +
              ex.getMessage());
        }
        if (!flag){
          try
        {
            photoToInt = Integer.parseInt(countNumber);
            out.println("b4 +1 photoPOP is "+ photoToInt);
            photoToInt +=1;
            stmt3 = m_con.createStatement();
            String updatePop= " insert into popularity values("+photo_id +","+photoToInt+",'"+ currentName+"')";
            out.println(updatePop+"---made niubi");
            rset3 = stmt3.executeQuery(updatePop);
            } catch(SQLException ex) {
                  out.println("SQLException: update error:" +
                  ex.getMessage());
            }
      }
        try
        {
        stmt4 = m_con.createStatement();
        
        rset4 = stmt4.executeQuery(getRealOwner);
        rset4.next();
        realOwner = rset4.getString(1);
        if (realOwner == null) realOwner = "admin_";         
        imgSub = rset4.getString(2); 
        imgPlace=rset4.getString(3); 
        imgTiming=rset4.getString(4); 
        imgDesc=rset4.getString(5); 
      
        } catch(SQLException ex) {
              out.println("SQLException: " +
              ex.getMessage());
       }

       m_con.close();
	%>
<%if (realOwner.equals(currentName) || currentName.equals("admin")){%>

<img src="/proj1/displayblob.jsp?<%=photo_id%>"><br>

You can add more infomation to the image!

<form method = 'post' action = 'displayEditing.jsp'>
<table>
<tr valign="top" align="left"><td><b>Owner</b></td>
<td><input type="text" name="owner_name" maxlength=24 value = <%=currentName%>>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>permitted group:</I></B></TD>
<!--<TD><INPUT TYPE="text" NAME="DeleteName" VALUE="Group Name"><BR></TD>-->
<TD><select name="permitted">
<option value= "-1">  
  <option value= "2">private
    <option value= "1">public
      <option value= "0">0</option>

  </select>
</TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>permitted group:</I></B></TD>
<!--<TD><INPUT TYPE="text" NAME="DeleteName" VALUE="Group Name"><BR></TD>-->
<TD><select name="DeleteName">
    <option value= "noGroup"> 
    <%	for (int i=0; i<group_name.size(); i++)
	{	%>
		<option value= "<%=group_name.get(i)%>"> <%=group_name.get(i)%></option>
  	<%
	}
	%>
  </select>
</TD>
</TR>

<input type="hidden" name="pic_id" value=<%=photo_id%>>

<tr valign="top" align="left"><td><b>Subject</b></td>
<td><input type="text" name="subject" maxlength=128 placeholder="Subject of the image">
</td>
</tr>
<tr valign="top" align="left"><td><b>Place</b></td>
<td><input type="text" name="place" maxlength=128 placeholder="Place image taken">
</td>
</tr>
<tr valign="top" align="left"><td><b>Timing</b></td>
<td><input type="text" name="timing" maxlength=38 placeholder="Format: 2010-01-19">
</td>
</tr>
<tr valign="top" align="left"><td><b>Description</b></td>
<td><textarea name="description" cols="30" rows="3" maxlength="2048" id="desc" placeholder="Image description">
</textarea>
<tr>
<td><input name=".submit" value="Update" type="submit"></td>

<td><input name=".reset" value="Reset" type="reset"></td>
</tr>
</td></table>
</form>

<form method = 'post' action = 'deleteOnePic.jsp'>
<input type="hidden" name="pic_id" value=<%=photo_id%>>
<input name=".delete" value="Delete" type="submit">
</form>
  <%
    } else {
  %>
  <img src="/proj1/displayblob.jsp?<%=photo_id%>"><br>
image owner:<%=realOwner%><hr>
image subject:<%=imgSub%><hr>
image place:<%=imgPlace%><hr>
image timing:<%=imgTiming%><hr>   
image description:<%=imgDesc%><hr>
      <a href="displayAll.jsp"> <button type="button">image display</button> </a>          
  <%
    } 
  %>
</body>
</html>



			
		
		
