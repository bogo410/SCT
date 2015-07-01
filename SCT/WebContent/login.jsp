<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SafeCar Login</title>
</head>

<body>
	<h1>SafeCar</h1>
	<br>
	<h2>LOGIN</h2>
	<form action="Login" method="POST">
		<br /> Matricola: <input type="text" name="matricola" required placeholder="Inserire matricola"> <br> 
		<br /> Password: <input type="password" name="password" required placeholder="Inserire password"> <br>
		<br /> <input type="submit" value="Log in">
	</form>
</body>
</html>