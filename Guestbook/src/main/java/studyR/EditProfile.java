package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
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

//This Servlet gets the data from editProfile.jsp, creates a new Profile object,
//deletes the old corresponding Profile object, and saves the new one.
public class EditProfile extends HttpServlet {  

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        Profile profile = null;
        List<Profile> profiles = ofy().load().type(Profile.class).list();
        for(Profile person : profiles){
        	if(user.getUserId().equals(person.id)){
        		profile = person;
        	}
        }
        String[] recentMessages = profile.getRecentMessages();
        String[] privateMessages = profile.getPrivateMessages();
        String userName = req.getParameter("userName");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String bio = req.getParameter("bioText");
		String timePrefs = new String();
		//IMPORTANT: the 4 in the for-loop corresponds to the maximum number of time ranges users can input.
		//			 Change this value if we change the number of allowed time ranges as specified in editProfile.jsp.
		for(char i = '0'; i<'4'; i++){
			if(req.getParameter("select_" + i) != null){
				String day = req.getParameter("select_" + i);
				String timeStart = req.getParameter("firstTime_" + i);
				String AmPmOne = req.getParameter("AmPmOne_" + i);
				String timeEnd = req.getParameter("secondTime_" + i);
				String AmPmTwo = req.getParameter("AmPmTwo_" + i);
				if(!timePrefs.contains(day + ", " + timeStart + AmPmOne + " to " + timeEnd + AmPmTwo)){
					timePrefs += day + ", " + timeStart + AmPmOne + " to " + timeEnd + AmPmTwo + "|";
				}
			}
		}
		String groupSize = req.getParameter("groupSize");
		if(groupSize == null){
			groupSize = "Any";
		}	
		String groupLongevity = req.getParameter("groupLongevity");
		Map<String, Boolean> studyStyles = new HashMap<String, Boolean>();
		String userID = req.getParameter("userID");
		String courses = new String();
		for(int i = 0; i < 5; i++){
			String course = req.getParameter("course_" + i);
			if(course != null){
				if(!courses.contains(course))
					courses += course + ", ";
			}
		}
		if(courses.length() > 0){
			courses = courses.substring(0, courses.length()-2);
		}
		Profile replacement = new Profile(userName, email, phone, bio, courses, timePrefs, groupLongevity, groupSize, userID, recentMessages, privateMessages);
		
		ofy().delete().type(Profile.class).id(userID).now();
		ofy().save().entity(replacement).now();
		resp.sendRedirect("/userInterface.jsp");
	}
	
}
