<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Hello</title>
</head>
<body style = "text-align:center">
	<h1 style = "color:green;">List student</h1>
	<font><b>
		<table BORDER="2" align = center>
		<tr style ="backround-color: LightGray;">
			<th>First name</th><th>Last name</th>
		</tr>
		<%
		final String[][] name = {{"Huynh", "Man"}, {"Chim", "Se"}};  
        for (int i = 0; i < name.length; i++) {  
            out.println("<tr>");
            out.print("<td>&nbsp;" + name[i][0] + "&nbsp;</td>");
            out.print("<td>&nbsp;" + name[i][1] + "&nbsp;</td>");
            out.println("</tr>");
        }
		%>
		</table>
	</b></font>
</body>
</html>