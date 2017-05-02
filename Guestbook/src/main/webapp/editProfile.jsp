
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="studyR.StudySession" %>
<%@ page import="studyR.Profile" %>
<%@page import="com.googlecode.objectify.Objectify"%>
<%@page import="com.googlecode.objectify.ObjectifyService"%>
<%@page import="com.googlecode.objectify.*"%>
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
<%@ page import="java.util.ArrayList" %>
<%@ page import="studyR.courseList" %>
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


<title>Edit Profile</title>
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
				<li><a href="/search.jsp">Search Study Sessions</a></li>
				<li><a href="/userSearch.jsp">Search For User</a></li>
				<li><a href="/messageBoard.jsp">Group Messages</a></li>
				<li><a href="/privateMessages.jsp">Private Messages</a></li>
		    </ul>
		</div>
	</nav>
	<div class="jumbotron vertical-center">
		<div class="container">	
		<h1>
			<font face="agency FB">Edit Profile
			</font>
		</h1>
	
	<% 		
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());
	Profile userProfile = userProfileRef.get();
	
	pageContext.setAttribute("userName", userProfile.getName());
	pageContext.setAttribute("email", userProfile.getEmail());
	String phoneNumber = "";
	if(userProfile.getPhone() != null){
		phoneNumber = userProfile.getPhone();
	}
	pageContext.setAttribute("phoneNumber", phoneNumber);
	String bio = "";
	if(userProfile.getBio() != null){
		phoneNumber = userProfile.getBio();
	}
	pageContext.setAttribute("bio", bio);	       
	
	int numberTimes = 0;
	String timePrefs = "";
	if(userProfile.getTimePrefs()!= null){
    	   timePrefs =  userProfile.getTimePrefs();
	       numberTimes = timePrefs.length() - timePrefs.replace("|", "").length();
	}
	String groupSize = "1";
	if(userProfile.getGroupSize() != null){
		pageContext.setAttribute("groupSize", userProfile.getGroupSize());
	}else{
		pageContext.setAttribute("groupSize", "0");
	}
	pageContext.setAttribute("groupSize", groupSize);
	String groupLongevity = "EE302";
	if(userProfile.getGroupLongevity() != null){
		groupLongevity = userProfile.getGroupLongevity();
	}
	pageContext.setAttribute("groupLongevity", groupLongevity);
	pageContext.setAttribute("numTimes", numberTimes);
	pageContext.setAttribute("timePrefs", timePrefs);
	
	int numCourses = 0;
	String userCourses = "";
	if(userProfile.getCourses() != null){
		numCourses = (userProfile.getCourses().length() - userProfile.getCourses().replace(", ", "").length())/2;
		userCourses = userProfile.getCourses();
	}
	pageContext.setAttribute("numCourses", numCourses);
	pageContext.setAttribute("userCourses", userCourses);
	%>		
	
			<!--- Big ass form --->
			<form action="/editProfile" method="post" id="myform" onsubmit="return errorMessage();">
				<div class="tab">
					 <button type="button" class="tablinks" onclick="openCity(event, 'Basic')" id="defaultButton">Basic Information</button>
					 <button type="button" class="tablinks" onclick="openCity(event, 'Bio')">Bio</button>
					 <button type="button" class="tablinks" onclick="openCity(event, 'timePrefs')">Time Preferences</button>
					 <button type="button" class="tablinks" onclick="openCity(event, 'otherPrefs')">Other Preferences</button>
				</div>
				<div id="Basic" class="tabcontent">
					<br>
					 Display Name:
					 <input type="text" name="userName" value="${fn:escapeXml(userName)}" id="userName" maxlength="50" class="form-control">
					 <br>
					 Email:
					 <input type="text" name="email" value="${fn:escapeXml(email)}" id="email" maxlength="50" class="form-control"> 
					 <br>
					 Phone Number:
					 <input type="text" name="phone" id="phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" value="${fn:escapeXml(phoneNumber)}" class="form-control">
					 Format: 555-555-5555	 
				</div>		
				<div id="Bio" class="tabcontent">
					<br>
					Edit your profile description:
					<br>
					<textarea name="bioText" rows="3" cols="60" id="bioText" maxlength="500">${fn:escapeXml(bio)}</textarea>
				</div>
				<div id="timePrefs" class="tabcontent">
					<br>
					 Your available times:
					 <b id="clicks">0</b>
					 <br>
					 Time ranges which end before they begin will be ignored.
					 Enter times in the following format: HH:MM
					 <br id="loc">
					 <button type="button"  onclick="addTime('loc')" >add another time</button>
					 <script>
						 var maxClicks = 4; //Read the note in EditProfile.java if you change this	
						 function addTime(loc){
						 	addTimeReference(loc, maxClicks, "Monday", "12:00", "AM", "11:59", "AM");
						 } 
				  	</script>
				</div>
				<div id="otherPrefs" class="tabcontent">
					<br>
					Group Size (leave blank if your have no preference):
					<input type="number" name="groupSize" value="todo" id="groupSize" min = "2" max="10"><br>
					<br>
					Group Longevity:
					<select name="groupLongevity" id="groupLongevity">
						<option> 1 Week </option>
						<option> Several Weeks </option>
						<option> 1 Month </option>
						<option> Several Months </option>
						<option> 1 Semester </option>
						<option> Several Semesters </option>
						<option> No Preference </option>
					</select>
					<br>
					<br>
					Courses:
					<br>
					Number of courses:
					<b id="courses">0</b>
					<%
					String courses = new String();
					for(int i = 0; i < courseList.courseList.length; i++){
						courses += courseList.courseList[i] + "|";
						pageContext.setAttribute("courses", courses);
					}
					 %>
					 <button type="button"  onclick="addCourse('${fn:escapeXml(courses)}')" id="courseButton">add another course</button>
				</div>
				<input type="hidden" name="userID" value="<%=user.getUserId()%>">		
				<div>
					<input type="submit" class="btn btn-info" value="Save">
				</div>		
			</form>
			<!-- End big ass form -->
		</div>
	</div>
	
			<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
			
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/editProfile.js"></script>

