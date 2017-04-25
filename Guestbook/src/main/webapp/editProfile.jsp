
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="studyR.StudySession" %>
<%@ page import="studyR.Email" %>
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
	      <li><a href="#">Request Session</a></li>
	      <li><a href="#">Search For User</a></li>
	    </ul>
	  </div>
	</nav>
		<% 
		
		   UserService userService = UserServiceFactory.getUserService();
	       User user = userService.getCurrentUser();
	       Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());
	       Profile userProfile = userProfileRef.get();
	       pageContext.setAttribute("userName", userProfile.getName());
	       pageContext.setAttribute("email", userProfile.getEmail());
	       pageContext.setAttribute("phoneNumber", userProfile.getPhone());
	       pageContext.setAttribute("bio", userProfile.getBio());
	       int numberTimes = 0;
	       ArrayList<String> timePrefs = new ArrayList<String>();
	       if(userProfile.getPreferences() != null && 
		    		userProfile.getPreferences().getTimePrefs()!= null){
		    	   timePrefs =  userProfile.getPreferences().getTimePrefs();
			       numberTimes = timePrefs.size();
			       pageContext.setAttribute("groupSize", userProfile.getPreferences().getGroupSize());
			       pageContext.setAttribute("groupLongevity", userProfile.getPreferences().getGroupLongevity());
			       pageContext.setAttribute("groupDiscussion", userProfile.getPreferences().getStudyStyles().get("Group Discussion"));
			       pageContext.setAttribute("practiceQuestions", userProfile.getPreferences().getStudyStyles().get("Practice Questions"));
			       pageContext.setAttribute("projectGroup", userProfile.getPreferences().getStudyStyles().get("Project Group"));
			       pageContext.setAttribute("examReview", userProfile.getPreferences().getStudyStyles().get("Exam Review"));
		       }else{
		    	   timePrefs =  new ArrayList<String>();
		    			   //userProfile.getPreferences().getTimePrefs();
			       numberTimes = 0;
			       			//timePrefs.size();
		    	   pageContext.setAttribute("groupSize", 0);
			       pageContext.setAttribute("groupLongevity", "1 Week");
			       pageContext.setAttribute("groupDiscussion", false);
			       pageContext.setAttribute("practiceQuestions", false);
			       pageContext.setAttribute("projectGroup", false);
			       pageContext.setAttribute("examReview", false);
		       }
	       pageContext.setAttribute("numTimes", numberTimes);
	       String timePrefsString = new String(); 
	       for(int i = 0; i < timePrefs.size(); i++){
	    	  timePrefsString += timePrefs.get(i) + "|";
	       }
		%>		
	<form action="/editProfile" method="post" id="myform">
		
		<div class="tab">
		  <button type="button" class="tablinks" onclick="openCity(event, 'Basic')" id="defaultButton">Basic Information</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'Bio')">Bio</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'timePrefs')">Time Preferences</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'otherPrefs')">Other Preferences</button>
		</div>
		
		<div id="Basic" class="tabcontent">
			<br>
			 Display Name:
			 <input type="text" name="userName" value="${fn:escapeXml(userName)}" id="userName">
			 <br>
			 <br>
			 Email:
			 <input type="text" name="email" value="${fn:escapeXml(email)}" id="email">
			 <br>
			 <br>
			 Phone Number:
			 <input type="text" name="phone" id="phone" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" value="${fn:escapeXml(phoneNumber)}">
			 <br>
			 Format: 555-555-5555
				 
		</div>		
		<div id="Bio" class="tabcontent">
			<br>
			Edit your profile description:
			<br>
			<textarea name="bioText" rows="3" cols="60" id="bioText">${fn:escapeXml(bio)}</textarea>
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
				 Study Styles:
				 <br>
				 <p style="margin-left: 40px"><input type="checkbox" name="Group Discussion" id="studyStylesGD" > Group Discussion</p>
				 <p style="margin-left: 40px"><input type="checkbox" name="Practice Questions" id="studyStylesPQ" > Practice Questions</p>
				 <p style="margin-left: 40px"><input type="checkbox" name="Project Group" id="studyStylesPG" > Project Group</p>
				 <p style="margin-left: 40px"><input type="checkbox" name="Exam Review" id="studyStylesER" > Exam Review</p>
				 
		</div>
		
		
		<input type="hidden" name="userID" value="<%=user.getUserId()%>">
		
		<div>
			<input type="submit" class="btn btn-info" value="Save" onclick="errorMessage()">
			<a href="/userInterface.jsp" class="btn btn-primary" role="button" id="cancel">Cancel</a>
		</div>
		
	</form>

	
			<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
			
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/editProfile.js"></script>

</body>
<script>
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
	
	//preload longevity pref
	var groupLongevity = document.getElementById("groupLongevity");
	var groupLongevityOpts = groupLongevity.options;
	for(var i = 0; i < groupLongevityOpts.length; i++){
		if(groupLongevityOpts[i].text == '${groupLongevity}'){
			groupLongevity.selectedIndex = i;
		}
	}
	var groupDiscussion = document.getElementById("studyStylesGD");
	var GD = ${groupDiscussion};
	if(GD){
		groupDiscussion.checked = "true";
	}
	var practiceQuestions = document.getElementById("studyStylesPQ");
	var PQ = ${practiceQuestions};
	if(PQ){
		practiceQuestions.checked = "true";
	}
	var projectGroup = document.getElementById("studyStylesPG");
	var PG = ${projectGroup};
	if(PG){
		projectGroup.checked = "true";
	}
	var examReview = document.getElementById("studyStylesER");
	var ER = ${examReview};
	if(ER){
		examReview.checked = "true";
	}
			    

</script>
</html>
		
				