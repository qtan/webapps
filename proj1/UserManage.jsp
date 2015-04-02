<HTML>
<head>
<title>Manage  Proceeding</title>
</head>
<body>
<%if (session.getAttribute("USERNAME") == null){
			response.sendRedirect("RISlogin.html");
		}else{
			String userName = (String)session.getAttribute("USERNAME");
			out.println("Welcome Admin"+userName+" to the Manage Page");	
		}
%>
</body>
</HTML>
