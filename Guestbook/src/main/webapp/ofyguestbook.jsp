<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="guestbook.Greeting" %>
<%@ page import="guestbook.Email" %>
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
   		<title>You're Not Punny</title>
   		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
	</head>
	<body>
		<h1>You're Not Punny</h1>
   		<h3>Welcome to Minh and Ethan's punderful blog! Feel free to post your own cringe inducing puns.<br> Remember, if someone tells you that "you're not punny", you did your job. Welcome to the family!</h3>
   		<img src = "http://vignette2.wikia.nocookie.net/scribblenauts/images/7/7a/Tuna_Fish.png/revision/latest?cb=20130418113339" alt = "Cartuna" style = "width:250px;height:125px">
   		<i>"I went fishing this one time, and it was a tuna fun!</i>
   		<img src = "http://vignette2.wikia.nocookie.net/scribblenauts/images/7/7a/Tuna_Fish.png/revision/latest?cb=20130418113339" alt = "Cartuna" style = "width:250px;height:125px">
   		<hr>
<%
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
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
to be able to post and subscribe to this blog!</p>
<%
    }
%>
<%
	if (user != null) {
		%>
		<form action="/ofysign" method="post">
			<div><input type="submit" name="button3" value="New Post" /></div>
			<div><input type="submit" name="button5" value="Handle Subscriptions" /></div>
			<input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
		</form>
		<%
	}

ObjectifyService.register(Greeting.class);
List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();   
Collections.sort(greetings); 
Collections.reverse(greetings);
    if (greetings.isEmpty()) {
        %>
        <p>No blog posts have been made, you can be the first!</p>
        <%
    } else {
        %>
        <h2>The puns so far...</h2>
        <%
        if(Greeting.showAll){
        	for (Greeting greeting : greetings) {
        		pageContext.setAttribute("greeting_title", greeting.getTitle());
         		pageContext.setAttribute("greeting_content", greeting.getContent());
         		pageContext.setAttribute("greeting_date", greeting.getDate());
            	pageContext.setAttribute("greeting_user", greeting.getUser());
            	%>
            	<h4><b><i>${fn:escapeXml(greeting_title)}</i></b></h4>
            	<blockquote>"<i>${fn:escapeXml(greeting_content)}</i>"</blockquote>
            	<p>Posted by <i>${fn:escapeXml(greeting_user.nickname)}</i> on ${fn:escapeXml(greeting_date)}</p>
            	<%
        	}
        }else{
        	int i = 0;
        	while(i < 4 && i < greetings.size()){
        		Greeting greeting = greetings.get(i);
        		pageContext.setAttribute("greeting_title", greeting.getTitle());
         		pageContext.setAttribute("greeting_content", greeting.getContent());
         		pageContext.setAttribute("greeting_date", greeting.getDate());
            	pageContext.setAttribute("greeting_user", greeting.getUser());
            	%>
            	<h4><b><i>${fn:escapeXml(greeting_title)}</i></b></h4>
            	<blockquote>"<i>${fn:escapeXml(greeting_content)}</i>"</blockquote>
            	<p>Posted by <i>${fn:escapeXml(greeting_user.nickname)}</i> on ${fn:escapeXml(greeting_date)}</p>
            	<%
            	i++;
        	}
        }
    }
    %>
<br>
<%
if (!Greeting.showAll) {
	%>
   <form action="/ofysign" method="post">
			<div><input type="submit" name="button2" value="View All" /></div>
			<input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
		</form>
	<%
} else {
	%>
	<form action="/ofysign" method="post">
			<div><input type="submit" name="button2" value="Most Recent" /></div>
			<input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
		</form>
	<%
}
%>
	</body>
	<audio controls>
  		<source src="shelter.mp3" type="audio/mpeg">
	</audio>
</html> 