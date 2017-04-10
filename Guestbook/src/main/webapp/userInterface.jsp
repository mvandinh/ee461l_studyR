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


<title>studyR Dashboard</title>
<body>
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
					<div class="col-sm-8">
						<img src="images/fish.png" style="float: right"
							class="img-thumbnail" alt="fish" width="50%"
							height="50%">
					</div>
					Your profile pic ya jabroni
				</div>
				<%
				UserService userService = UserServiceFactory.getUserService();
    			User user = userService.getCurrentUser();
  			  	if (user != null) {
    				pageContext.setAttribute("user", user); 	
    			%>
				
				<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
				<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a> here.)</p>
				<%
  			  	}else {
  			  		response.sendRedirect("home.jsp");			
    			}
				%>
			</div>
		</div>
		<div class="jumbotron vertical-center">
			<div class="container" align = "left">
				<table style = "float:left" class = "table">
					<thead>
						<tr>
							<th>Your profile description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</td>
						</tr>
					</tbody>
				</table>	
			</div>		
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-4">
						<h2 align="left"> Upcoming Sessions:</h2>
		
							<h3 align="left"> EE461L_Squad_Team_Alpha, Monday, March 31st 4:00pm</h3>
							<h3 align="left"> EE461L_Squad_Team_Alpha, Wednesday, April 2nd 6:00pm</h3>
							<h3 align="left"> EE362K_Master_Controllers, Thursday, April 3rd, 2:00pm</h3>

					</div>
					<div class="col-lg-4">					
						<h2 align="left">Notifications:</h2>	
						<h3 align="left"> New message from EE461L_Squad_Team_Alpha.</h3>
						<h3 align="left"> You have been invited to a new study group.</h3>
					</div>
					<div class="col-lg-4">
						<a href="/editProfile.jsp" class="btn btn-primary" role="button">Edit Profile</a>
						<p></p>
						<button type="button" class="btn btn-primary">Request session</button>
						<select>
						  <option value="volvo">EE461L_Squad_Team_Alpha</option>
						  <option value="saab">EE362K_Master_Controllers</option>
						</select>
						<form>
						  date:
						  <input type="date" name="bday">
						</form>
						<p></p>
						<button type="button" class="btn btn-primary">Search for user</button>
						<form>
						  Username:
						  <input type="text" name="bday">
						</form>
						<p></p>
						<button type="button" class="btn btn-primary">Create group</button>					
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
		