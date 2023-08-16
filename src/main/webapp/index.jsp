<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Index Page </title>
</head>
<table border="0">
<tr>
<td>
<img src="./images/tomcat.gif">
</td>
<td>
<h1>Sample "Hello, World" Application</h1>
<p>This is the home page for a sample application used to illustrate the
source directory organization of a web application utilizing the principles
outlined in the Application Developer's Guide.
</td>
</tr>
</table>
<%
	Date date = new Date();
	out.print("<h2>" +date.toString()+"</h2>");
%>
<body>
<h2>Request Information</h2>

Client IP: <%= request.getRemoteAddr() %> <br>
HTTP Method: <%= request.getMethod() %> <br>

<h2>Response Information</h2>
Session ID: <%= session.getId() %> <br>
Session timeout: <%= session.getMaxInactiveInterval() %> <br>

<h2>Server Information</h2>
Server Info: <%=application.getServerInfo() %> <br>

<h3>Link1 : <a href="https://testdomainname.info"> Gitlab(testdomainame) </a> </h3><br>
<h3>Link2 : <a href="https://testdomainnames2.com"> Jenkins(testdomainnames2) </a> </h3>
<b> webhook test </b>

</body>
</html>
