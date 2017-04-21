<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="studyR.StudySession" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
	<head>
   		<title>studyR - the study buddy maker!</title>
   		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
	</head>
	<body>
		<h1>studyR</h1>
   		<h3></h3>
   		<img src = "http://vignette2.wikia.nocookie.net/scribblenauts/images/7/7a/Tuna_Fish.png/revision/latest?cb=20130418113339" alt = "Cartuna" style = "width:250px;height:125px">
   		<i>"I went fishing this one time, and it was a tuna fun!</i>
   		<img src = "http://vignette2.wikia.nocookie.net/scribblenauts/images/7/7a/Tuna_Fish.png/revision/latest?cb=20130418113339" alt = "Cartuna" style = "width:250px;height:125px">
   		<hr>
<%
    String studyR = request.getParameter("studyR");
    if (studyR == null) {
        studyR = "default";
    }
    pageContext.setAttribute("studyR", studyR);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
%>
<%
	if (user != null) {
		%>
		<%--<p>Please include a title with your post!</p>
		<form action="/studyR" method="post">
			<b>Title:</b>
			<input type="text" name="title"><br>
			<b>Content:</b>
			<div><textarea name="content" rows="3" cols="60"></textarea></div>
			<div><input type="submit" name="button1" value="Submit Blog Post" /></div>
			<div><input type="submit" name="button4" value="Cancel Post" /></div>
			<input type="hidden" name="studyR" value="${fn:escapeXml(studyR)}"/>
		</form>--%>
		<%--<p><b>CREATE A STUDY SESSION</b><br>INSTRUCTIONS: Please provide the following information to begin your study session.</p>
		<form action="/studyR" method="post">
			<b>Title:	</b><input type="text" size="40" name="title"><br>
			<b>Start Time:	</b><input type="text" size="5" name="title">
			<b>End Time:	</b><input type="text" size="5" name="title"><br>
			<b>Location:	</b><input type="text" size="8" name="title">
			<b>Course:	</b><input type="text" size="8" name="title"><br>
			<b>Additional Notes:</b>
			<div><textarea name="content" rows="3" cols="37"></textarea></div>
			<div><input type="submit" name="button1" value="Create Study Session" />
			<input type="submit" name="button4" value="Cancel" /></div>
			<input type="hidden" name="studyR" value="${fn:escapeXml(studyR)}"/>
		</form>--%>
		<p><b>EDIT PROFILE</b><br>INSTRUCTIONS: You can update your profile information below. Please use the checkboxes to decide what information can be seen by other users.</p>
		<form action="/studyR" method="post">
			<table cellpadding="20">
				<tr>
        			<td>
        				<b>Profile Picture:	</b><br>
						<img src = "http://4.bp.blogspot.com/_Nm-0QNY7FrQ/SpOx_3FDjaI/AAAAAAAAAOM/kw-1vEea8rY/s320/tuna.jpg" alt = "sashimi" style = "width:250x;height:250px">	Public	<input type="checkbox" name="vehicle" value="Bike"><br><br>
						<input type="file" name="fileToUpload" id="fileToUpload">
						<input type="submit" value="Upload Image" name="submit">
        			</td>
        			<td>
        				<b>Name:	</b><input type="text" size="40" name="title"><br><br>
						<b>Email:	</b><input type="text" size="40" name="title">	Public	<input type="checkbox" name="vehicle" value="Bike"><br><br>
						<b>Phone Number:	</b><input type="text" size="27" name="title">	Public	<input type="checkbox" name="vehicle" value="Bike"><br><br>
						<b>Courses:	</b><input type="text" size="37" name="title">	Public	<input type="checkbox" name="vehicle" value="Bike"><br><br>
						<b>Bio:	</b>
						<div><textarea name="content" rows="6" cols="38"></textarea>	Public	<input type="checkbox" name="vehicle" value="Bike"></div><br><br>
						<div><input type="submit" name="button1" value="Save Changes" />
						<input type="submit" name="button4" value="Cancel" /></div>
        			</td>
				</tr>
			</table>
			<input type="hidden" name="studyR" value="${fn:escapeXml(studyR)}"/>
		</form>
		<%
	}
%>
		<hr>
		<p><b>Developed by :</b><i> Minh Van-Dinh, Ethan Cranmer, Matthew Edwards, Garrett Custer</i></p>
	</body>
</html> 