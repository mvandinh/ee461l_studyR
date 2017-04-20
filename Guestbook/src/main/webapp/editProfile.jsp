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
<link href="css/bootstrap.css" rel="stylesheet">

						<style>
							h3 {color:blue;}				
						</style>	
</head>


<title>Edit Profile</title>
<body>

	<form action="/editProfile" method="post">
		
		<div class="tab">
		  <button type="button" class="tablinks" onclick="openCity(event, 'Basic')" id="defaultButton">Basic Information</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'Bio')">Bio</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'timePrefs')">Time Preferences</button>
		  <button type="button" class="tablinks" onclick="openCity(event, 'otherPrefs')">Other Preferences</button>
		</div>
		
		<div id="Basic" class="tabcontent">
				 Display Name:
				 <input type="text" name="userName" value="todo" id="userName"><br>
				 Email:
				 <input type="text" name="email" value="todo" id="email"><br>
				 Phone Number:
				 <input type="text" name="phone" id="phone"><br>
				 Format: 555-555-5555
				 
		</div>
		

		
		<div id="Bio" class="tabcontent">
		  Edit your profile description:
				<br>
				<!-- TODO: make the servlet which updates the profile -->
				<h3 align = "left">Personal Description:</h3>		
					<div>
						<textarea name="bioText" rows="3" cols="60" id="bioText">test</textarea>
					</div>
		</div>
		
		<div id="timePrefs" class="tabcontent">
		  Your available times:
		  <b id="clicks">0</b>
		  <br>
		  Invalid times ranges, such as incomplete time ranges or time ranges which end before they begin, will be ignored.
		  <br id="loc">
		  <button type="button"  onclick="addTime('loc')">add another time</button>
		  <script>
		  var clicks = 0;
		  function addTime(loc){		  
			  if(clicks < 4){				
			  	var br = document.createElement("br");
			  		br.id = "br_" + clicks;
			  	var select = document.createElement("select");
			  		select.id = "select_" + clicks;
			  		select.name = "select_" + clicks;
				    var mon = document.createElement("option");
				    	mon.text =	"monday";
				    var tues = document.createElement("option");
				    	tues.text = "tuesday";
				    var wednes = document.createElement("option");
				    	wednes.text = "wednesday"
				    var thurs = document.createElement("option");
				    	thurs.text = "thursday";
				    var fri = document.createElement("option");
				    	fri.text =	"friday";
				    var sat = document.createElement("option");
				    	sat.text =	"saturday";
				    var sun = document.createElement("option");
				    	sun.text = "sunday";
				    select.add(mon);
				    select.add(tues);
				    select.add(wednes);
				    select.add(thurs);
				    select.add(fri);
				    select.add(sat);
				    select.add(sun);
			    var from = document.createElement("b");
			    	from.innerHTML = " from ";
			    	from.id = "from_" + clicks;
			    var firstTime = document.createElement("input");
			    	firstTime.id = "firstTime_" + clicks;
			    	firstTime.type = "time";
			    var to = document.createElement("b"); 		
			   		to.innerHTML = " to ";
			   		to.id = "to_" + clicks;
			    var secondTime = document.createElement("input");
			    	secondTime.id = "secondTime_" + clicks;
			    	secondTime.type = "time";
			    var deleteButton = document.createElement("button");
			   		deleteButton.id = clicks;
			   		deleteButton.type = "button";
			   		deleteButton.innerHTML = "delete time";
			   		deleteButton.onclick = function(){		   		
			   			var deleteThis = document.getElementById("from_" + deleteButton.id);
			   			deleteThis.parentNode.removeChild(deleteThis);
			   			deleteThis = document.getElementById("firstTime_" + deleteButton.id);
						deleteThis.parentNode.removeChild(deleteThis);
						deleteThis = document.getElementById("secondTime_" + deleteButton.id);
						deleteThis.parentNode.removeChild(deleteThis);						
						deleteThis = document.getElementById("br_" + deleteButton.id);
						deleteThis.parentNode.removeChild(deleteThis);
						deleteThis = document.getElementById("select_" + deleteButton.id);
						deleteThis.parentNode.removeChild(deleteThis);
						deleteThis = document.getElementById("to_" + deleteButton.id);
						deleteThis.parentNode.removeChild(deleteThis);
						clicks--;
						document.getElementById("clicks").innerHTML = clicks;
						this.parentNode.removeChild(this);
						
			   		}
			    var nextLine = document.getElementById(loc);
			    nextLine.parentNode.insertBefore(br, nextLine.nextSibiling);
			    nextLine.parentNode.insertBefore(select, nextLine.nextSibiling);
			    nextLine.parentNode.insertBefore(from, nextLine.nextSibiling);
			    nextLine.parentNode.insertBefore(firstTime, nextLine.nextSibiling);
			    nextLine.parentNode.insertBefore(to, nextLine.nextSibiling);
			    nextLine.parentNode.insertBefore(secondTime, nextLine.nextSibiling);		    
			    nextLine.parentNode.insertBefore(deleteButton, nextLine.nextSibiling);		    
			    clicks += 1;
		        document.getElementById("clicks").innerHTML = clicks;
			  }
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
				 	<option> Indifferent </option>
				 </select>
				 <br>
				 <br>
				 Study Styles:
				 <br>
				 <p style="margin-left: 40px"><input type="checkbox" name="Group Discussion" id="studyStylesGD"> Group Discussion</p>
				 <p style="margin-left: 40px"><input type="checkbox" name="Practice Questions" id="studyStylesPQ"> Practice Questions</p>
				 <p style="margin-left: 40px"><input type="checkbox" name="Project Group" id="studyStylesPG"> Project Group</p>
				 <p style="margin-left: 40px"><input type="checkbox" name="Exam Review" id="studyStylesER"> Exam Review</p>
				 
		</div>
		<% 
		   UserService userService = UserServiceFactory.getUserService();
	       User user = userService.getCurrentUser();
	       String userID = user.getFederatedIdentity();
		%>		
		
		<input type="hidden" name="userID" value="<%=user.getFederatedIdentity()%>">
		
		<div>
			<input type="submit" class="btn btn-info" value="Save">
		</div>
		
	</form>
	<button onclick="getBio()">click me </button>
	
	<div class="row" align="left">
		<a href="/userInterface.jsp" class="btn btn-primary" role="button">Cancel</a>
	</div>
	
			<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
			
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>


</body>
	<script>
		document.getElementById("defaultButton").click();
	</script>
</html>
		
				