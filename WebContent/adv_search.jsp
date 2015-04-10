<%@ page import="com.lsphate.PhotosWorker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Photo Database</title>
<link rel="stylesheet" href="style.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
	<h1>Welcome to the Photo Database!</h1>
	<br>
	<div class="navigator">
		<a href="register.jsp">Registration</a>
		<a href="upload.jsp">Upload</a>
		<a href="view_users.jsp">View By Users</a>
		<a href="view_photos.jsp">View By Photos</a>
		<a href="view_tags.jsp">View By Tags</a>
		<a href="view_devices.jsp">View By Devices</a>
		<a id="currenttab" href="adv_search.jsp">Advanced Search</a>
	</div>
	<form action="adv_search.jsp" method="post">
		<h3>Input keywords to search:</h3>
		<table>
			<tr>
				<td>
					<input type="text" name="username">
					<input type="submit" value="search">
				</td>
			</tr>
		</table>
		<br>
		<table>
			<%
				String search = request.getParameter("username");
				if (search != null) {
					out.print("<h3>Search Result : </h3>");
				}
			%>
		</table>
		<table>
			<%
				if (search != null) {
					List<String> list = PhotosWorker.AdvSearchUser(search);
					if (list.size() != 1) {
						Iterator<String> it = list.iterator();
						out.print((list.size() - 1) / 4 + " result(s) " + it.next());
						out.print("<tr><th>uid</th><th>display_name</th><th>username</th><th>password</th>");
						while (it.hasNext()) {
							out.print("<tr>");
							for (int i = 0; i < 4; i++) {
								out.print("<td>");
								out.print(it.next());
								out.print("</td>");
							}
							out.print("</tr>");
						}
					}
				}
			%>
		</table>
		<table>
			<%
				if (search != null) {
					List<String> list = PhotosWorker.AdvSearchPhoto(search);
					if (list.size() != 1) {
						Iterator<String> it = list.iterator();
						out.print((list.size() - 1) / 3 + " result(s) " + it.next());
						out.print("<tr><th>pid</th><th>photo_name</th><th>views</th>");
						while (it.hasNext()) {
							out.print("<tr>");
							for (int i = 0; i < 3; i++) {
								out.print("<td>");
								out.print(it.next());
								out.print("</td>");
							}
							out.print("</tr>");
						}
					}
				}
				out.print("<br>");
			%>
		</table>
		<table>
			<%
				if (search != null) {
					List<String> list = PhotosWorker.AdvSearchAlbum(search);
					if (list.size() != 1) {
						Iterator<String> it = list.iterator();
						out.print((list.size() - 1) / 2 + " result(s) " + it.next());
						out.print("<tr><th>album_name</th><th>views</th>");
						while (it.hasNext()) {
							out.print("<tr>");
							for (int i = 0; i < 2; i++) {
								out.print("<td>");
								out.print(it.next());
								out.print("</td>");
							}
							out.print("</tr>");
						}
					}
				}
				out.print("<br>");
			%>
		</table>
		<table>
			<%
				if (search != null) {
					List<String> list = PhotosWorker.AdvSearchDevice(search);
					if (list.size() != 1) {
						Iterator<String> it = list.iterator();
						out.print((list.size() - 1) / 2 + " result(s) " + it.next());
						out.print("<tr><th>device_name</th><th>maker</th>");
						while (it.hasNext()) {
							out.print("<tr>");
							for (int i = 0; i < 2; i++) {
								out.print("<td>");
								out.print(it.next());
								out.print("</td>");
							}
							out.print("</tr>");
						}
					}
				}
				out.print("<br>");
			%>
		</table>
	</form>
</body>
</html>