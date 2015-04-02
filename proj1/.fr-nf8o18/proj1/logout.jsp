<html>
<body>
<%
session.removeAttribute("USERNAME");
response.sendRedirect("login.html");
%>
</body>
</html>