<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="login.*" import="relazioni.*"
	import="java.util.*" import="java.sql.*"%>
<%
	String matricola = "";
	String targa = "";
	String matricolaResp = "";
	String modello = "";
	float latitudine = 0;
	float longitudine = 0;
	String modalita = "";
	float velocita = 0;
	float limite = 0;
	if( session.getAttribute("utenteAttivo") == null || session.getAttribute("utenteAttivo").equals("")){
		response.sendRedirect("loginAtteso.jsp");
	}else{
		matricola = session.getAttribute("utenteAttivo").toString();
		matricolaResp = request.getParameter( "codResp" );
		//se l'utente attivo non è un admin e non corrisponde al responsabile dell'auto selezionat ritorna errore 
		if( (!((Auto.getRuoloUtente(matricola).equals("Admin")) || (Auto.getRuoloUtente(matricola).equals("Admin Esterno")))) && !matricola.equals(matricolaResp) ){
			response.sendRedirect("permessoNegato.jsp");
		}
		targa = request.getParameter( "targa" );
		modello = request.getParameter( "mod" );
		modalita = request.getParameter( "modal" );
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Informazioni Auto</title>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
    <script>
var geocoder;
var map;
var infowindow = new google.maps.InfoWindow();
var marker;
function initialize() {
  geocoder = new google.maps.Geocoder();

  var lat = parseFloat(document.getElementById('hiddenLat').value);
  var lng = parseFloat(document.getElementById('hiddenLong').value);
  var latlng = new google.maps.LatLng(lat, lng);
  var mapOptions = {
    zoom: 8,
    center: latlng,
    mapTypeId: 'roadmap'
  }
  map = new google.maps.Map(document.getElementById('map-view'), mapOptions);

  codeLatLng();
}

function codeLatLng() {
	  var lat = parseFloat(document.getElementById('hiddenLat').value);
	  var lng = parseFloat(document.getElementById('hiddenLong').value);
	  var latlng = new google.maps.LatLng(lat, lng);
	  geocoder.geocode({'latLng': latlng}, function(results, status) {
	    if (status == google.maps.GeocoderStatus.OK) {
	      if (results[1]) {
	        map.setZoom(11);
	        marker = new google.maps.Marker({
	            position: latlng,
	            map: map
	        });
	        infowindow.setContent(results[1].formatted_address);
	        infowindow.open(map, marker);
	      } else {
	    	  window.alert("No results found");
	      }
	    } else {
	    	window.alert("Geocoder failed due to: " + status);
	    }
	  });
	}

	google.maps.event.addDomListener(window, 'load', initialize);
</script>
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
		<div id="Logout">
		<form action="logout.jsp">
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
				for(Auto a : listaAuto) {
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
						%>						<%	
							if( (Auto.getRuoloUtente(matricola)).equals("Admin") || (Auto.getRuoloUtente(matricola)).equals("Admin Esterno") ) {
						%>
						<td> <a href="infoDip.jsp?dipSel=<%=a.getCodResponsabile()%>"> <%=a.getCodResponsabile()%></a></td>
						<%	
							}else{
						%>
						<td> <a href="respAutoHome.jsp"> <%=a.getCodResponsabile()%></a></td>
						<%	
							}
						%>
				</tr>
				<%
				}
	}//qui chiudo l'if iniziale per il controllo sessione del responsabile
			%>
			</table>
		
		
        </div>
        
        <div id="main">
				<br>
	    			<h2>Informazioni Auto </h2>
	    			<h3>Targa: <%=targa%>, Responsabile: <%=matricolaResp%></h3>
				<br>
				<%		
				//auto refresh dopo 5 secondi
				response.setIntHeader("Refresh", 10);
				
				//si salva le info dell'auto in questione con la relativa posizione
				Auto a = Auto.getAuto(targa);
				Posizione p = Posizione.getPosizioneAttuale(targa);
				
				latitudine = p.getLatitudine();
				longitudine = p.getLongitudine();
				modalita = a.getModalita();
				velocita = a.getVelocita();
				limite = a.getLimite();
			%>
				<br>
	    		Modello :	<%=modello%>
  				<br>
  				<input type="hidden" name="hiddenLat" id="hiddenLat" value="<%=latitudine%>">
				<input type="hidden" name="hiddenLong" id="hiddenLong" value="<%=longitudine%>">
  				<br>
  				<%
				if( !a.getModalita().contains("Safe") ){
				%>
  				Modalita :	<a href="infoModalita.jsp?auto=<%=targa%>&modal=<%=modalita%>"> <font color="red"> <%=modalita%></font></a>
  				<%
				}else{	
  				%>
  				Modalita :	<a href="infoModalita.jsp?auto=<%=targa%>&modal=<%=modalita%>"> <%=modalita%></a>
  				<%
				}
  				%>
  				<br>
  				<br>
  				<%
				if( a.getVelocita() > a.getLimite() ){
				%>
				Velocita :	<font color="red"> <%=velocita%> km/h </font>
				<%
				}else{	
  				%>
  				Velocita :	<%=velocita%> km/h
  				<%
				}
  				%>
  				<br>
    			<br>
    			Limite di velocita impostato :	<a href="modificaLimite.jsp?auto=<%=targa%>&j=ko"><%=limite%> km/h</a>
  				<br>
    			<br>
  				<br><a href="video.jsp?auto=<%=targa%>"> Video</a>
    			<br>
  				<br>
  				<br>
    			<div id="map-view"></div>
    			<br>
    			<br>
    			<a href="tracking.jsp?auto=<%=targa%>"> Tracking</a> 
    			<br>
    			<br>
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