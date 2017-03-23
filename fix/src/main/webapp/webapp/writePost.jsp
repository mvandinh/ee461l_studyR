<!-- WebApp URL: http://homework-1-159007.appspot.com/ 
	Matthew Edwards
	EID: mwe295
	Ahsan Khan
	EID: ajk2723
-->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.googlecode.objectify.*"%>
<%@ page import="blog.Post"%>
<%@ page import="blog.Subscriber"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />-->
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
</head>
<title>Write a Post</title>
<body>

	<a href="https://www.youtube.com/watch?v=CjytAc-quyI"><img
		src="images/left_bottle.gif"
		style="position: fixed; right: 0px; bottom: 0px; width: 190px; height: 190px; border: none;" /></a>

	<div class="jumbotron vertical-center">
		<div class="wrapper container">
			<h2>Create a New Post</h2>



			<%
				String blogName = request.getParameter("blogName");
				if (blogName == null) {
					blogName = "default";
				}
				pageContext.setAttribute("blogName", blogName);

				UserService userService = UserServiceFactory.getUserService();
				User user = userService.getCurrentUser();
				if (user != null) {
					pageContext.setAttribute("user", user);
				}
			%>

			<br>

			<form action="/write" method="post">
				<h3>Title:</h3>
				<div>
					<textarea name="title" rows="1" cols="60"></textarea>
				</div>
				<h3>Post:</h3>
				<div>
					<textarea name="content" rows="3" cols="60"></textarea>
				</div>

				<input type="hidden" name="blogName"
					value="${fn:escapeXml(blogName)}" />
				<div>
					<!-- <input type="submit" value="Post" /> -->
					<button type="submit" class="btn btn-success" role="button">Post</button>
					<a href="/blog.jsp" class="btn btn-danger" role="button">Cancel</a>

				</div>
			</form>
		</div>
	</div>
</body>
</html>