</body>
<script>
	//This script preloads the form with profile information.
	document.getElementById("defaultButton").click();

	var times = ${numTimes};
	var timePrefsString = '${timePrefs}';
	var timePrefs = timePrefsString.split("|");
	var timePrefsSplit, day, timeOne, AmPmOne, AmPmTwo, timeTwo, i;
	//Preload timeprefs
	for (i = 0; i < times; i++){
		timePrefsSplit = timePrefs[i].split(" ");
		day = timePrefsSplit[0].replace(",", "");
		timeOne = timePrefsSplit[1].substring(0, 5);
		AmPmOne = timePrefsSplit[1].substring(5, 7);
		timeTwo = timePrefsSplit[3].substring(0, 5);
		AmPmTwo = timePrefsSplit[3].substring(5, 7);
		addTimeReference("loc", maxClicks, day, timeOne, AmPmOne, timeTwo, AmPmTwo);
	}
	//Preload courses
	var numCourse = ${numCourses};
	var theseCourses = '${userCourses}';
	var allCourses = '${courses}';
	var theseCoursesSplit = theseCourses.split(", ");
	if(numCourse > 0){
		for(var i = 0; i < numCourse+1; i++){
			addCourseQualified(allCourses, theseCoursesSplit[i]);
		}
	}
	
	var groupSize = document.getElementById("groupSize");
	var GS = ${groupSize};
	if(GS > 1){
		groupSize.value = GS;
	}
	
	//preload longevity pref
	var groupLongevity = document.getElementById("groupLongevity");
	var groupLongevityOpts = groupLongevity.options;
	var groupLongevityChoice = '${groupLongevity}';
	groupLongevity.selectedIndex = 0;
	for(var i = 0; i < groupLongevityOpts.length; i++){
		if(groupLongevityOpts[i].text == groupLongevityChoice){
			groupLongevity.selectedIndex = i;
		}
	}

</script>
</html>
		
				