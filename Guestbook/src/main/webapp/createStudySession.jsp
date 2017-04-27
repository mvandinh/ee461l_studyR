
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="studyR.StudySession" %>
<%@ page import="studyR.Email" %>
<%@ page import="studyR.CreateStudySessionServlet" %>
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
	<h1>
		<font face="agency FB">Create Study Session
		</font>
	</h1>
	<br>
	<form action="/createStudySession" method="post" id="myform">
		
		<div class="tab">
		  <button type="button" class="tablinks" onclick="openCity(event, 'Basic')" id="defaultButton">Basic Info</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'Desc')">Description</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'otherDetails')">More Options</button>
		</div>
		
		<div id="Basic" class="tabcontent">
				 Session Name:
				 <input type="text" name="sessionName" id="sessionName"><br>
				 <br>
				 Class that session is for:
				 <select name="courseName" id="courseName">
							<option> EE302 </option>
							<option> EE306 </option>
							<option> EE312 </option>
							<option> EE313 </option>
							<option> EE319K </option>
							<option> EE360C </option>
							<option> EE411 </option>
							<option> EE422C </option>
							<option> EE461L </option>
						</select>
				 <br id="loc">
				 <br>
				 Day of the Week:
				 <select name="weekDay" id="weekDay">
				 	<option> Monday </option>
				 	<option> Tuesday </option>
				 	<option> Wednesday </option>
				 	<option> Thursday </option>
				 	<option> Friday </option>
				 	<option> Saturday </option>
				 	<option> Sunday </option>
				 </select>
				 <br>
				 <br>
				 Start time:
				 <select name="startHour" id="startHour">
				 	<option> 00 </option>
				 	<option> 01 </option>
				 	<option> 02 </option>
				 	<option> 03 </option>
				 	<option> 04 </option>
				 	<option> 05 </option>
				 	<option> 06 </option>
				 	<option> 07 </option>
				 	<option> 08 </option>
				 	<option> 09 </option>
				 	<option> 10 </option>
				 	<option> 11 </option>
				 	<option> 12 </option>
				 	<option> 13 </option>
				 	<option> 14 </option>
				 	<option> 15 </option>
				 	<option> 16 </option>
				 	<option> 17 </option>
				 	<option> 18 </option>
				 	<option> 19 </option>
				 	<option> 20 </option>
				 	<option> 21 </option>
				 	<option> 22 </option>
				 	<option> 23 </option>
				 </select>
				 :
				 <select name="startMin" id="startMin">
				 	<option> 00 </option>
				 	<option> 05 </option>
				 	<option> 10 </option>
				 	<option> 15 </option>
				 	<option> 20 </option>
				 	<option> 25 </option>
				 	<option> 30 </option>
				 	<option> 35 </option>
				 	<option> 40 </option>
				 	<option> 45 </option>
				 	<option> 50 </option>
				 	<option> 55 </option>
				 </select>
				 Duration (in Hours)
				 <select name="duration" id="duration">
				 	<option> 1 </option>
				 	<option> 2 </option>
				 	<option> 3 </option>
				 	<option> 4 </option>
				 	<option> 5 </option>
				 	<option> 6 </option>
				 	<option> 7 </option>
				 	<option> 8 </option>
				 </select>
		</div>
		
		
		<div id="Desc" class="tabcontent">
			Edit the session description:
			<br>
			<textarea name="bioText" rows="3" cols="60" id="bioText">Default</textarea>
		</div>
		
		<div id="otherDetails" class="tabcontent">
				 Group Size (leave blank if your have no preference):
				 <input type="number" name="groupSize" id="groupSize" min = "2" max="10">
				 <br>
				 <br>
				 Group Purposes:
				 <select name="groupPurpose" id="groupPurpose">
				 	<option> No Preference </option>
				 	<option> Class Discussion </option>
				 	<option> Homework </option>
				 	<option> Exam Review </option>
				 </select>
				 <br>
				 <br>
				 Group Style:
				 <select name="studyStyle" id="studyStyle">
				 	<option> No Preference </option>
				 	<option> Quiet </option>
				 	<option> Loud </option>
				 </select>
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
		