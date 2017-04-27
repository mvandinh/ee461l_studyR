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
	      <li><a href="/search.jsp">Search Study Sessions</a></li>
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
				Profile profile = null;
  			  	if (userService.isUserLoggedIn()) {	  			  	
	  				User user = userService.getCurrentUser();
	  				String userID = user.getUserId();
    				Ref<Profile> profileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());
    				profile = profileRef.get();
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
					<h2 align="left"><u>Your public profile</u></h2>
						<div class = "col-lg-6">						
							<h3 align="left" class="tab"><b>Display name</b>: ${fn:escapeXml(name)}</h3>
							<h3 align="left" class="tab"><b>Display email</b>: ${fn:escapeXml(email)}</h3>
							<h3 align="left" class="tab"><b>Display phone</b>: ${fn:escapeXml(phone)}</h3>
						</div>
						<div class = "col-lg-6">
						<h3 align="left" class="tab"><b>Available times</b>:</h3>					
						<%				
						//if(profile.getPreferences() != null && profile.getPreferences().getTimePrefs() != null){
							//ArrayList<String> timePrefs = profile.getPreferences().getTimePrefs();
							//for(int i = 0; i < timePrefs.size(); i++){
								//pageContext.setAttribute("thisTimePref", timePrefs.get(i));
								%>
								<%--<h3 align="left">${fn:escapeXml(thisTimePref)}</h3>--%>
								<%
							//}
						//}
						%>	

					</div>
				</div>
				<div class="row">
					<h3 align="left" class="tab"><b>Bio</b>:</h3>
					<div class="well">${fn:escapeXml(bio)}</div>
				</div>
	
				<div class="row">
					<h2 align="left"><u>Notifications</u></h2>
					<div class="col-lg-6">
						<h2 align="left" class="tab"> Upcoming Sessions:</h2>
							<%
							User user = userService.getCurrentUser();
			  				String userID = user.getUserId();
			  				List<StudySession> sessions = ObjectifyService.ofy().load().type(StudySession.class).list();
			  				boolean member;
			  		        for(StudySession s : sessions){
			  		        	member = false;
			  		        	if(userID.equals(s.getHost().getUserID())){
			  		        		member = true;
			  		        	}
			  		        	for(Profile p: s.getMemberList()){
			  		        		if(userID.equals(p.getUserID())){
			  		        			member = true;
			  		        		}
			  		        	}
			  		        	if(member){
			  		        		pageContext.setAttribute("session_name", s.getName());
			  	    				pageContext.setAttribute("session_course", s.getCourse());
			  	    				pageContext.setAttribute("session_date", s.getDate());
			  	    				pageContext.setAttribute("session_time", s.getStartTime());
			  		        		%>
			  		        		<h3 align="left" class="tab"><b>${fn:escapeXml(session_name)}, ${fn:escapeXml(session_course)}</b>: ${fn:escapeXml(session_date)}, ${fn:escapeXml(session_time)}</h3>
			  		        		<%
			  		        	}
			  		        }
							%>
					</div>
					<div class="col-lg-6">					
						<h2 align="left" class="tab">Messages:</h2>	
						Todo
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
		