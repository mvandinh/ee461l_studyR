
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


<title>Create Study Session</title>
<body>
	<font face="agency FB">Create Study Session</font>
	<form action="/createStudySession" method="post" id="myform">
		
		<div class="tab">
		  <button type="button" class="tablinks" onclick="openCity(event, 'Basic')" id="defaultButton">Basic Info</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'Desc')">Description</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'otherPrefs')">Other Preferences</button>
		</div>
		
		<div id="Basic" class="tabcontent">
				 Name:
				 <input type="text" name="userName" value="todo" id="userName"><br>
				 Current Meetup times:
				 <b id="clicks">0</b>
				 <br>
				 Time ranges which end before they begin will be ignored.
				 Enter times in the following format: HH:MM
				 <br id="loc">
				 <button type="button"  onclick="addTime('loc')">add another time</button>
				 <script>
					 var maxClicks = 4;//Read the note in EditProfile.java if you change this	
					 function addTime(loc){
					 addTimeReference(loc, maxClicks);
					 }
			 	 </script>
		</div>
		
		<div id="Desc" class="tabcontent">
			Edit the meetup description:
			<br>
			<textarea name="bioText" rows="3" cols="60" id="bioText">test</textarea>
		</div>
		
		<div id="otherPrefs" class="tabcontent">
				 Group Size (leave blank if your have no preference):
				 <input type="number" name="groupSize" value="todo" id="groupSize" min = "2" max="10"><br>
				 <br>
				 Group Longevity:
				 <select name="groupLongevity" id="groupLongevity">
				 	<option> 1 Week </option>
				 	<option> Several Weeks </option>
				 	<option> 1 Month </option>
				 	<option> Several Months </option>
				 	<option> 1 Semester </option>
				 	<option> Several Semesters </option>
				 	<option> Indifferent </option>
				 </select>
				 <br>
				 <br>
				 
		</div>
		<% 
		   UserService userService = UserServiceFactory.getUserService();
	       User user = userService.getCurrentUser();       
		%>		
		
		<input type="hidden" name="userID" value="<%=user.getUserId()%>">
		
		<div>
			<input type="submit" class="btn btn-info" value="Save" onclick="errorMessage()">
		</div>
	</form>
	
	<div class="row" align="left">
		<a href="/userInterface.jsp" class="btn btn-primary" role="button" id="cancel">Cancel</a>
	</div>
	
			<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
			
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/editProfile.js"></script>

</body>
<script>
	document.getElementById("defaultButton").click();
</script>
</html>
		