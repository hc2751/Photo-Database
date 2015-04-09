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
		<a href="view_users.jsp">View By Users</a>
		<a href="view_photos.jsp">View By Photos</a>
		<a href="view_tags.jsp">View By Tags</a>
		<a id="currenttab" href="view_devices.jsp">View By Devices</a>
		<a href="adv_search.jsp">Advanced Search</a>
	</div>
	<form action="view_devices.jsp" method="post">
		<h3>Choose a manufacturer:</h3>
		<table>
			<%
				List<String> list = PhotosWorker.GetMakers();
				Iterator<String> it = list.iterator();
				while (it.hasNext()) {
					out.print("<td><input type=\"submit\" name=\"maker\" value=\"");
					out.print(it.next());
					out.print("\"></td>");
				}
			%>
		</table>
	</form>
	<br>
	<form action="view_devices.jsp" method="post">
		<table>
			<%
				String m = request.getParameter("maker");
				if (m != null) {
					out.print("<h3>Products by " + m + ":</h3>");
					List<String> dlist = PhotosWorker.GetDevices(m);
					Iterator<String> dit = dlist.iterator();
					while (dit.hasNext()) {
						out.print("<td><input type=\"submit\" name=\"device\" value=\"");
						out.print(dit.next());
						out.print("\"></td>");
					}
				}
			%>
		</table>
	</form>
	<form action="view_devices.jsp" method="post">
		<table>
			<%
				String d = request.getParameter("device");
				if (d != null) {
					out.print("<h3>Photos taken by " + d + ":</h3>");
					out.print("<tr><th>Uploader</th><th>Photo name</th><th>Views</th><th>Upload date</th><th>Lenses</th>");
					List<String> plist = PhotosWorker.GetDevicePhotos(d);
					Iterator<String> pit = plist.iterator();
					while (pit.hasNext()) {
						out.print("<tr>");
						for (int i = 0; i < 5; i++) {
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