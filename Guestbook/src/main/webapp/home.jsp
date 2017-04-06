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


<html>
	<head>
   		<title>studyR - the study buddy maker!</title>
   		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
	</head>
	<body>
		<h1>studyR</h1>
   		<h3></h3>
   		<i>"I went fishing this one time, and it was a tuna fun!</i>
   		<img src = "http://vignette2.wikia.nocookie.net/scribblenauts/images/7/7a/Tuna_Fish.png/revision/latest?cb=20130418113339" alt = "Cartuna" style = "width:250px;height:125px">
   		<hr>
<%
    String studyR = request.getParameter("studyR");
    if (studyR == null) {
        studyR = "default";
    }
    pageContext.setAttribute("studyR", studyR);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
      pageContext.setAttribute("user", user);
%>
<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a> here.)</p>
<%
    } else {
%>
<p>Hello! Please 
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
to be able to use studyR!</p>
<%
    }
%>
<%
	if (user != null) {
		%>
		<form action="/studyR" method="post">
			<div><input type="submit" name="myProfileButton" value="My Profile" /></div>
			<div><input type="submit" name="myGroupsButton" value="My Groups" /></div>
			<div><input type="submit" name="searchSessionsButton" value="Search Study Sessions" /></div>
			<input type="hidden" name="studyR" value="${fn:escapeXml(studyR)}"/>
		</form>
		<%
		ObjectifyService.register(StudySession.class);
		List<StudySession> StudySessions = ObjectifyService.ofy().load().type(StudySession.class).list();   
		Collections.sort(StudySessions); 
		Collections.reverse(StudySessions);
		    if (StudySessions.isEmpty()) {
		        %>
		        <p>No blog posts have been made, you can be the first!</p>
		        <%
		    } else {
		        %>
		        <h2>The puns so far...</h2>
		        <%
		        if(StudySession.showAll){
		        	for (StudySession studySession : StudySessions) {
		        		pageContext.setAttribute("StudySession_title", studySession.getTitle());
		         		pageContext.setAttribute("StudySession_content", studySession.getContent());
		         		pageContext.setAttribute("StudySession_date", studySession.getDate());
		            	pageContext.setAttribute("StudySession_user", studySession.getUser());
		            	%>
		            	<h4><b><i>${fn:escapeXml(StudySession_title)}</i></b></h4>
		            	<blockquote>"<i>${fn:escapeXml(StudySession_content)}</i>"</blockquote>
		            	<p>Posted by <i>${fn:escapeXml(StudySession_user.nickname)}</i> on ${fn:escapeXml(StudySession_date)}</p>
		            	<%
		        	}
		        }else{
		        	int i = 0;
		        	while(i < 4 && i < StudySessions.size()){
		        		StudySession StudySession = StudySessions.get(i);
		        		pageContext.setAttribute("StudySession_title", StudySession.getTitle());
		         		pageContext.setAttribute("StudySession_content", StudySession.getContent());
		         		pageContext.setAttribute("StudySession_date", StudySession.getDate());
		            	pageContext.setAttribute("StudySession_user", StudySession.getUser());
		            	%>
		            	<h4><b><i>${fn:escapeXml(StudySession_title)}</i></b></h4>
		            	<blockquote>"<i>${fn:escapeXml(StudySession_content)}</i>"</blockquote>
		            	<p>Posted by <i>${fn:escapeXml(StudySession_user.nickname)}</i> on ${fn:escapeXml(StudySession_date)}</p>
		            	<%
		            	i++;
		        	}
		        }
		    }
		    %>
		<br>
		<%
		if (!StudySession.showAll) {
			%>
		   <form action="/studyR" method="post">
					<div><input type="submit" name="button2" value="View All" /></div>
					<input type="hidden" name="studyR" value="${fn:escapeXml(studyR)}"/>
				</form>
			<%
		} else {
			%>
			<form action="/studyR" method="post">
					<div><input type="submit" name="button2" value="Most Recent" /></div>
					<input type="hidden" name="studyR" value="${fn:escapeXml(studyR)}"/>
				</form>
			<%
		}
	}
%>
		<hr>
		<p><b>Developed by :</b><i> Minh Van-Dinh, Ethan Cranmer, Matthew Edwards, Garrett Custer</i></p>
	</body>
</html> 