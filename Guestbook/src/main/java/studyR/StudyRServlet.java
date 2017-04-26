package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;

import java.util.Date;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
 

public class StudyRServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	if (req.getParameter("button1") != null) {
    		UserService userService = UserServiceFactory.getUserService();
            User user = userService.getCurrentUser();
            String title = req.getParameter("title");
            String content = req.getParameter("content");
            if ((!title.equals("")) && (!content.equals(""))) {
            	StudySession studySession = new StudySession();
                ofy().save().entity(studySession).now();
            }
            resp.sendRedirect("/logIn.jsp");
    	} else if (req.getParameter("toggleViewAllButton") != null) {
    		//StudySession.showAll = !StudySession.showAll;
    		resp.sendRedirect("/logIn.jsp");
    	}else if (req.getParameter("myGroupsButton") != null){
    		resp.sendRedirect("/myGroups.jsp");
    	} else if (req.getParameter("viewProfileButton") != null) {
    		resp.sendRedirect("/post.jsp");
    	} else if (req.getParameter("button4") != null) {
    		resp.sendRedirect("/logIn.jsp");
    	} else if (req.getParameter("searchSessionsButton") != null) {
    		resp.sendRedirect("/subscribe.jsp");
    	}else {}
    }
}