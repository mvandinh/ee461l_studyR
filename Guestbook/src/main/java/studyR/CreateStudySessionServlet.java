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

import com.googlecode.objectify.ObjectifyService;

public class CreateStudySessionServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String groupName = req.getParameter("sessionName");
		String className = req.getParameter("className");
		className = className.toUpperCase().replaceAll(" ", "");
		String weekDay = req.getParameter("weekDay");
		String startHour = req.getParameter("startHour");
		String startMin = req.getParameter("startMin");
		String duration = req.getParameter("duration");
		String desc = req.getParameter("bioText");
		String groupSize = req.getParameter("groupSize");
		String purpose = req.getParameter("groupPurpose");
		
		ObjectifyService.register(Course.class);
		ObjectifyService.register(StudySession.class);
		
		//Adding couple of Courses
		Course ee461l = new Course("EE461L", 16540);
		//ofy().delete().type(Course.class).id(????).now();
		ofy().save().entity(ee461l).now();
		
		//checking if course is in course lists
		List<Course> courses = ObjectifyService.ofy().load().type(Course.class).list();
		for(Course cur : courses){
			
		}
		
		//StudySession session = new StudySession
		resp.sendRedirect("/userInterface.jsp");
	}
}
