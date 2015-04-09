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
		<a href="upload.jsp">Upload</a>
		<a id="currenttab" href="view_users.jsp">View By Users</a>
		<a href="view_photos.jsp">View By Photos</a>
		<a href="view_tags.jsp">View By Tags</a>
		<a href="view_devices.jsp">View By Devices</a>
		<a href="adv_search.jsp">Advanced Search</a>
	</div>
	<form action="view_users.jsp" method="post">
		<h3>Choose an user:</h3>
		<table>
			<%
				List<String> list = PhotosWorker.GetUsers();
				Iterator<String> it = list.iterator();
				while (it.hasNext()) {
					out.print("<td><input type=\"submit\" name=\"user\" value=\"");
					out.print(it.next());
					out.print("\"></td>");
				}
			%>
		</table>
	</form>
	<br>
	<br>
	<form>
		<table>
			<%
				String u = request.getParameter("user");
				if (u != null) {
					out.print("<h3>" + u + "'s Albums:</h3>");
					out.print("<tr><th>Album name</th><th>Views</th><th>Date</th><th>Number of Photos</th>");
					List<String> aList = PhotosWorker.GetUserAlbums(u);
					Iterator<String> ait = aList.iterator();
					while (ait.hasNext()) {
						out.print("<tr>");
						for (int i = 0; i < 4; i++) {
							out.print("<td>");
							out.print(ait.next());
							out.print("</td>");
						}
						out.print("</tr>");
					}
				}
			%>
		</table>
		<br>
		<table>
			<%
				if (u != null) {
					out.print("<h3>" + u + "'s Photos:</h3>");
					out.print("<tr><th>Photo name</th><th>Views</th><th>Date</th><th>Album</th>");
					List<String> pList = PhotosWorker.GetUserPhotos(u);
					Iterator<String> pit = pList.iterator();
					while (pit.hasNext()) {
						out.print("<tr>");
						for (int i = 0; i < 4; i++) {
							out.print("<td>");
							out.print(pit.next());
							out.print("</td>");
						}
						out.print("</tr>");
					}
				}
			%>
		</table>
	</form>
</body>
</html>