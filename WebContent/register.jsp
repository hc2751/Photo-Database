<%@ page import="com.lsphate.PhotosWorker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Photo Database</title>
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
	<h1>Welcome to the Photo Database!</h1>
	<br>
	<div class="navigator">
		<a id="currenttab" href="register.jsp">Registration</a>
		<a href="upload.jsp">Upload</a>
		<a href="view_users.jsp">View By Users</a>
		<a href="view_photos.jsp">View By Photos</a>
		<a href="view_tags.jsp">View By Tags</a>
	</div>
	<form action="register.jsp" method="post">
		<h3>Register a new user:</h3>
		<table>
			<tr>
				<td>Nickname:</td>
				<td><input type="text" name="username"></td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="password"></td>
			</tr>
		</table>
		<br> <input type="submit" value="submit">
		<%
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			if (username != null && email != null && password != null) PhotosWorker.NewUsers(username, email, password);
		%>
	</form>
</body>
</html>
