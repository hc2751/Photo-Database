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
		<a id="currenttab" href="view_tags.jsp">View By Tags</a>
		<a href="view_devices.jsp">View By Devices</a>
		<a href="adv_search.jsp">Advanced Search</a>
	</div>
	<form action="view_tags.jsp" method="post">
		<h3>Select the tag(s) you'd like to lookup:</h3>
		<select name="tag" multiple size="10">
			<%
				List<String> list = PhotosWorker.GetTags();
				Iterator<String> it = list.iterator();
				while (it.hasNext()) {
					out.print("<option>");
					out.print(it.next());
					out.print("</option>");
				}
			%>
		</select>
		<br>
		<br>
		<input type="submit" value="submit">
	</form>
	<br>
	<br>
	<form>
		<%
			String tags[] = request.getParameterValues("tag");
			if (tags != null) {
				out.print("<h3>Your selection(s):</h3>");
				for (int i = 0; i < tags.length; i++) {
					out.print("<li>" + tags[i] + "</li>");
				}
			}
		%>
		<br>
		<table>
		<%
			if(tags != null) {
				List<String> taglist = PhotosWorker.GetTagsTable(tags);
				Iterator<String> tagit = taglist.iterator();
				if (taglist.isEmpty() == false) {
					out.print("<tr><th>Tag</th><th>Photo name</th><th>Views</th>");
					while(tagit.hasNext()) {
						out.print("<tr>");
						for (int i = 0; i < 3; i++) {
							out.print("<td>");
							out.print(tagit.next());
							out.print("</td>");
						}
						out.print("</tr>");
					}
				} else {
					out.print("<h3>No results.</h3>");
				}
			}
		%>
		</table>
	</form>
</body>
</html>
