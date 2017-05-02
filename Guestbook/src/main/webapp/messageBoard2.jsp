
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="studyR.StudySession" %>
<%@ page import="studyR.Email" %>
<%@ page import="studyR.MessageBoardServlet" %>
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
<%@ page import="java.io.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="studyR.courseList" %>
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


<title>Messages</title>
<body>
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <div class="navbar-header">
	      <a class="navbar-brand" href="#">studyR</a>
	    </div>
	    <ul class="nav navbar-nav">
	   	  <li ><a href="/userInterface.jsp">Dashboard</a></li>
	      <li ><a href="/editProfile.jsp">Edit Profile</a></li>
	      <li class="active"><a href="/messageBoard.jsp">Messasge Board</a></li>
	      <li><a href="search.jsp">Search Study Sessions</a></li>
	      <li><a href="/userSearch.jsp">Search For User</a></li>
	    </ul>
	  </div>
	</nav>
	<h1>
		<font face="agency FB">Create Study Session
		</font>
	</h1>
	<br>
		  <%
			UserService userService = UserServiceFactory.getUserService();
		  	List<StudySession> joined = new ArrayList<StudySession>();
		  	User user = userService.getCurrentUser();
			String userID = user.getUserId();
			List<StudySession> sessions = ObjectifyService.ofy().load().type(StudySession.class).list();
	        for(StudySession s : sessions){
	        	String[] memberList = s.getMemberList();
	        	int currentNumMembers = s.getCurrentNumMembers();
	    		for (int i = 0; i < currentNumMembers; i++) {
	    			if (memberList[i] != null && memberList[i].equals(userID)) {
	    				joined.add(s);
	    				break;
	    			}
	    		}
	        }
	    
		for(StudySession s: joined){
		%>
		<form action="/messageBoard" method="post" id="<%s.getId();%>">
		<%
		pageContext.setAttribute("id", s.getId());
		pageContext.setAttribute("name", s.getName());
		%>
		<div>
				 <h1>${fn:escapeXml(name)}:</h1>
				 <br>
				<%
				String[] list = s.getMessageList();
				String[] namelist = s.getMessageNameList();
				if(list == null){
					%>
					[No messages]
					<%
				}
				else{
					for(int i = 0; i < list.length; i++){
						pageContext.setAttribute("name", list[i]);
						pageContext.setAttribute("message", namelist[i]);
						%>
						<b>${fn:escapeXml(name)}:</b> ${fn:escapeXml(message)}
						<br>
						<%
					}
				}
				%>
				<input type="hidden" name="userID" value="<%=user.getUserId()%>">
				<textarea name="messageText" rows="4" cols="50"></textarea>
				<input type="submit" class="btn btn-info" value="Send Message" onclick="errorMessage()">
		</div>
		</form>
			<%	
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
		