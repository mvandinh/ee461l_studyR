
package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import studyR.Profile;
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Ref;
import com.googlecode.objectify.Result;

public class privateMessageServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(req.getParameter("userID"));	// Grab User profile
	    Profile p = userProfileRef.get();
	    
	    String newMessage = req.getParameter("message");
	    
	    String userName = p.getName();
		String email = p.getEmail();
		String phone = p.getPhone();
		String bio = p.getBio();
		String timePrefs = p.getTimePrefs();
		String groupSize = p.getGroupSize();
		String groupLongevity = p.getGroupLongevity();
		String userID = p.getUserID();
		String courses = p.getCourses();
		String[] privateMessages = p.getPrivateMessages();
		String[] recentMessages = p.getRecentMessages();
		
		String [] newPrivateMessages = null;
		if(privateMessages != null){
			newPrivateMessages = new String[privateMessages.length + 1];
			newPrivateMessages[privateMessages.length] = req.getParameter("sender") + ": " +  newMessage;
		}else{
			newPrivateMessages = new String[1];
			newPrivateMessages[0] = req.getParameter("sender") + ": " +  newMessage;
		}
		
		Profile replacement = new Profile(userName, email, phone, bio, courses, timePrefs, groupLongevity, groupSize, userID, recentMessages, newPrivateMessages);
		
		ofy().delete().type(Profile.class).id(userID).now();
		ofy().save().entity(replacement).now();
		resp.sendRedirect("/userInterface.jsp");
	    
	    
	}
}