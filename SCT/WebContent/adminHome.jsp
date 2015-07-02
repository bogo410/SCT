<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="login.*" import="java.util.*"
	import="java.sql.*"%>
<%
String matricola = "";
matricola = session.getAttribute("utenteAttivo").toString();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home Admin</title>
</head>
<link rel="stylesheet" href="resources/style.css" type="text/css">

<title>Home Admin</title>

<div id="wrapper">
	<div id="header">
		<div id="header-content">
			SafeCar
		</div>
		<div id="Logout">
			<a href="logout.jsp"><%=matricola%>, effettua il logout</a>
		</div>
	</div>
	<div id="content">
		<div id="sidebar">
			<div id="sideHead">Parco Auto</div>
			<br>
			<table id="sideTable">
				<tr>
					<th>Targa</th>
					<th>Responsabile</th>

				</tr>

				<%
				List<Auto> listaAuto = Auto.getListaAuto();
			%>
				<%
				for (Auto a : listaAuto) {
			%>

				<tr>
					<td><%=a.getTarga()%></td>
					<td><%=a.getCodResponsabile()%></td>

				</tr>
				<%
				}
			%>
			</table>


		</div>

		<div id="main">
				<br>
				<h2>
					Benvenuto nella Admin Home
					<%=matricola%></h2>
				<br></br>
		</div>
	</div>
	<div class="push">
	</div>
</div>
<div id="footer">
	<div id="footer-content">
		

		
	</div>
</div>

</html>