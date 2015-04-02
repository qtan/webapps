<HTML>
<head>
<title>Analysis Report Proceeding</title>
</head>



<body>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
	

<%
        if(request.getParameter("submitAnalysis") != null)
        {
        	Connection conn = null;
        	
	        String driverName = "oracle.jdbc.driver.OracleDriver";
            String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
            try{
		        //load and register the driver
        		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());
        	}
	        catch(Exception ex){
	        	 out.println("<hr><center>" + ex.getMessage() + "</center><hr>");
	
	        }
	
        	try{
	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,"murdock","Marty8979cat");
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){
	        
        		out.println("<hr><center>" + ex.getMessage() + "</center><hr>");
        	}
            
	       



    		
			}
			//out.println(sql);
			//out.println(myList.size());
			//out.println(myList.get(0));
		
			Statement stmt = null;
			ResultSet rset = null;
		
			try{
				stmt = conn.createStatement();
	    		rset = stmt.executeQuery(sql);
	    	
	        	ResultSetMetaData rsmd = rset.getMetaData();
	        	int colCount = rsmd.getColumnCount();
	        
	        	out.println("<table id=\"border\"><tr>");
	        	out.println("<th id=\"border\">Number of Record</th>");
	        	for (int j=0; j< myList.size(); j++) { 
					out.println("<th id=\"border\">"+myList.get(j)+"</th>");
	        	}
	        	out.println("</tr>");
	        
	       		while(rset != null && rset.next()){
	  				out.println("<tr>");
	  				for(int k=1;k<=colCount; k++) {
	  					out.println("<td id=\"border\">"+(rset.getString(k)).trim()+"</td>");
	  				}
	  				out.println("</tr>");
	       		}

				out.println("</table>");	
			}
    		catch(Exception ex){
        		out.println("<p style=\"color:red\">" + ex.getMessage() + "</p>");
			}
		
			try{
        		conn.close();
     		}
        	catch(Exception ex){
       			out.println("<p style=\"color:red\">" + ex.getMessage() + "</p>");
        	}
		
		}
	
	
%>

</BODY>
</HTML>
