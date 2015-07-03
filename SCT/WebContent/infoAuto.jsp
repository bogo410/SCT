<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<%
	String matricola = "";
	String targa = "";
	String matricolaResp = "";
	String modello = "";
	String latitudine = "";
	String longitudine = "";
	String modalita = "";
	String velocita = "";
	if( session.getAttribute("utenteAttivo") == null || session.getAttribute("utenteAttivo").equals("")){
		response.sendRedirect("loginAtteso.jsp");
	}else{
		matricola = session.getAttribute("utenteAttivo").toString();
		targa = request.getParameter( "targa" );
		matricolaResp = request.getParameter( "codResp" );
		modello = request.getParameter( "mod" );
		latitudine = request.getParameter( "lat" );
		longitudine = request.getParameter( "long" );
		modalita = request.getParameter( "modal" );
		velocita = request.getParameter( "vel" );
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
		<div id="Logout">
		<form method="link" action="logout.jsp">
			<input type="submit" value="Logout <%=matricola%>">
		</form> 
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
						<td> <a href="infoAuto.jsp?targa=<%=a.getTarga()%>&codResp=<%=a.getCodResponsabile()%>&mod=<%=a.getModello()%>&lat=<%=a.getLatitudine()%>&long=<%=a.getLongitudine()%>&modal=<%=a.getModalita()%>&vel=<%=a.getVelocita()%>"> <%=a.getTarga()%> </a></td>
						<td> <a href="infoDip.jsp"> <%=a.getCodResponsabile()%></a></td>
					
				</tr>
				<%
				}
	}//qui chiudo l'if iniziale per il controllo sessione del responsabile
			%>
			</table>
		
		
        </div>
        
        <div id="main">
            <body>
				<br>
	    			<h2>Informazioni Auto </h2>
	    			<h3>Targa: <%=targa%>, Responsabile: <%=matricolaResp%></h3>
				<br>
				<br>
	    		Modello :	<%=modello%>
	    		<br>
	    		<br>
  				Latitudine :	<%=latitudine%>
  				<br>
  				<br>
  				Longitudine :	<%=longitudine%>
  				<br>
  				<br>
  				Modalita :	<%=modalita%>
  				<br>
  				<br>
  				Velocita :	<%=velocita%>
  				<br>
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