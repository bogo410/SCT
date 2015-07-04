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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tracking</title>
</head>
<body>
	<h3> Tracking Auto :  <%=autoSelezionata%></h3>
	<%	
	List<Posizione> listaPosizioni = Posizione.getListaPosizioni(autoSelezionata);
	for(Posizione pos : listaPosizioni) {
					
			%>
	Latitudine: <%=pos.getLatitudine() %> Longitudine: <%=pos.getLongitudine() %> Data: <%=pos.getData() %> Ora: <%=pos.getOra() %>
	<br>
	<br>
	<%
	}
		%>
</body>
</html>