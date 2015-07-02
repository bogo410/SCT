<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<%
String matricola = "";
matricola = session.getAttribute("utenteAttivo").toString();
/*matricolaResp = session.getAttribute("codResp").toString();
targa = session.getAttribute("targa").toString();*/
String targa = request.getParameter( "targa" ); 
String matricolaResp = request.getParameter( "codResp" );
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
    <div id="header">
		<div id="header-content">
			SafeCar
		</div>
		<div id="Logout">
		<a href="logout.jsp"><%=matricola%>:logout</a>
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
				//se l'utente è un admin la query restituisce l'intera lista delle auto
				//altrimenti restituisce solo le proprie auto
				List<Auto> listaAuto = null;
				if( (Auto.getRuoloUtente(matricola)).equals("Responsabile Auto") ){ listaAuto = Auto.getAutoDip(matricola);
				}else if((Auto.getRuoloUtente(matricola)).equals("Admin") || (Auto.getRuoloUtente(matricola)).equals("Admin Esterno")){
					listaAuto = Auto.getListaAuto();
				}
			%>
			<%	
				for (Auto a : listaAuto) {
			%>

				<tr>
						<td> <a href="infoAuto.jsp?targa=<%=a.getTarga()%>&codResp=<%=a.getCodResponsabile()%>"> <%=a.getTarga()%> </a></td>
						<td> <a href="infoDip.jsp"> <%=a.getCodResponsabile()%></a></td>
					
				</tr>
				<%
				}
			%>
			</table>
		
		
        </div>
        
        <div id="main">
            <body>
				<br>
	    			<h2>Informazioni Auto Targa: <%=targa%>, Responsabile: <%=matricolaResp%></h2>
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