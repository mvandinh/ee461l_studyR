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
	
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String groupName = req.getParameter("sessionName");
		String courseName = req.getParameter("courseName");
		String weekDay = req.getParameter("weekDay");
		String startTime = req.getParameter("startHour") + ":" +req.getParameter("startMin");
		String duration = req.getParameter("duration");
		String desc = req.getParameter("bioText");
		String groupSize = req.getParameter("groupSize");
		if(groupSize.equals("")){
			groupSize = "10";
		}
		String studyStyle = req.getParameter("studyStyle");
		String purpose = req.getParameter("groupPurpose");
		
		ObjectifyService.register(Course.class);
		ObjectifyService.register(StudySession.class);
		ObjectifyService.register(Profile.class);
		
		//Adding couple of Courses
		Course ee302 = new Course("EE302", 0);
		Course ee306 = new Course("EE306", 0);
		Course ee312 = new Course("EE312", 0);
		Course ee313 = new Course("EE313", 0);
		Course ee319k = new Course("EE319K", 0);
		Course ee360c = new Course("EE360C", 0);
		Course ee411 = new Course("EE411", 0);
		Course ee422c = new Course("EE422C", 0);
		Course ee461l = new Course("EE461L", 0);
		
		//choosing which course
		Course courseSelected = new Course();
		for(Course cur : Course.courseList){
			if(courseName.equals(cur.courseName)){
				courseSelected = cur;
			}
		}
		
		//getting profile of creator
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        Profile creator = null;
        List<Profile> profiles = ofy().load().type(Profile.class).list();
        for(Profile person : profiles){
        	if(user.getUserId().equals(person.id)){
        		creator = person;
        	}
        }
        
        
        //making study session
		StudySession session = new StudySession(groupName,desc,startTime,duration,courseSelected.courseName,Integer.parseInt(groupSize),studyStyle,purpose,creator);
		resp.sendRedirect("/userInterface.jsp");
	}

}
