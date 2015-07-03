<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<%
	String matricola = "";
	if( session.getAttribute("utenteAttivo") == null || session.getAttribute("utenteAttivo").equals("")){
		response.sendRedirect("loginAtteso.jsp");
	}else{
		matricola = session.getAttribute("utenteAttivo").toString();
	}
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
			<%
				//se l'utente è un admin ritorna alla home dell'admin
				//altrimenti ritorna alla home del responsabile
				if( (Auto.getRuoloUtente(matricola)).equals("Responsabile Auto") ){ 
					
					%>
					<a href="respAutoHome.jsp"> SafeCar</a>
			<%	
				}else if((Auto.getRuoloUtente(matricola)).equals("Admin") || (Auto.getRuoloUtente(matricola)).equals("Admin Esterno")){
					%>
					<a href="adminHome.jsp"> SafeCar</a>
			<%	
				}
			%>
		</div>
	</div>
    <div id="Logout">
		<form method="link" action="logout.jsp">
			<input type="submit" value="Logout <%=matricola%>">
		</form> 
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
            <body>
				<br>
	    			<h2>Benvenuto nella Admin Home <%=matricola%></h2>
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