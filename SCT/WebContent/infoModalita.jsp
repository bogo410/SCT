<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<% 	
	
	String matricola = "";
	String autoSelezionata = "";
	String targa = "";
	String modalita = "";
	if( session.getAttribute("utenteAttivo") == null || session.getAttribute("utenteAttivo").equals("") ){
		response.sendRedirect("loginAtteso.jsp");
	}else{
		matricola = session.getAttribute("utenteAttivo").toString();
		autoSelezionata = request.getParameter( "auto" );
		if( !((Auto.getRuoloUtente(matricola).equals("Admin")) || (Auto.getRuoloUtente(matricola).equals("Admin Esterno"))) && !matricola.equals(Dipendente.getResponsabile(autoSelezionata))){
			response.sendRedirect("permessoNegato.jsp");
		}
		targa = request.getParameter( "auto" );
		modalita = request.getParameter( "modal" );
	}
		%>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<link rel="stylesheet" href="resources/style.css" type="text/css">
<title>Informazioni Modalit�</title>

<div id="wrapper">
    <div id="header">
		<div id="header-content">
			<%
				//se l'utente � un admin ritorna alla home dell'admin
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
			<form action="logout.jsp">
				<input type="submit" value="Logout <%=matricola%>">
			</form> 
		</div>
	</div>
    <div id="content">
        
				<body>
					<h2> Informazioni Modalit� dell'Auto:  <%=autoSelezionata%></h2>
					<h3> Modalit� attuale: <%=modalita%></h3>
					<br>
					<%
						//se la modalit� � "Sending alarm" appare il men� di gestione dell'allarme specifico
						if(modalita.equals("Sending alarm")){
							//se l'utente logato � un admin
							if( (Auto.getRuoloUtente(matricola).equals("Admin"))){
					%>
					<h4> Gestione allarme: </h4>
					 &nbsp;&nbsp;&nbsp; - <a href="contattiResp.jsp?auto=<%=targa%>"> Contatta il Responsabile</a>
					<br>
					<%	
						}else{ //se l'utente � un responsabile
					%>
					 &nbsp;&nbsp;&nbsp; - <a href="contattiAdmin.jsp?auto=<%=targa%>"> Contatta l'Admin</a>
					 <br>
					<%	
						}
					%>
					 &nbsp;&nbsp;&nbsp; - <a href="allarmeRicevuto.jsp?auto=<%=targa%>"> Contatta le Autorit� e imposta la modalit� "Alarm received"</a>					
					<br>
					 &nbsp;&nbsp;&nbsp; - <a href="modSafe.jsp?auto=<%=targa%>"> Reimposta la modalit� "Safe"</a>
					<%	
						}
					%>
					
					<%
						//se la modalit� � "Alarm received" appare il men� di gestione dell'allarme specifico
						if(modalita.equals("Alarm received")){//se l'utente logato � un admin
							if( (Auto.getRuoloUtente(matricola).equals("Admin"))){
					%>
					<h4> Gestione allarme: </h4>
					 &nbsp;&nbsp;&nbsp; - <a href="contattiResp.jsp?auto=<%=targa%>"> Contatta il Responsabile</a>
					<br>
					<%	
						}else{ //se l'utente � un responsabile
					%>
					 &nbsp;&nbsp;&nbsp; - <a href="contattiAdmin.jsp?auto=<%=targa%>"> Contatta l'Admin</a>
					 <br>
					<%	
						}
					%>
					 &nbsp;&nbsp;&nbsp; - <a href="modSafe.jsp?auto=<%=targa%>"> Reimposta la modalit� "Safe"</a>
					<br>
					<%	
						}
					%>
				</body>	
    
    </div>
    <div class="push"></div>
</div>
<div id="footer">
	<div id="footer-content">
		Authors: A.Bogoni, F.Onori, C.Capasso, S.Spellini
    </div>
</div>
</html>