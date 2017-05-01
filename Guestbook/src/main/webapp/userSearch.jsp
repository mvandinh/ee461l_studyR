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
<%@ page import="studyR.courseList" %>
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
	      <li><a href="/messageBoard.jsp">Group Messages</a></li>
	      <li><a href="/privateMessages.jsp">Private Messages</a></li>
	    </ul>
	  </div>
	</nav>
	<%
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());	// Grab User profile
    Profile userProfile = userProfileRef.get();
    pageContext.setAttribute("sender", userProfile.getName());
	%>
	<div class="jumbotron vertical-center">
		<div class="container" align= "left">
		<h2><u>Search for a user:</u></h2>
			<div class="row">
			
				<div id="margin-left">
					<div id="margin-left"> Search by Username: </div>
					<form action="/userSearch" method="post" name="form0" id="form0">
						<input type="text" id="username" name="username">
						<input type="hidden" id="searchType" value="username">
						<input type="submit">
					</form>
					<br>
					<div id="margin-left"> Search by Email: </div>
					<form action="/userSearch" method="post" name="form1" id="form1">
						<input type="text" id="email" name="email">
						<input type="submit">
					</form>		
					<br>
					<div id="margin-left"> Search by enrolled course: </div>										
					<form action="/userSearch" method = "post" name="form2" id="form2">
						 <select name="course" id="course">
						 <%
						 for(int i = 0; i < courseList.courseList.length; i++){
							 pageContext.setAttribute("nextCourse", courseList.courseList[i]); 
						 %>
							<option> ${fn:escapeXml(nextCourse)} </option>
						<%} %>
						</select>
						<input type="submit">
					</form>
					</div>
			</div>
		</div>
	</div>
	<div class="jumbotron vertical-center">
		<div class="container" align= "left">
			<h2><u>Results:</u></h2>
			<%
			boolean resultsFlag = "true".equals(request.getAttribute("resultsFlag"));
			if(resultsFlag){
				ArrayList<Profile> displayProfiles = (ArrayList<Profile>) request.getAttribute("results");
				if(displayProfiles.size() == 0){
					%><p> No results found </p><%
				}				
				for(Profile p : displayProfiles){
					pageContext.setAttribute("profileID", p.getUserID());
					String profileID = p.getUserID();
					%>
					<hr>
					<p><%=p.getName()%></p>
					Send a private message:
					<form action="/privateMessage" method="post" name="loveforms">
						<input type="hidden" name="userID" id="userID" value="${fn:escapeXml(profileID)}">
						<input type="hidden" name="sender" id="sender" value="${fn:escapeXml(sender)}">
						<textarea id="message" name="message"></textarea>
						<input type="submit" name="submit" id="submit">
					</form>
			  <%}
			  }%>
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
		
				