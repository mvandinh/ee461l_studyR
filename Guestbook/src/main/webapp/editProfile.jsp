<!-- WebApp URL: http://homework-1-159007.appspot.com/ 
	Matthew Edwards
	EID: mwe295
	Ahsan Khan
	EID: ajk2723
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="studyR.StudySession" %>
<%@ page import="studyR.Email" %>
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
<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />-->
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">

						<style>
							h3 {color:blue;}				
						</style>	
</head>


<title>Edit Profile</title>
<body>

	<form action="/editProfile" method="post" enctype="multipart/form-data">
		
		<div class="tab">
		  <button type="button" class="tablinks" onclick="openCity(event, 'Basic')" id="defaultButton">Basic Information</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'Bio')">Bio</button>
		</div>
		
		<div id="Basic" class="tabcontent">
				 Display Name:
				 <input type="text" name="userName" value="todo" id="userName"><br>
				 Email:
				 <input type="text" name="email" value="todo" id="email"><br>
				 Phone Number:
				 <input type="text" name="phone" value="todo" id="phone"><br>
				 Please format your phone number as follows: 555-123-4567.
		</div>
		

		
		<div id="Bio" class="tabcontent">
		  Edit your profile description:
				<br>
				<!-- TODO: make the servlet which updates the profile -->
				<h3 align = "left">Personal Description:</h3>		
					<div>
						<textarea name="content" rows="3" cols="60" id="bio">test</textarea>
					</div>
		</div>
		
		
		
		<% UserService userService = UserServiceFactory.getUserService();
	       User user = userService.getCurrentUser();
	       String userID = user.getFederatedIdentity();
		%>
		
		<input type="hidden" name="userID" value="${fn:escapeXml(userID)}" />
		
		<div>
			<input type="submit" class="btn btn-info" value="Save">
		</div>
		
	</form>
	
	<div class="row" align="left">
		<a href="/userInterface.jsp" class="btn btn-primary" role="button">Cancel</a>
	</div>
	
			<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
			
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>


</body>
	<script>
		document.getElementById("defaultButton").click();
	</script>
</html>
		
				