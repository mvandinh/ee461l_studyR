<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="studyR.StudySession" %>
<%@ page import="studyR.Profile" %>
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
<%@ page session="false" %>
<%@ page import="studyR.Profile"%>


<html>
	<head>
   		<title>studyR - the study buddy maker!</title>
   		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
		<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />-->
		<!-- Bootstrap -->
		<link href="css/bootstrap.css" rel="stylesheet">
	</head>
	<body>
	<div class="jumbotron vertical-center">
		<div class="wrapper container">
			<h1>studyR</h1>
	  		<h3></h3>
	  		<i>"I went fishing this one time, and it was a tuna fun!</i>
	  		<img src = "http://vignette2.wikia.nocookie.net/scribblenauts/images/7/7a/Tuna_Fish.png/revision/latest?cb=20130418113339" alt = "Cartuna" style = "width:250px;height:125px">
	  		<hr>
			<%
			ObjectifyService.reset();	
			ObjectifyService.register(Profile.class);
		
			ObjectifyService.register(StudySession.class);
		    String studyR = request.getParameter("studyR");
		    if (studyR != null) {
		        studyR = "default";
		    }
		    pageContext.setAttribute("studyR", studyR);
		    UserService userService = UserServiceFactory.getUserService();
		    User user = userService.getCurrentUser();
		    if (user != null) {
		    	response.sendRedirect("userInterface.jsp");
		    } else {
				%>
				<p>Hello! Please 
				<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
				to be able to use studyR!</p>
				<%
				}
			%>
			<!--Debugger Button
			<form action="/deleter" method="post">
				<input type="submit" value="DELETER DEBUG">
			</form>
			-->

				<hr>
				<p><b>Developed by :</b><i> Minh Van-Dinh, Ethan Cranmer, Matthew Edwards, Garrett Custer</i></p>
		</div>
	</div>
	
	</body>
				<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>
</html> 