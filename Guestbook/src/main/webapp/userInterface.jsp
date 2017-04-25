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
<%@ page import="studyR.Profile" %>
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
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />-->
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">

<title>studyR Dashboard</title>
<body>
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <div class="navbar-header">
	      <a class="navbar-brand" href="#">studyR</a>
	    </div>
	    <ul class="nav navbar-nav">
	   	  <li class="active"><a href="/userInterface.jsp">Dashboard</a></li>
	      <li><a href="/editProfile.jsp">Edit Profile</a></li>
	      <li><a href="/createStudySession.jsp">Create Study Session</a></li>
	      <li><a href="#">Request Session</a></li>
	      <li><a href="#">Search For User</a></li>
	    </ul>
	  </div>
	</nav>
	<div class="jumbotron vertical-center">
			<div class="wrapper container">
				<div class="row">
					<div class="col-sm-2">
						<h1>
							<font face="agency FB">studyR Dashboard
							</font>
						</h1>
						<br>
					</div>
				
				</div>
				<%
				UserService userService = UserServiceFactory.getUserService();
  			  	if (userService.isUserLoggedIn()) {	  			  	
	  				User user = userService.getCurrentUser();
	  				String userID = user.getUserId();
    				Ref<Profile> profileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());
    				Profile profile = profileRef.get();
    				profile = profile == null ? new Profile(user) : profile;
    				pageContext.setAttribute("profile_name", profile.getName());
    				pageContext.setAttribute("name", profile.getName());
    				pageContext.setAttribute("email", profile.getEmail());
    				pageContext.setAttribute("phone", profile.getPhone());
    				pageContext.setAttribute("bio", profile.getBio());
    			%>
				<p>Hello, ${fn:escapeXml(profile_name)}! (You can
				<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a> here.)</p>
				<%
  			  	} else {
  			  		response.sendRedirect("logIn.jsp");			
    			}
				%>
			</div>
		</div>
		<div class="jumbotron vertical-center">
			<div class="container" align="left">
				<div class="row">
					<h2 align="left">Your public profile:</h2>
					<h3 align="left" class="tab">Display name: ${fn:escapeXml(name)}</h3>
					<h3 align="left" class="tab">Display email: ${fn:escapeXml(email)}</h3>
					<h3 align="left" class="tab">Display phone: ${fn:escapeXml(phone)}</h3>
					<h3 align="left" class="tab">Display bio:</h3>
						<div class="well">${fn:escapeXml(bio)}</div>
				</div>
			</div>		
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-3">
						<h2 align="left"> Upcoming Sessions:</h2>
							Todo
						

					</div>
					<div class="col-lg-3">					
						<h2 align="left">Notifications:</h2>	
						Todo
					</div>
					<div class="col-lg-2" align="left">
						<a href="/editProfile.jsp" class="btn btn-primary" role="button">Edit Profile</a>
						<br>
						<br>
						<a href="/search.jsp" class="btn btn-primary" role="button">Search for Sessions</a>
						<br>
						<form>
						  date:
						  <br>
						  <input type="date" name="bday">
						</form>
						session:
						<br>
						<select>
						  <option value="volvo">EE461L_Squad_Team_Alpha</option>
						  <option value="saab">EE362K_Master_Controllers</option>
						</select>
					</div>
					<div class="col-lg-2" align="left">
						<button type="button" class="btn btn-primary">Create group</button>		
						<br>
						<br>
						<button type="button" class="btn btn-primary">Search for user</button>
						<form>
						  Username:
						  <br>
						  <input type="text" name="bday">
						</form>
					</div>		
					</div>
				</div>
			</div>		
			
			<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>


</body>

</html>
		