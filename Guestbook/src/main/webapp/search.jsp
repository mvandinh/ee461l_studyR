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
	      <li class="active"><a href="search.jsp">Search Study Sessions</a></li>
	      <li ><a href="/userSearch.jsp">Search For User</a></li>
	      <li><a href="/messageBoard.jsp">Group Messages</a></li>
	      <li><a href="/privateMessages.jsp">Private Messages</a></li>
	    </ul>
	  </div>
	</nav>
		
	<div class="jumbotron vertical-center">
		<h1>
			<font face="agency FB">Search Study Sessions
			</font>
		</h1>
		<div class="container-fluid" align= "left">
			<div class="row">
			<h3>Advanced Filters:</h3>
			<form action="/search" method="post" id="search">
				<div id="otherPrefs" class="tabcontent">
					Group Size:
					<input type="number" name="groupSize" value="todo" id="groupSize" min = "2" max="10"><br><br>
					Course: 
						<select name=course id="course">
							<option selected = "selected"> No Preference </option>
 							<%
				 			for(int i = 0; i < courseList.courseList.length; i++){
					 		pageContext.setAttribute("nextCourse", courseList.courseList[i]); 
				 			%>
							<option> ${fn:escapeXml(nextCourse)} </option>
							<%} %>
						</select><br><br>
					Study Purpose:
						<select name="studyPurpose" id="studyPurpose">
							<option selected = "selected"> No Preference </option>
							<option> Class Discussion </option>
							<option> Homework </option>
							<option> Exam Review </option>
						</select><br><br>
					Study Style: 
						<select name="studyStyle" id="studyStyle">
							<option selected = "selected"> No Preference </option>
							<option> Quiet </option>
							<option> Loud </option>
						</select><br><br>
					<input type="submit" class="btn btn-info" value="Filter" onclick="errorMessage()">
				</div>
			</form>
			</div>
		</div>
		<div class="container" align="left">
			<div class="row">
				<br><h4><b>Study Session Search Results: </b></h4>
				<hr>
				<%
				ObjectifyService.register(StudySession.class);
				ObjectifyService.register(SearchResults.class);
				ObjectifyService.register(Profile.class);
				
				UserService userService = UserServiceFactory.getUserService();
			    User user = userService.getCurrentUser();
			    Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());
			    Profile userProfile = userProfileRef.get();
			    List<StudySession> studySessions = ObjectifyService.ofy().load().type(StudySession.class).list();   
			    List<SearchResults> searchResults = ObjectifyService.ofy().load().type(SearchResults.class).list();
			    SearchResults mySearchResults = null;
			    for (SearchResults sr : searchResults) {
			    	if (sr.getId().equals(user.getUserId()+"_searchResults")) {
			    		mySearchResults = sr;
			    		ArrayList<String> filterStudySessions =  mySearchResults.getSearchResultsId();
			    		ArrayList<StudySession> filteredResults = new ArrayList<StudySession>();
			    		if (filterStudySessions != null) {
			    			for (String studySessionId : filterStudySessions) {
								Ref<StudySession> filterStudySessionRef = ObjectifyService.ofy().load().type(StudySession.class).id(studySessionId);
								if (filterStudySessionRef != null) {
									filteredResults.add(filterStudySessionRef.get());
							    }
							}
			    			studySessions = filteredResults;
			    		} else {
			    			studySessions.clear();
			    		}
			    		break;
			    	}
			    }
			    if (studySessions.isEmpty()) {
			        %>
			        No study sessions are available to you, but you can host you own <a href="/createStudySession.jsp">here</a>!!
				<% } else {
						Collections.sort(studySessions); 
						Collections.reverse(studySessions);
						boolean empty = true;
						for (StudySession studySession : studySessions) {
					    		String[] memberList = studySession.getMemberList();
					    		int currentNumMembers = studySession.getCurrentNumMembers();
					    		boolean notAlreadyJoined = true;
					    		for (int i = 0; i < currentNumMembers; i++) {
					    			if (memberList[i] != null && memberList[i].equals(userProfile.getUserID())) {
					    				notAlreadyJoined = false;
					    				break;
					    			}
					    		}
					    		if (notAlreadyJoined) {
					    			empty = false;
					    			pageContext.setAttribute("studySession_name", studySession.getName());
					    			pageContext.setAttribute("studySession_id", studySession.getId());
					    			pageContext.setAttribute("studySession_date", studySession.getDate());
						        	pageContext.setAttribute("studySession_course", studySession.getCourse());
						        	pageContext.setAttribute("studySession_startTime", studySession.getStartTime());
						        	pageContext.setAttribute("studySession_duration", studySession.getDuration());
						        	pageContext.setAttribute("studySession_groupSize", studySession.getGroupSize());
						        	pageContext.setAttribute("studySession_currentNumMembers", studySession.getCurrentNumMembers());
						        	pageContext.setAttribute("studySession_studyStyle", studySession.getStudyStyle());
						        	pageContext.setAttribute("studySession_studyPurpose", studySession.getStudyPurpose());
						        	pageContext.setAttribute("studySession_description", studySession.getDescription());
						        	pageContext.setAttribute("test", studySession.getMemberList());
						        	pageContext.setAttribute("test1", userProfile.getUserID());
						        	%>
						        		<table>
									    <tr>
									    	<td><b>Session Name:</b> ${fn:escapeXml(studySession_name)}</td>
									    </tr>
								    	<tr>
								    		<td><b>Course:</b> ${fn:escapeXml(studySession_course)}</td>
								    		<td>&emsp;&emsp;<b>Date:</b> ${fn:escapeXml(studySession_date)}</td>
								    		<td>&emsp;&emsp;<b>Time:</b> ${fn:escapeXml(studySession_startTime)} for ${fn:escapeXml(studySession_duration)} hr(s)</td>
								    	</tr>
									    <tr>
									    	<td><b>Occupancy:</b> ${fn:escapeXml(studySession_currentNumMembers)} / ${fn:escapeXml(studySession_groupSize)}</td>
									    	<td>&emsp;&emsp;<b>Study Purpose:</b> ${fn:escapeXml(studySession_studyPurpose)}</td>
									    	<td>&emsp;&emsp;<b>Study Style:</b> ${fn:escapeXml(studySession_studyStyle)}</td>
									    </tr>
									    <tr><td><b>Description:</b> ${fn:escapeXml(studySession_description)}</td></tr>
									    </table>
									<form action="/search" method="post">
										<input type="submit" name="join" value="Join ${fn:escapeXml(studySession_name)}" />
										<input type="hidden" name="studySessionId" value="${fn:escapeXml(studySession_id)}" id="studySessionId"/>
									</form>
									<hr>
						        	<%
						        	
					    		}
			        		}
						if(empty) {
							%>
					        No study sessions are available to you, but you can host you own <a href="/createStudySession.jsp">here</a>!!
						<%
						}
				}
			    if (mySearchResults != null) {
		    		ObjectifyService.ofy().delete().type(SearchResults.class).id(user.getUserId() +"_searchResults").now();
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
</script>
</html>
		
				