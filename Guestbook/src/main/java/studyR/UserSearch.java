package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Ref;


public class UserSearch extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());	// Grab User profile
	    Profile userProfile = userProfileRef.get();
	    
	    List<Profile> userList = ofy().load().type(Profile.class).list();
	    String username = req.getParameter("username");
	    String email = req.getParameter("email");
		String course = req.getParameter("course");
		String searchType = new String();
		if(username != null){
			searchType = "username";
		}else if(email != null){
			searchType = "email";
		} else if(course != null){
			searchType = "course";
		}	  
		ArrayList<Profile> matchingProfiles = new ArrayList<Profile>();
	    switch(searchType){
	    	case "username":
	    		for(Profile p: userList){
	    			if(p.getName().equals(username) && p != userProfile){
	    				matchingProfiles.add(p);
	    			}
	    		}
	    		req.setAttribute("results", matchingProfiles);
	    		break;
	    	case "email":
	    		for(Profile p: userList){
	    			if(p.getEmail().equals(email) && p != userProfile){
	    				matchingProfiles.add(p);
	    			}
	    		}
	    		req.setAttribute("results", matchingProfiles);
	    		break;
	    	case "course":
	    		for(Profile p: userList){
	    			if(p.getCourses() != null && p.getCourses().contains(course) && p != userProfile){
	    				matchingProfiles.add(p);
	    			}
	    		}
	    		break;
	    }
		req.setAttribute("results", matchingProfiles);
	    req.setAttribute("resultsFlag", "true");
	    try {
			getServletContext().getRequestDispatcher("/userSearch.jsp").forward(req, resp);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    }
}
