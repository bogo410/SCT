<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<%
String matricola = "";
String matricolaResp = "";
String targa = "";
matricola = session.getAttribute("utenteAttivo").toString();
matricolaResp = session.getAttribute("utenteAttivo").toString();
targa = session.getAttribute("utenteAttivo").toString();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Informazioni Auto</title>
</head>
	<link rel="stylesheet" href="resources/style.css" type="text/css">

<title>Informazioni Auto</title>

<div id="wrapper">
    <div id="header"><div id="header-content">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SafeCar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=matricola%></div></div>
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
            <body>
				<br>
	    			<h2>Informazioni Auto Targa:<%=targa%> Responsabile:<%=matricolaResp%></h2>
				</br>
	    		
    		</body>
        </div>
    </div>
    <div class="push"></div>
</div>
<div id="footer">
	<div id="footer-content">
		Authors: A.Bogoni, F.Onori, C.Capasso, S.Spellini
    </div>
</div>

</html>