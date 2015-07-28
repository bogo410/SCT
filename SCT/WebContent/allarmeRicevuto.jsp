<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<% 	
	
	String matricola = "";
	String autoSelezionata = "";
	String modalita = "";
	String targa = "";
	if( session.getAttribute("utenteAttivo") == null || session.getAttribute("utenteAttivo").equals("") ){
		response.sendRedirect("loginAtteso.jsp");
	}else{
		matricola = session.getAttribute("utenteAttivo").toString();
		autoSelezionata = request.getParameter( "auto" );
		if( !((Auto.getRuoloUtente(matricola).equals("Admin")) || (Auto.getRuoloUtente(matricola).equals("Admin Esterno"))) && !matricola.equals(Dipendente.getResponsabile(autoSelezionata))){
			response.sendRedirect("permessoNegato.jsp");
		}
		modalita = request.getParameter( "modal" );
		targa = request.getParameter( "auto" );
	}
		%>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<link rel="stylesheet" href="resources/style.css" type="text/css">
<title>Numeri di Emergenza</title>

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
					<%
						Auto a = Auto.getAuto(targa);
						a.updateModalita("Alarm received");
					%>
					
					<h2>E' stata impostata la modalit� "Alarm received" </h2>
					<h2> Numeri di Emergenza </h2>
					<h3>Per assistenza immediata in Italia chiamare:</h3> 
					<h3>- Carabinieri : 112</h3> 
					<h3>- Polizia : 113 </h3>
					<h3>- Vigili del fuoco : 115  </h3> 
					<br>
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