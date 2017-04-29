<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />-->
<!-- Bootstrap -->
<link href="css/bootstrap-search.css" rel="stylesheet">
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
	      <li ><a href="/editProfile.jsp">Edit Profile</a></li>
	      <li><a href="/createStudySession.jsp">Create Study Session</a></li>
	      <li ><a href="search.jsp">Search Study Sessions</a></li>
	      <li class="active"><a href="/userSearch.jsp">Search For User</a></li>
	    </ul>
	  </div>
	</nav>
	<p>You can look at all existing study sessions at this page. Use the advanced filters to match the results with your preferences. Hover over the study session's name to view its description</p> 
	<div class="jumbotron vertical-center">
		<div class="container-fluid" align= "left">
			<div class="row">
			<h3>Search for a user:</h3>
				<div id="margin-left">
					<div id="margin-left"> Search by Username: </div>
					<form action="/userSearch" method = "post">
						<input type="text" id="username">
						<input type="submit">
					</form>
					<br>
					<div id="margin-left"> Search by Email: </div>
					<form action="/userSearch" method = "post">
						<input type="text" id="email">
						<input type="submit">
					</form>		
					<br>
					<div id="margin-left"> Search by enrolled course: </div>										
					<form action="/userSearch" method = "post">
						<input type="text" id="email">
						<input type="submit">
					</form>
					</div>
			</div>
		</div>
		<%
		
		if(/*resultsFlag*/ false){
		%>
		
		<div class="container" align="left">
			<div class="row">
				<h4><b>Results: </b></h4>
				<hr>
				<%
				ObjectifyService.register(StudySession.class);
				ObjectifyService.register(SearchResults.class);
				ObjectifyService.register(Profile.class);
				
				UserService userService = UserServiceFactory.getUserService();
			    User user = userService.getCurrentUser();
			    Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());
			    Profile userProfile = userProfileRef.get();
					        %>No study sessions are available to you, but you can host you own <a href="/createStudySession.jsp">here</a>!!<%
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

</script>
</html>
		
				