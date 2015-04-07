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
		<a href="register.jsp">Registration</a>
		<a id="currenttab" href="upload.jsp">Upload</a>
		<a href="view_users.jsp">View By Users</a>
		<a href="view_photos.jsp">View By Photos</a>
		<a href="view_tags.jsp">View By Tags</a>
	</div>
	<%
		String author = request.getParameter("author");
		String title = request.getParameter("title");
		String year = request.getParameter("year");
		if (author != null && title != null && year != null) {
			out.print("test");
			/*int uid = 2;
			String username = "test";
			String email = "123";
			String password = "4343";
			System.out.println("FK U");
			System.out.println("INSERT INTO user VALUES (" + String.valueOf(uid) + ", '" + username + "', '" + email + "', '" + password + "');");*/
			//com.lsphate.PhotosWorker.Insert(author, title, year, remark);
		}
	%>
	<br>
	<form action="upload.jsp" method="post">
		<table>
			<tr>
				<td>Author</td>
				<td><input type="text" name="author"></td>
			</tr>
			<tr>
				<td>Title</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>Year</td>
				<td><input type="text" name="year"></td>
			</tr>
		</table>

		<br> <input type="submit" value="submit">
	</form>
</body>
</html>