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
	<<head>
   		<title>studyR - the study buddy maker!</title>
   		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
	</head>
	<body>
		<h1>studyR</h1>
   		<h3></h3>
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
		<p>Please include a title with your post!</p>
		<form action="/studyR" method="post">
			<b>Title:</b>
			<input type="text" name="title"><br>
			<b>Content:</b>
			<div><textarea name="content" rows="3" cols="60"></textarea></div>
			<div><input type="submit" name="button1" value="Submit Blog Post" /></div>
			<div><input type="submit" name="button4" value="Cancel Post" /></div>
			<input type="hidden" name="studyR" value="${fn:escapeXml(studyR)}"/>
		</form>
		<%
	}
%>
		<hr>
		<p><b>Developed by :</b><i> Minh Van-Dinh, Ethan Cranmer, Matthew Edwards, Garrett Custer</i></p>
	</body>
</html> 