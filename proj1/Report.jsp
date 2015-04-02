<HTML>
<HEAD>
<TITLE>Your Report Results</TITLE>
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
	String secClass = (String) session.getAttribute("SECCLASS");
	//out.println("<p><b> Your classtype is "+secClass+" </b></p>");
	char checkClass = secClass.charAt(0);
	
	if (checkClass != 'a') {
		secClass = "";
		out.println("<p>Unauthorized access</p>");
		response.sendRedirect("RISlogin.html");
	}
	
        if(request.getParameter("RSubmit") != null){

	//Get Report info from the Report form
	String diag = (request.getParameter("DIAG")).trim();
	String startDate = (request.getParameter("STARTD")).trim();
	String endDate = (request.getParameter("ENDD")).trim();
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
	//select the users table from the underlying db and select users with the diaganosis that fall in the date range
        Statement stmt = null;
	ResultSet rset = null;
	//include test date
        String sql = "select first_name, last_name, address, phone, test_date " +
                     "from persons p, radiology_record r "+
		     "where r.diagnosis ='"+diag+"' AND r.test_date BETWEEN '"+startDate+"' AND '"+endDate+"' AND p.patient_id = r.patient_id";
	try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);
        }
	 catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        }
	ResultSetMetaData rsetMetaData = rset.getMetaData();
	int columnCount = rsetMetaData.getColumnCount();
	String value = "";
	while(rset != null && rset.next()){
		for (int index = 1; index <= columnCount; index ++) {
			Object o = rset.getObject(index);
			if(o != null) 
			{
				value = o.toString();
			}
			else
			{
				value = "null";
			}
		out.println("<p>'"+value+"'</p>");
		}
	}
}
%>
</BODY>
</HTML>






