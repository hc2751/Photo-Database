<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- This import is necessary for JDBC -->
<%@ page import="java.sql.*"%>
<!-- Database connection and query -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Photo Database</title>
<link rel="stylesheet" href="style.css" type="text/css">
</head>

<body>
	<br>
	<div class="navigator">
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