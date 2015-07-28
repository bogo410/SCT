<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<% 	
	
	String matricola = "";
	String autoSelezionata = "";
	if( session.getAttribute("utenteAttivo") == null || session.getAttribute("utenteAttivo").equals("") ){
		response.sendRedirect("loginAtteso.jsp");
	}else{
		matricola = session.getAttribute("utenteAttivo").toString();
		autoSelezionata = request.getParameter( "auto" );
		if( !((Auto.getRuoloUtente(matricola).equals("Admin")) || (Auto.getRuoloUtente(matricola).equals("Admin Esterno"))) && !matricola.equals(Dipendente.getResponsabile(autoSelezionata))){
			response.sendRedirect("permessoNegato.jsp");
		}
	}
		%>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<link rel="stylesheet" href="resources/style.css" type="text/css">
<title>Tracking</title>

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
			<form action="logout.jsp">
				<input type="submit" value="Logout <%=matricola%>">
			</form> 
		</div>
	</div>
    <div id="content">
        
				<body>
					<h2> Tracking Auto :  <%=autoSelezionata%></h2>
					<%	
					//auto refresh dopo 1 seconds
					response.setIntHeader("Refresh", 1);
					
					List<Posizione> listaPosizioni = Posizione.getListaPosizioni(autoSelezionata);
					int i=0;
					for(Posizione pos : listaPosizioni) {
						if(i++==0){			
							%>
							&nbsp;&nbsp;&nbsp; Latitudine: <%=pos.getLatitudine() %>&nbsp; Longitudine: <%=pos.getLongitudine() %>&nbsp; Data: <%=pos.getData() %>&nbsp; Ora: <%=pos.getOra() %> &nbsp; <==ATTUALE 
							<br>
							<br>
					<%
						}else{
							%>
						&nbsp;&nbsp;&nbsp; Latitudine: <%=pos.getLatitudine() %>&nbsp; Longitudine: <%=pos.getLongitudine() %>&nbsp; Data: <%=pos.getData() %>&nbsp; Ora: <%=pos.getOra() %>
						<br>
						<br>
					<%
						}
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