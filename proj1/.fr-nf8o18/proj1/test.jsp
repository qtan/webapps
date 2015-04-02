<HTML>
<BODY>
 <%@ page import="java.sql.*" %> 
 <% 
String a = request.getAttribute("OWNER").toString();
out.println(""+ a);

 %> 
</BODY>
</HTML>
