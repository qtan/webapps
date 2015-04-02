<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.lang.System"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">

</head>

<center>
<body>
	<%
		String username = (String) session.getAttribute("USERNAME");

		if (username == null) {
			username = "";
	%>
	<p>Unauthorized access</p>
	<meta http-equiv="refresh" content="1; url = login.html">
	<%
		}
		//ArrayList<String> thumbnailArray = new ArrayList<String>();
		String TABLE_NAME;
		//query fields initialization
		TABLE_NAME = "IMAGES";

		String m_url = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		String m_driverName = "oracle.jdbc.driver.OracleDriver";

		String m_userName = "qyu4";
		String m_password = "yuqiang123";

		Connection m_con = null;
		Statement stmt = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		Statement stmt4 = null;
		Statement stmt5 = null;
		Statement stmt6 = null;
		ResultSet getPermittedNo = null;
		ResultSet imgResult = null;
		ResultSet joinResult= null;
		/*SQL STATEMENTS*/
		String getImgSqlStmt = "SELECT PHOTO_ID,SUBJECT FROM IMAGES WHERE OWNER_NAME = '"+ username + "' AND PERMITTED = 2";
		String getPublicImg = "SELECT PHOTO_ID,SUBJECT FROM IMAGES WHERE PERMITTED = 1";
		String getGroupImg = "SELECT PHOTO_ID,SUBJECT FROM IMAGES A, GROUP_LISTS B WHERE A.PERMITTED = B.GROUP_ID AND '"+username+"' = B.FRIEND_ID";
		String getAdminImg = "SELECT PHOTO_ID FROM IMAGES";
		String ownerNameValue = null;
		String subjectValue = null;
		String placeValue = null;
		String descriptionValue = null;


		try {
			Class drvClass = Class.forName(m_driverName);
			DriverManager.registerDriver((Driver) drvClass.newInstance());
			drvClass.newInstance();

		} catch (Exception e) {
			System.err.print("ClassNotFoundException: ");
			System.err.println(e.getMessage());

		}
		try {

			m_con = DriverManager.getConnection(m_url, m_userName,
					m_password);
			stmt = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			stmt2 = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			stmt3 = m_con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			stmt4 = m_con.createStatement();
			stmt5 = m_con.createStatement();
			stmt6 = m_con.createStatement();
%><p>Hi <%=username%></p><%
			if (!username.equals("admin")) {
	%>
<a href="uploadImage.jsp">
<button type="button">upload image</button> </a>
<a href="createGroup.jsp">
<button type="button">group page</button> </a>
<a href="search.html">
<button type="button">search</button> </a>
<a href="userHelp.html">
<button type="button">help</button> </a>
<a href="logout.jsp">
<button type="button">logout</button> </a>
		<table border="1">
		<tr>
			<td><b><%=username%>'s Album </b></td>
		</tr>
		<tr>
			<%
				/*User's Image ==START==*/
						imgResult = stmt.executeQuery(getImgSqlStmt);
						while (imgResult.next()) {
							String id = String.valueOf(imgResult.getLong(1));
			%>
			<td><a href="displaySinglePhoto.jsp?<%=id%>"> 
				<img src="displayblob.jsp?thumbnail<%=id%>" WIDTH="100"
					HEIGHT="100"></a></td>
			<%
				}
						/*User's Image ==END==*/
			%>
		</tr>
		<tr>
			<%
				/*User's subject ==START==*/
						imgResult = stmt.executeQuery(getImgSqlStmt);
						while (imgResult.next()) {
							String id = String.valueOf(imgResult.getLong(1));
							String subject = imgResult.getString(2);
			%>
			<td><a href="displaySinglePhoto.jsp?<%=id%>"><%=subject%></a></td>
			<%
				/*User's subject ==START==*/
						}
			%>
		</tr>



		<tr>
			<td><b>Public Album</b></td>
		</tr>
		<tr>
			<%
				/*PUBLIC IMAGE ==START==*/
						imgResult = stmt2.executeQuery(getPublicImg);
						while (imgResult.next()) {
							String id = String.valueOf(imgResult.getLong(1));
			%>
			<td><a href="displaySinglePhoto.jsp?<%=id%>"> <img
					src="displayblob.jsp?thumbnail<%=id%>" WIDTH="100"
					HEIGHT="100"></a></td>
			<%
				/*PUBLIC IMAGE ==END==*/
						}
			%>
		</tr>

		<tr>
			<%
				/*PUBLIC subject ==START==*/
						imgResult = stmt2.executeQuery(getPublicImg);
						while (imgResult.next()) {
						String id = String.valueOf(imgResult.getLong(1));
							String subject = imgResult.getString(2);
			%>
			<td><a href="displaySinglePhoto.jsp?<%=id%>"><%=subject%></a></td>
			<%
				}
						/*PUBLIC subject ==END==*/
			%>
		</tr>

		<tr>
			<td><b>Group Album</b></td>
		</tr>

		<tr>
			<%
				/*Group Images ==START==*/
						imgResult = stmt3.executeQuery(getGroupImg);
						while (imgResult.next()) {
							String id = String.valueOf(imgResult.getLong(1));
			%>
			<td><a href="displaySinglePhoto.jsp?<%=id%>"> <img
					src="displayblob.jsp?thumbnail<%=id%>" WIDTH="50"
					HEIGHT="50"></a></td>
			<%
				}
						/*Group Images ==END==*/
			%>
		</tr>

		<tr>
			<%
				/*Group subject ==START==*/
						imgResult = stmt2.executeQuery(getGroupImg);
						while (imgResult.next()) {
						String id = String.valueOf(imgResult.getLong(1));
							String subject = imgResult.getString(2);
			%>
			<td><a href="displaySinglePhoto.jsp?<%=id%>"><%=subject%></a></td>
			<%
				}
						/*Group subject ==END==*/
			%>
		</tr>


	</table>
	<%
		} else {
	%>
<a href="uploadImage.jsp">
<button type="button">upload image</button> </a>
<a href="createGroup.jsp">
<button type="button">group page</button> </a>
<a href="logout.jsp">
<button type="button">logout</button> </a>
<a href="search.html">
<button type="button">search</button> </a>
<a href="adminHelp.html">
<button type="button">help</button> </a>
<a href="dataAnalysis.html">
<button type="button">admin</button> </a>
	<table border="1">
		<%
			imgResult = stmt.executeQuery(getAdminImg);
					while (imgResult.next()) {
						String id = String.valueOf(imgResult.getLong(1));
		%>
		<tr>
			<td><%=id%></td>
			<td><a href="/proj1/displaySinglePhoto.jsp?<%=id%>"> <img
					src="/proj1/displayblob.jsp?thumbnail<%=id%>" WIDTH="50"
					HEIGHT="30"></a></td>
		</tr>
		<%
			}
		%>


		<%
			}
		%>

		<tr>
			<td><b>Popularity Album</b></td>
		</tr>
		<%
		String getpopularityPic = "select photo_id, max(count) from popularity group by photo_id order by max(count) desc, photo_id";

		int i =0;
		int maxID 	=-1;
		int maxCount	=-1;
		String curPermit=null;
		String ownership=null;
		imgResult = stmt4.executeQuery(getpopularityPic);
/*
		while (imgResult.next()) {
			String id = String.valueOf(imgResult.getLong(1));
		%>
		<tr>
			<td><%=id%></td>
			<td><a href="/proj1/displaySinglePhoto.jsp?<%=id%>"> <img
					src="/proj1/displayblob.jsp?thumbnail<%=id%>" WIDTH="50"
					HEIGHT="30"></a></td>
		</tr>
		<%
			}
	
*/
			while(i<=4 && imgResult.next()){

		 		maxID 	= imgResult.getInt(1);
		 		maxCount=imgResult.getInt(2);
		 		


//out.println("maxID is :" +maxID+" and maxCount is "+maxCount+"");%><br><%
				joinResult = stmt5.executeQuery("select FRIEND_ID from group_lists g, images i where g.group_id = i.permitted AND photo_id ="+maxID+"");

				getPermittedNo = stmt6.executeQuery("select permitted, owner_name from images where photo_id ="+maxID+"");
				getPermittedNo.next();
				curPermit = String.valueOf(getPermittedNo.getLong(1));

				ownership = String.valueOf(getPermittedNo.getString(2));

				//out.println("select permitted from images where photo_id ="+maxID+"");
				//out.println("current permit no is: "+ curPermit);%><br><%
				boolean flag = false;
				String checkFname=null;

				while(joinResult.next()){
					checkFname = String.valueOf(joinResult.getString(1));

					if(checkFname.equals(username)) {
					flag = true;
					//out.println("checking if "+checkFname+" and "+username+" is the same;since user in group");%><br><%
					}
					}
				
				if(flag || username.equals("admin") || curPermit.equals("1") || ownership.equals(username)){
					%>
					<td><%=maxID%></td>
					<td><a href="/proj1/displaySinglePhoto.jsp?<%=maxID%>"> 
						<img src="/proj1/displayblob.jsp?thumbnail<%=maxID%>" WIDTH="50"
							HEIGHT="30"></a></td>
					<%
					i =  i+ 1; //in if loop, since need to increment i by 1 after we print out a img.%><br><%
					
					}
			}
	
		int sixthID 	=-1;
		int sixthCount  =-1;

		
			if(imgResult.next()){
				sixthID = imgResult.getInt(1);
				sixthCount= imgResult.getInt(2);
						//out.println("sixthID is :" +sixthID+" and sixthCount is "+sixthCount+"");%><br><%
						//out.println("maxCount is :" +maxCount+" and sixthCount is "+sixthCount+"");%><br><%
					boolean checkNext=true;
					while(sixthCount ==maxCount && checkNext){



				joinResult = stmt5.executeQuery("select FRIEND_ID from group_lists g, images i where g.group_id = i.permitted AND photo_id ="+sixthID+"");

				getPermittedNo = stmt6.executeQuery("select permitted, owner_name from images where photo_id ="+sixthID+"");
				getPermittedNo.next();
				curPermit = String.valueOf(getPermittedNo.getLong(1));

				ownership = String.valueOf(getPermittedNo.getString(2));

				//out.println("select permitted from images where photo_id ="+maxID+"");
				//out.println("current permit no is: "+ curPermit);%><br><%
				boolean flag = false;

				String checkFname=null;
				while(joinResult.next()){
					checkFname = String.valueOf(joinResult.getString(1));

					if(checkFname.equals(username)) {
					flag = true;
					//out.println("checking if "+checkFname+" and "+username+" is the same;since user in group");%><br><%
					}
					}
				
				if(flag || username.equals("admin") || curPermit.equals("1") || ownership.equals(username)){
					%>
					<td><%=sixthID%></td>
					<td><a href="/proj1/displaySinglePhoto.jsp?<%=sixthID%>"> 
						<img src="/proj1/displayblob.jsp?thumbnail<%=sixthID%>" WIDTH="50"
							HEIGHT="30"></a></td>
					<%
					i =  i+ 1; //in if loop, since need to increment i by 1 after we print out a img.%><br><%
					
					}




						if(imgResult.next()){

							sixthID = imgResult.getInt(1);
							sixthCount= imgResult.getInt(2);
							}else checkNext = false;						
					    //out.println("sixthID is :" +sixthID+" and sixthCount is "+sixthCount+"");%><br><%
						//out.println("maxCount is :" +maxCount+" and sixthCount is "+sixthCount+"");%><br><%
						}
				}
		



			} catch (SQLException e) {
				out.println("SQLException: " + e.getMessage());
			} finally {
				if (imgResult != null) {
					imgResult.close();
				}
				//stmt.close();
				m_con.close();
			}
		%>
	</center>
</body>
</html>
