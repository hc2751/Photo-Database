<%@ page import="com.lsphate.PhotosWorker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.Part"%>

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
		<a id="currenttab" href="upload.jsp">Upload</a>
		<a href="view_users.jsp">View By Users</a>
		<a href="view_photos.jsp">View By Photos</a>
		<a href="view_tags.jsp">View By Tags</a>
	</div>
	<form action="upload.jsp" method="post">
		<h3>Upload a new photo:</h3>
        <table border="0">
        	<tr>
            	<td>Email:</td>
                <td><input type="text" name="email" size="34"></td>
            </tr>
            <tr>
            	<td>Password:</td>
                <td><input type="password" name="password" size="34"></td>
            </tr>
            <!-- <tr>
            	<td>Tags:</td>
                <td><input type="text" name="tags" size="34"></td>
            </tr> -->
            <tr>
                <td colspan="2">
                	<input type="file" name="photo">
                	<input type="submit" value="upload">
                </td>
            </tr>
        </table>
    </form>
    <br>
    <br>
    <form>
        <%
        	String email = request.getParameter("email");
        	String password = request.getParameter("password");
        	if (PhotosWorker.IsAuthorized(email, password) == true) {
        		Random rand = new Random();
           		int views = rand.nextInt(30) + 1;
           		String tags = ""/* request.getParameter("tags") */;
           		String filename = request.getParameter("photo");
           		PhotosWorker.InsertPhoto(email, filename, views, tags);
       		}
        %>
    </form>
</body>
</html>