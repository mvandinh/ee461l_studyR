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
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Result;

public class CreateStudySessionServlet extends HttpServlet {
	
	private static boolean isError = false;
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String groupName = req.getParameter("sessionName");
		String className = req.getParameter("className");
		className = className.toUpperCase().replaceAll(" ", "").trim();
		String weekDay = req.getParameter("weekDay");
		String startHour = req.getParameter("startHour");
		String startMin = req.getParameter("startMin");
		String duration = req.getParameter("duration");
		String desc = req.getParameter("bioText");
		String groupSize = req.getParameter("groupSize");
		String studyStyle = req.getParameter("studyStyle");
		String purpose = req.getParameter("groupPurpose");
		
		ObjectifyService.register(Course.class);
		ObjectifyService.register(StudySession.class);
		ObjectifyService.register(Profile.class);
		
		//Adding couple of Courses
		Course ee461l = new Course("EE461L", 16540);
		ofy().delete().type(Course.class).id(ee461l.getCourseName()).now();
		ofy().save().entity(ee461l).now();
		
		//checking if course is in course lists
		Course courseOfSession = null;
		List<Course> courses = ofy().load().type(Course.class).list();
		for(Course cur : courses){
			if(cur.getCourseName().equals(className)){
				courseOfSession = cur;
			}
		}
		if(courseOfSession == null){
			setError(true);
			resp.sendRedirect("/createStudySession.jsp");
		}
		
		//getting profile of creator
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        Profile creator = null;
        List<Profile> profiles = ofy().load().type(Profile.class).list();
        for(Profile person : profiles){
        	if(user.getUserId() == person.id){
        		creator = person;
        	}
        }
        
        //making study session
		StudySession session = new StudySession(groupName,desc,courseOfSession,Integer.parseInt(groupSize),studyStyle,purpose,creator, new ArrayList<Profile>());
		resp.sendRedirect("/userInterface.jsp");
	}

	public static boolean isError() {
		return isError;
	}

	public static void setError(boolean isError) {
		CreateStudySessionServlet.isError = isError;
	}
}
