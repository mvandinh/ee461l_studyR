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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
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

	<form action="/search" method="post" id="search">
		  <div data-role="main" class="ui-content">
    		<div data-role="collapsible">
    		<h4>Advanced Filters:</h4>
  			<ul data-role="listview">
       		<li><a href="#">Group Size: <input type="number" name="groupSize" value="todo" id="groupSize" min = "2" max="10"><br></a></li>
       		<li><a href="#">Study Style: 
						<select name="studyStyle" id="studyStyle">
				 			<option> No Preference </option>
				 			<option> Quiet </option>
				 			<option> Collaborative </option>
				 		</select>
				 		<br></a></li>
			<li><a href="#">Study Purpose: 
							<select name="studyPurpose" id="studyPurpose">
				 			<option> No Preference </option>
				 			<option> Class Discussion </option>
				 			<option> Homework </option>
				 			<option> Exam Review </option>
				 		</select>
				 		<br></a></li>
    		</ul>
    		</div>
    	</div>
		<% 
		   UserService userService = UserServiceFactory.getUserService();
	       User user = userService.getCurrentUser();       
		%>		
		
		<input type="hidden" name="userID" value="<%=user.getUserId()%>">
		
		<div>
			<input type="submit" class="btn btn-info" value="Search" onclick="errorMessage()">
		</div>
	</form>
	<%
	ObjectifyService.register(StudySession.class);
	List<StudySession> studySessions = ObjectifyService.ofy().load().type(StudySession.class).list();   
	Collections.sort(studySessions); 
	Collections.reverse(studySessions);
    if (studySessions.isEmpty()) {
        %>
        <p>No study sessions with your preferences are available, but you can make one <a href="/createStudySession.jsp">here</a>!!</p>
        <%
    } else {
    	for (StudySession studySession : studySessions) {
        	pageContext.setAttribute("greeting_title", studySession.getName());
        	%>
        	<h4><b><i>${fn:escapeXml(greeting_title)}</i></b></h4>
        	<%
        }
	}
	%>
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
		
				