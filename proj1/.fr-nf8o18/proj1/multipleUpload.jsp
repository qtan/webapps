<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.System" %> 
<html><head><title>File Upload Applet</title></head><body>


	
	<table border="0" cellpadding="7" cellspacing="0" width="640">
		<tbody><tr><td colspan="2" align="center"><font color="red" face="arial" size="+1"><b><u>JUpload - File Upload Applet</u></b></font></td></tr>
		<tr height="20"></tr>
		<tr><td colspan="2" bgcolor="#3f7c98"><center><font color="#ffffff">FileUpload Applet</font></center></td></tr>
		<tr><td colspan="2" align="center">

<applet code="proj1/wjhk.jupload2.JUploadApplet" name="JUpload" archive="porj1/wjhk.jar" mayscript="" height="300" width="640">
    <param name="CODE" value="wjhk.jupload2.JUploadApplet">
    <param name="ARCHIVE" value="wjhk.jupload.jar">
    <param name="type" value="application/x-java-applet;version=1.4">
    <param name="scriptable" value="false">    
    <param name="postURL"
    value="http://um13.cs.ualberta.ca:16410/proj1/parseRequest.jsp?URLParam=URL+Parameter+Value">
    <param name="nbFilesPerRequest" value="2">    
Java 1.4 or higher plugin required.
</applet>

			</td>
		</tr>
        </tbody></table>
    </body>

    </html>