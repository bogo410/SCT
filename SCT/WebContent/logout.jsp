<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logout</title>
</head>
<body>
	<h1>SafeCar</h1>
	<br>
	<h3>Hai effettuato il logout</h3>
	<%
		session.invalidate();
	%>
	<form action="login.jsp">
		<input type="submit" value="Torna al Login">
	</form> 
</body>
</html>