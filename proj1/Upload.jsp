<HTML>
<HEAD>
<TITLE>Upload Record Results</TITLE>
</HEAD>
<BODY>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.*"%>
<%@ page import="java.lang.System"%>
<% 

//Check authority
	int waitvar = 0;
	String secClass = (String) session.getAttribute("SECCLASS");
	//out.println("<p><b> Your classtype is "+secClass+" </b></p>");
	char checkClass = secClass.charAt(0);
	
	if (checkClass != 'r') {
		secClass = "";
		out.println("<p>Unauthorized access</p>");
		response.sendRedirect("RISlogin.html");
	}
	if(request.getParameter("USubmit") != null){

	//Get Report info from the Report form
	String p_ID (request.getParameter("PID")).trim();
	String d_ID (request.getParameter("DID")).trim();
	String r_ID (request.getParameter("RID")).trim();
	String t_Type (request.getParameter("TTYPE")).trim();
	String pDate = (request.getParameter("PDATE")).trim();
	String tDate = (request.getParameter("TDATE")).trim();
	String diag (request.getParameter("DIAG")).trim();
	String descrip (request.getParameter("DESCRIP")).trim();
	/*SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
	Date sDate = formatter.parse(startDate);
	Date eDate = formatter.parse(endDate);
	*/
		//establish the connection to the underlying database
        	Connection conn = null;
	
		String driverName = "oracle.jdbc.driver.OracleDriver";
       	 	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	
		try{
		//load and register the driver
        		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());
       	 	}
		catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
	        }
	
        	try{
	        //establish the connection 
			conn = DriverManager.getConnection(dbstring,"murdock","Marty8979cat");
      			conn.setAutoCommit(false);
        	}
        	catch(Exception ex){
	        	out.println("<hr>" + ex.getMessage() + "<hr>");
       		}
		//Create new radiology record
		Statement stmt = null;
		ResultSet rset = null;
		/*INSERT SQL STUFF HERE 
		record id will equal lowest existing record + 1 


		*/

		int recordid = 1;
		session.setAttribute("RECORD_ID",recordid);
		waitvar = 1;

	}
	if (waitvar == 1){
		response.sendRedirect("picture upload servlet thing");
	}
	
%>
</BODY>
</HTML>
