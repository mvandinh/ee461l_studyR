<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="studyR.Profile" %>
<%@ page import="studyR.StudySession" %>
<%@ page import="studyR.SearchResults" %>
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
<%--<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />--%>
<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />-->
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
						<style>
							h3 {color:blue;}				
						</style>	
</head>


<title>Search Study Sessions</title>
<body>
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <div class="navbar-header">
	      <a class="navbar-brand" href="#">studyR</a>
	    </div>
	    <ul class="nav navbar-nav">
	   	  <li ><a href="/userInterface.jsp">Dashboard</a></li>
	      <li class="active"><a href="/editProfile.jsp">Edit Profile</a></li>
	      <li><a href="/createStudySession.jsp">Create Study Session</a></li>
	      <li><a href="search.jsp">Search Study Sessions</a></li>
	      <li><a href="#">Search For User</a></li>
	    </ul>
	  </div>
	</nav>
	<div class="jumbotron vertical-center">
		<div class="container-fluid" align= "left">
			<div class="row">
			<h3>Advanced Filters:</h3>
			<form action="/search" method="post" id="search">
				<div id="otherPrefs" class="tabcontent">
					Group Size:
					<input type="number" name="groupSize" value="todo" id="groupSize" min = "2" max="10"><br><br>
					Study Style: 
						<select name="studyStyle" id="studyStyle">
							<option selected = "selected"> No Preference </option>
							<option> Quiet </option>
							<option> Collaborative </option>
						</select><br><br>
					Study Purpose:
						<select name="studyPurpose" id="studyPurpose">
							<option selected = "selected"> No Preference </option>
							<option> Class Discussion </option>
							<option> Homework </option>
							<option> Exam Review </option>
						</select><br><br>
					<input type="submit" class="btn btn-info" value="Filter" onclick="errorMessage()">
					<a href="/userInterface.jsp" class="btn btn-primary" role="button" id="cancel">Cancel</a>
				</div>
			</form>
			</div>
		</div>
		<div class="container" align="right">
			<div class="row">
				<%
				ObjectifyService.register(StudySession.class);
				ObjectifyService.register(SearchResults.class);
				ObjectifyService.register(Profile.class);
				UserService userService = UserServiceFactory.getUserService();
			    User user = userService.getCurrentUser();
			    Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());
			    Profile userProfile = userProfileRef.get();
				Ref<SearchResults> searchResultsRef = ObjectifyService.ofy().load().type(SearchResults.class).id(user.getUserId() +"_searchResults");
			    SearchResults searchResults = searchResultsRef.get();
				List<StudySession> studySessions = ObjectifyService.ofy().load().type(StudySession.class).list();   
				
			    if (studySessions.isEmpty()) {
			        %>
			        <p>No study sessions with your preferences are available, but you can host you own <a href="/createStudySession.jsp">here</a>!!</p>
				<% } else {
						if (searchResults != null){ 
							studySessions = searchResults.getSearchResults();
						}
						Collections.sort(studySessions); 
						Collections.reverse(studySessions);
						%><h4>Study Session Search Results: </h4>
					    <table style="width:100%">
					    	  <tr>
						        <th>Name:</th>
						        <th>Date:</th> 
						        <th>Course:</th>
						        <th>Occupancy:</th>
						        <th>Study Style:</th>
						        <th>Study Purpose:</th>
					    	  </tr>
					    	<%for (StudySession studySession : studySessions) {
					    		if (studySession.getHost().equals(userProfile))
					        	pageContext.setAttribute("studySession_name", studySession.getName());
					        	pageContext.setAttribute("studySession_date", studySession.getDate());
					        	pageContext.setAttribute("studySession_course", studySession.getCourse());
					        	pageContext.setAttribute("studySession_groupSize", studySession.getGroupSize());
					        	pageContext.setAttribute("studySession_currentNumMembers", studySession.getCurrentNumMembers());
					        	pageContext.setAttribute("studySession_studyStyle", studySession.getStudyStyle());
					        	pageContext.setAttribute("studySession_studyPurpose", studySession.getStudyPurpose());
					        	pageContext.setAttribute("studySession_description", studySession.getDescription());
					        	%>
					        	<tr>
						    	    <td><span title="${fn:escapeXml(studySession_description)}"><a href="/userInterface.jsp" onclick="joinStudySession(studySession.getId)">${fn:escapeXml(studySession_title)}</a></span></td>
						    	    <td>${fn:escapeXml(studySession_date)}</td> 
						    	    <td>${fn:escapeXml(studySession_course)}</td>
						    	    <td>${fn:escapeXml(studySession_currentNumMembers)} / ${fn:escapeXml(studySession_groupSize)}</td>
						    	    <td>${fn:escapeXml(studySession_studyStyle)}</td>
						    	    <td>${fn:escapeXml(studySession_studyPurpose)}</td>
					    	  	</tr>
					        	<%
			        		}
					    	if (searchResults != null){ 
					    		ObjectifyService.ofy().delete().type(SearchResults.class).id(user.getUserId() +"_searchResults").now();
							}
			    	%></table><%
				}
				%>
			</div>
		</div>		
	</div>		
	
			<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
			
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/editProfile.js"></script>

</body>
<script>
	document.getElementById("defaultButton").click();
	
	function joinStudySession(String hostId) {
		Ref<studySession> studySessionRef = ObjectifyService.ofy().load().type(StudySession.class).id(hostId);
	    StudySession studySession = studySessionRef.get();
	    studySession.add(userProfile);
	}
</script>
</html>
		
				