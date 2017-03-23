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
<title>The Dog Zone</title>
<body>

	<div class="jumbotron vertical-center">
		<div class="wrapper container">
			<div class="row">
				<div class="col-sm-4">
					<h1>
						<font face="agency FB"> The Maw<br>of the<br>Dog
							Blog
						</font>
					</h1>
					<br>
					<h5>
						The Hottest Joint<br>for the<br>Worst Content<br>on
						the<br>インタネット
					</h5>
					<br> <small>what if dog was one of us</small>
				</div>
				<div class="col-sm-8">
					<img src="images/SilentHillDog.png" style="float: right"
						class="img-thumbnail" alt="Silent Hill Dog" width="50%"
						height="50%">
				</div>
			</div>
		</div>
	</div>

	<a href="https://www.youtube.com/watch?v=vsu3LUcrfok"><img
		src="images/Perrito.gif"
		style="position: fixed; right: 0px; bottom: 0px; width: 64px; height: 43px; border: none;" /></a>



	<div class="jumbotron vertical-center">
		<div class="wrapper container">
			<%
				UserService userService = UserServiceFactory.getUserService();
				User user = userService.getCurrentUser();
				String blogName = request.getParameter("blogName");
				if (blogName == null) {
					blogName = "default";
				}

				pageContext.setAttribute("blogName", blogName);

				if (user != null) {
					pageContext.setAttribute("user", user);
			%>
			<p>What's up, ${fn:escapeXml(user.nickname)}?</p>
			<a href="/postPage.jsp" class="btn btn-primary" role="button">See
				All Posts</a> <a href="/writePost.jsp" class="btn btn-primary"
				role="button">Write a Post</a> <a
				href="<%=userService.createLogoutURL(request.getRequestURI())%>"
				class="btn btn-warning" role="button">Log Out</a>

			<%
				} else {
			%>
			<p>
				Yo, <a
					href="<%=userService.createLoginURL(request.getRequestURI())%>">log
					in </a> to post on the blog, update subscription options, and delete
				your previous posts.
			</p>
			<a href="/postPage.jsp" class="btn btn-primary" role="button">See
				All Posts</a> <a
				href="<%=userService.createLoginURL(request.getRequestURI())%>"
				class="btn btn-primary" role="button">Write a Post</a> <a
				href="<%=userService.createLoginURL(request.getRequestURI())%>"
				class="btn btn-info" role="button">Log In</a>

			<%
				}
				ObjectifyService.register(Subscriber.class);
				ObjectifyService.register(Post.class);
				List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list();
				Collections.sort(posts);
				if (posts.isEmpty()) {
			%>
			<p>There are no posts.</p>
			<%
				} else {
			%>
			<h3>Most Recent Hot Takes</h3>
			<%
				for (int i = posts.size() - 1; i >= 0 && i >= posts.size() - 5; i--) {
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
				if (user != null) {
					List<Subscriber> subs = ObjectifyService.ofy().load().type(Subscriber.class).list();

					boolean isSubscribed = false;
					for (Subscriber s : subs) {
						if (s.toString().equals(user.getEmail())) {
							isSubscribed = true;
							break;
						}
					}
					if (!isSubscribed) {
			%>
			<form action="/subscribe" method="post">
				<input type="hidden" name="subscriber" value="${fn:escapeXml(user)}" />
				<input type="hidden" name="action" value="subscribe" />
				<div>
					<button type="submit" class="btn btn-info" role="button">Subscribe</button>
				</div>
			</form>
			<%
				} else {
			%>
			<form action="/subscribe" method="post">
				<div>
					<button type="submit" class="btn btn-danger" role="button">Unsubscribe</button>
				</div>
				<input type="hidden" name="subscriber" value="${fn:escapeXml(user)}" />
				<input type="hidden" name="action" value="unsubscribe" />
			</form>
			<%
				}
				} else {
			%>

			<h4>
				<br>Login to subscribe, dawg.
			</h4>
		</div>
	</div>
	<%
		}
	%>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="js/bootstrap.min.js"></script>


</body>

</html>

