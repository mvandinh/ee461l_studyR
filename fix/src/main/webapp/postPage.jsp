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
<%@ page import="java.util.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<!-- <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />-->
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
</head>
<title>All Posts</title>
<body>
	<div class="jumbotron vertical-center">
		<div class="wrapper container">
			<%
				ObjectifyService.register(Post.class);
				List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list();
				Collections.sort(posts);
				if (posts.isEmpty()) {
			%>

			<p>There are no posts.</p>

			<%
				} else {
			%>

			<a href="/blog.jsp" class="btn btn-primary" role="button">Home</a>

			<h2><br>All the Hot Takes Ever<br></h2>
			<%
				UserService userService = UserServiceFactory.getUserService();
					User user = userService.getCurrentUser();

					for (int i = posts.size() - 1; i >= 0; i--) {
						pageContext.setAttribute("title", posts.get(i).getTitle());
						pageContext.setAttribute("greeting_content", posts.get(i).getContent());
						pageContext.setAttribute("post", String.valueOf(i));
						pageContext.setAttribute("greeting_user", posts.get(i).getUser());
						pageContext.setAttribute("date", posts.get(i).getPostTime());
			%>
			<div class="panel panel-default">
				<div class="panel-heading">
					<p>
						<b>${fn:escapeXml(greeting_user.nickname)}</b> wrote:
					</p>
				</div>
				<div class="panel-body">
					<h2>${fn:escapeXml(title)}</h2>${fn:escapeXml(greeting_content)}</div>
				<div class="panel-footer">
					on <strong>${fn:escapeXml(date)}</strong>
					<%
						if (user != null && (user.equals(posts.get(i).getUser())
										|| user.getEmail().equals("mathew41796@gmail.com"))) {
					%>
					<form action="/delete" method="post">
						<input type="hidden" name="post" value="${fn:escapeXml(post)}" />
						<div>
							<button type="submit" class="btn btn-danger" role="button">Delete</button>
							<!-- <input type="submit" value="delete" /> -->
						</div>
					</form>
					<%
						}
					%>
				</div>
			</div>


			<%
				}
				}
			%>
		</div>
	</div>
</body>
</html>

