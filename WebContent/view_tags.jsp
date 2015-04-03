<%@page import="com.lsphate.PhotosWorker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Photo Database</title>
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
	<br>
	<div class="navigator">
		<a href="upload.jsp">Upload</a> <a href="view_users.jsp">View By
			Users</a> <a href="view_photos.jsp">View By Photos</a> <a id="currenttab"
			href="view_tags.jsp">View By Tags</a>
	</div>
	<br>
	<form>
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
		</select> <br> <br> <input type="submit" value="submit">
	</form>
	<br>
	<br>
	<form>
		<%
			String tags[] = request.getParameterValues("tag");
			if (tags != null) {
				out.print("You've selected the following tags:");
				for (int i = 0; i < tags.length; i++) {
					out.print("<li>" + tags[i] + "</li>");
				}
			}
		%>
	</form>
</body>
</html>