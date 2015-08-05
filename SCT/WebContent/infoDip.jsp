<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<%
	String matricola = "";
	String dipSelezionato = "";
	String nome = "";
	String cognome = "";
	String ruolo = "";
	String numTelefono = "";
	if( session.getAttribute("utenteAttivo") == null || session.getAttribute("utenteAttivo").equals("") ){
		response.sendRedirect("loginAtteso.jsp");
	}else{
		matricola = session.getAttribute("utenteAttivo").toString();
		dipSelezionato = request.getParameter( "dipSel" );
		if( !((Auto.getRuoloUtente(matricola).equals("Admin")) || (Auto.getRuoloUtente(matricola).equals("Admin Esterno"))) ){
			response.sendRedirect("permessoNegato.jsp");
		}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Informazioni Dipendente</title>
</head>
	<link rel="stylesheet" href="resources/style.css" type="text/css">

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
		<form action="logout.jsp">
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
				Dipendente dip = Dipendente.getDipendente(dipSelezionato);
			%>
				<%
				for (Auto a : listaAuto) {
					Posizione pos = Posizione.getPosizioneAttuale(a.getTarga());
			%>

				<tr>
						<%
						if(a.getModalita().contains("Alarm") || a.getModalita().contains("alarm") || a.getVelocita() > a.getLimite() ){
						%>
						<td> <a href="infoAuto.jsp?targa=<%=a.getTarga()%>&codResp=<%=a.getCodResponsabile()%>&mod=<%=a.getModello()%>&lat=<%=pos.getLatitudine()%>&long=<%=pos.getLongitudine()%>&modal=<%=a.getModalita()%>&vel=<%=a.getVelocita()%>"> <font color="red"> <%=a.getTarga()%> </font></a></td>
						
						<%
						}else{
						%>
						<td> <a href="infoAuto.jsp?targa=<%=a.getTarga()%>&codResp=<%=a.getCodResponsabile()%>&mod=<%=a.getModello()%>&lat=<%=pos.getLatitudine()%>&long=<%=pos.getLongitudine()%>&modal=<%=a.getModalita()%>&vel=<%=a.getVelocita()%>"> <%=a.getTarga()%> </a></td>
						<%
						}
						%>						<td> <a href="infoDip.jsp?dipSel=<%=a.getCodResponsabile()%>"> <%=a.getCodResponsabile()%></a></td>
					
				</tr>
				<%
				}
			%>
			</table>
		
		
        </div>
        
        <div id="main">
				<br>
	    			<h2>Informazioni Dipendente: <%=dipSelezionato%></h2>
				<br>
					<br>
					<br>
	    			Nome :	<%=dip.getNome()%>
	    			<br>
		    		<br>
	  				Cognome :	<%=dip.getCognome()%>
	  				<br>
	  				<br>
	  				Ruolo :	   <%=dip.getRuolo()%>
	  				<br>
	  				<br>
	  				Numero di Telefono :	<%=dip.getNumTelefono()%>
	  				<br>
	  				<br>
	  				e-Mail :	<%=dip.getEmail()%>
	  				<br>
        </div>
        <%
        }
	%>
    </div>
    <div class="push"></div>
</div>
<div id="footer">
	<div id="footer-content">
		Authors: A.Bogoni, F.Onori, C.Capasso, S.Spellini
    </div>
</div>

</html>