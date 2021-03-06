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
		<a id="currenttab" href="view_photos.jsp">View By Photos</a>
		<a href="view_tags.jsp">View By Tags</a>
		<a href="view_devices.jsp">View By Devices</a>
		<a href="adv_search.jsp">Advanced Search</a>
	</div>
	<form action="view_photos.jsp" method="post">
		<h3>Select view preferences:</h3>
		<table rules="none">
		<tr>
			<td>
				Include EXIF:
				<input type="radio" name="withExif" value="true"> True
				<input type="radio" name="withExif" value="false"> False
			</td>
			<td>
				Include Devices:
				<input type="radio" name="withDevices" value="true"> True
				<input type="radio" name="withDevices" value="false"> False
			</td>
		</tr>
		</table>
		<br>
		<input type="submit" value="submit">
	</form>
	<br>
	<br>
	<form>
		<table>
			<%
				String withExif = request.getParameter("withExif");
				String withDevices = request.getParameter("withDevices");
				int type = 0;

				if (withExif != null && withDevices != null) {
					if (withExif.equals("false") && withDevices.equals("false")) {
						type = 1;
						out.print("<tr><th>Photo name</th><th>Views</th>");
						List<String> list = PhotosWorker.GetPhotos(type);
						Iterator<String> it = list.iterator();
						while (it.hasNext()) {
							out.print("<tr>");
							for (int i = 0; i < 2; i++) {
								out.print("<td>");
								out.print(it.next());
								out.print("</td>");
							}
							out.print("</tr>");
						}
					} else if (withExif.equals("true")
							&& withDevices.equals("false")) {
						type = 2;
						out.print("<tr><th>Photo name</th><th>Views</th><th>Shutter</th><th>Aperture</th><th>Focal length</th><th>ISO</th><th>Date</th><th>Flash</th><th>Size</th>");
						List<String> list = PhotosWorker.GetPhotos(type);
						Iterator<String> it = list.iterator();
						while (it.hasNext()) {
							out.print("<tr>");
							for (int i = 0; i < 9; i++) {
								out.print("<td>");
								out.print(it.next());
								out.print("</td>");
							}
							out.print("</tr>");
						}
					} else if (withExif.equals("false")
							&& withDevices.equals("true")) {
						type = 3;
						out.print("<tr><th>Photo name</th><th>Views</th><th>Device</th><th>Lences</th></tr>");
						List<String> list = PhotosWorker.GetPhotos(type);
						Iterator<String> it = list.iterator();
						while (it.hasNext()) {
							out.print("<tr>");
							for (int i = 0; i < 4; i++) {
								out.print("<td>");
								out.print(it.next());
								out.print("</td>");
							}
							out.print("</tr>");
						}
					} else if (withExif.equals("true")
							&& withDevices.equals("true")) {
						type = 4;
						out.print("<tr><th>Photo name</th><th>Views</th><th>Shutter</th><th>Aperture</th><th>Focal length</th><th>ISO</th><th>Date</th><th>Flash</th><th>Size</th><th>Device</th><th>Lences</th></tr>");
						List<String> list = PhotosWorker.GetPhotos(type);
						Iterator<String> it = list.iterator();
						while (it.hasNext()) {
							out.print("<tr>");
							for (int i = 0; i < 11; i++) {
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
	</form>
</body>
</html>