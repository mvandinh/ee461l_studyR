<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="guestbook.StudySession" %>
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
   		<title>You're Not Punny</title>
   		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
	</head>
	<body>
		<h1>You're Not Punny</h1>
   		<h3>Welcome to Minh and Ethan's punderful blog! Feel free to post your own cringe inducing puns.<br> Remember, if someone tells you that "you're not punny", you did your job. Welcome to the family!</h3>
   		<img src = "http://vignette2.wikia.nocookie.net/scribblenauts/images/7/7a/Tuna_Fish.png/revision/latest?cb=20130418113339" alt = "Cartuna" style = "width:250px;height:125px">
   		<i>"I went fishing this one time, and it was a tuna fun!</i>
   		<img src = "http://vignette2.wikia.nocookie.net/scribblenauts/images/7/7a/Tuna_Fish.png/revision/latest?cb=20130418113339" alt = "Cartuna" style = "width:250px;height:125px">
   		<hr>
<%
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
%>
<%
	if (user != null) {
		%>
		<p>Please include a title with your post!</p>
		<form action="/ofysign" method="post">
			<b>Title:</b>
			<input type="text" name="title"><br>
			<b>Content:</b>
			<div><textarea name="content" rows="3" cols="60"></textarea></div>
			<div><input type="submit" name="button1" value="Submit Blog Post" /></div>
			<div><input type="submit" name="button4" value="Cancel Post" /></div>
			<input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
		</form>
		<%
	}
%>
	</body>
</html> 