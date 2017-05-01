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
<%@ page import="java.util.ArrayList" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />-->
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">

<title>Private Messages</title>
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
	      <li><a href="search.jsp">Search Study Sessions</a></li>
	      <li ><a href="/userSearch.jsp">Search For User</a></li>
	      <li><a href="/messageBoard.jsp">Group Messages</a></li>
	      <li class="active"><a href="/privateMessages.jsp">Private Messages</a></li>
	      
	    </ul>
	  </div>
	</nav>
	<h1>
		<font face="agency FB">Private Messages
		</font>
	</h1>
	<div class="jumbotron vertical-center">
			<div class="wrapper container">
				<div class="row">
					<h2 align="left" ><u> Private Messages </u></h3>
					<%
					UserService userService = UserServiceFactory.getUserService();
				    User user = userService.getCurrentUser();
				    Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());	// Grab User profile
				    Profile userProfile = userProfileRef.get();
				    
				    String[] messages = userProfile.getPrivateMessages();
				    if(messages != null){
				    	for(int i = 0; i < messages.length; i++){
				    		%><p align="left"><%=messages[i] %></p> <br><%
				    	}
				    }
					
					%>
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
		