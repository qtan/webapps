
<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %>	
<html><head>
<title>edit image</title>
</head>
<body>
	<%
		String username = (String)session.getAttribute("USERNAME");
%>
	<%
		String getGroup = "select group_id, group_name from groups where user_name = '" + username +"'";

		ArrayList<String> group_id = new ArrayList<String>();
		ArrayList<String> group_name = new ArrayList<String>();

		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
     		String m_driverName = "oracle.jdbc.driver.OracleDriver";
		
      		String m_userName = "qyu4";
       		String m_password = "yuqiang123";

      		Connection m_con = null;
      		Statement stmt = null;
      		ResultSet rset1 = null;
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
       m_con.close();
	%>
Please add more infomation to the image!
<form method = 'post' action = 'editImageInfo.jsp'>
	<table>

<tr valign="top" align="left"><td><b>Owner</b></td>
<td><input type="text" name="owner_name" maxlength=24 value=<%=username%>>
</td>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>permitted group:</I></B></TD>
<!--<TD><INPUT TYPE="text" NAME="DeleteName" VALUE="Group Name"><BR></TD>-->
<TD><select name="permitted">
<option value= "-1">  
  <option value= "2">private
    <option value= "1">public
      <option value= "0">group option</option>

  </select>
</TD>
</TR>
<tr>

<FORM NAME="LoginForm" METHOD="post" action = "editImageInfo.jsp">
<TABLE>
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

</body>
</html>