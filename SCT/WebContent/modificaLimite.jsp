<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<% 	
	
	String matricola = "";
	String autoSelezionata = "";
	String targa = "";
	String nuovoLimite = "";
	String i = "";
	if( session.getAttribute("utenteAttivo") == null || session.getAttribute("utenteAttivo").equals("") ){
		response.sendRedirect("loginAtteso.jsp");
	}else{
		matricola = session.getAttribute("utenteAttivo").toString();
		autoSelezionata = request.getParameter( "auto" );
		if( !((Auto.getRuoloUtente(matricola).equals("Admin")) || (Auto.getRuoloUtente(matricola).equals("Admin Esterno"))) && !matricola.equals(Dipendente.getResponsabile(autoSelezionata))){
			response.sendRedirect("permessoNegato.jsp");
		}
	}
	targa = request.getParameter( "auto" );
	i = request.getParameter( "j" );

		%>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<link rel="stylesheet" href="resources/style.css" type="text/css">
<title>Modifica Limite di Velocit�</title>

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
					<h2> Modifica limite Auto :  <%=autoSelezionata%></h2>
					<%	
					
					Auto a = Auto.getAuto(targa);
							%>
							<br>
							<form action="modificaLimite.jsp?auto=<%=targa%>&j=ok" method=POST>
								&nbsp;&nbsp;&nbsp; Nuovo limite: <input type="text" name="nuovoLimite" placeholder="Inserire nuovo limite">
								<%
								
								if(i.equals("ok")){
									%>
								&nbsp;&nbsp;&nbsp; <input type=submit value="Salva">
								<%
								//se il nuovo limite � maggiore o uguale a 0
								if( (nuovoLimite = request.getParameter("nuovoLimite")) != "" && (Integer.parseInt(nuovoLimite) >= 0) ){
									a.setLimite( Integer.parseInt(nuovoLimite) );
									a.updateLimite( Integer.parseInt(nuovoLimite) );
									
								}else {
								%>
								<br>
								<br>
								&nbsp;&nbsp;&nbsp;&nbsp;Inserire un limite di velocit� valido! (>=0)
								<%
								}
								}else{
								%>
								&nbsp;&nbsp;&nbsp; <input type=submit value="Salva">
								<%
								}
								%>
								<br>
								<br>
								<h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Limite attuale: <%=a.getLimite()%> km/h</h3>
							</form>
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