<HTML>
<head>
<title>Analysis  Proceeding</title>
</head>
<body>
<%if (session.getAttribute("USERNAME") == null){
			response.sendRedirect("RISlogin.html");
		}else{
			String userName = (String)session.getAttribute("USERNAME");
			out.println("Welcome Admin "+userName+" to the Analysis Page");	
		}
%>
	<H1>Data Analysis</H1>
	<form name="Olap" method="post" action="Analysis_second.jsp">
		<table>
		<H3>Pick your Option:</H3> 
			<tr>
			<td>Patient Name 
			<input type="checkbox" name="patientid" size="40"value="1"></input> 
			</td>
			</tr>
			<tr>
			<td>Test Type 
			<input type="checkbox"name="testtype" size="40" value="1"></input> 
			</td>
			</tr>
			<tr>
			<td>Time Period
			<input type="checkbox" name="timeperiod" size="40" value="1"></input> 
			</tr>
			</td>
			
		</table>


		<H3>Order Time Period by:</H3>
		<tr>
		<td>
		<select id = "format" name ="format" >
		<option value="default"  >Please select the following</option>
  		<option value="weekly" >weekly</option>
  		<option value="monthly" >monthly</option>
  		<option value="yearly" >yearly</option>
		</select>
		<br>
		</td>
		</tr>
		<tr>
		<td>
		<input type=submit value="Submit" name="submitAnalysis">
		</td>
		</tr>
		</form>

</BODY>
</HTML>

