package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Ref;


public class Search extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());
	    Profile userProfile = userProfileRef.get();
		if (req.getParameter("join") != null) {
			ObjectifyService.register(StudySession.class);
			String studySessionId = req.getParameter("studySessionId");
			Ref<StudySession> studySessionRef = ObjectifyService.ofy().load().type(StudySession.class).id(studySessionId);
			StudySession studySession = studySessionRef.get();
			if (studySession.getMemberList().size() < studySession.getGroupSize()) {
				String name = studySession.getName();
	    	    String description = studySession.getDescription();
	    	    String startTime = studySession.getStartTime();
	    	    String duration = studySession.getDuration();
	    	    Date date = new Date(studySession.getRealDate().getTime());
	    	    int groupSize = studySession.getGroupSize();
	    	    String studyStyle = studySession.getStudyStyle();
	    	    String studyPurpose = studySession.getStudyPurpose();
	    	    String course = studySession.getCourse();
	    	    Profile host = studySession.getHost();
	    	    ArrayList<Profile> memberList = new ArrayList<Profile>(studySession.getMemberList());
	    	    memberList.add(userProfile);
	    	    String id = studySession.getId();
	    	    ofy().delete().type(StudySession.class).id(studySessionId).now();
				StudySession replacement = new StudySession(name, description, startTime, duration, date, groupSize, studyStyle, studyPurpose, course, host, memberList, id);
				ofy().save().entity(replacement).now();
				resp.sendRedirect("/userInterface.jsp");
			} else {
				resp.sendRedirect("/search.jsp");
			}
			
		} else {
			ObjectifyService.register(StudySession.class);
			List<StudySession> studySessions = ObjectifyService.ofy().load().type(StudySession.class).list();
			Collections.sort(studySessions);
			ArrayList<StudySession> filteredSearch = new ArrayList<StudySession>(studySessions);
			String groupSize = req.getParameter("groupSize");
			int groupSizeFilter;
			if (!groupSize.equals("")) {
				groupSizeFilter = Integer.parseInt(groupSize);
			} else {
				groupSizeFilter = -1;
			}
	    	String studyStyleFilter = req.getParameter("studyStyle");
	    	String studyPurposeFilter = req.getParameter("studyPurpose");
	    	String courseFilter = req.getParameter("course");
	    	filteredSearch = filterGroupSize(filteredSearch, groupSizeFilter);
	    	filteredSearch = filterStudyStyle(filteredSearch, studyStyleFilter);
	    	filteredSearch = filterStudyPurpose(filteredSearch, studyPurposeFilter);
	    	filteredSearch = filterCourse(filteredSearch, courseFilter);
			new SearchResults(user, filteredSearch);
			resp.sendRedirect("/search.jsp");
		}
	}
	
	public static ArrayList<StudySession> filterGroupSize(ArrayList<StudySession> studySessions, int groupSizeFilter) {
		if (groupSizeFilter != -1) {
			ArrayList<StudySession> filteredSessions = new ArrayList<StudySession>();
			for (StudySession studySession : studySessions){
				if ((groupSizeFilter - 1 <= studySession.getGroupSize()) && (studySession.getGroupSize() <= groupSizeFilter + 1)) {
					filteredSessions.add(studySession);
				}
			}
			return filteredSessions;
		} else {
			return studySessions;
		}
		
	}
	
	public static ArrayList<StudySession> filterStudyStyle(ArrayList<StudySession> studySessions, String studyStyleFilter) {
		if (!studyStyleFilter.equals(" No Preference ")) {
			ArrayList<StudySession> filteredSessions = new ArrayList<StudySession>();
			for (StudySession studySession : studySessions){
				if (studySession.getStudyStyle().equals(studyStyleFilter)) {
					filteredSessions.add(studySession);
				}
			}
			return filteredSessions;
		} else {
			return studySessions;
		}
		
	}
	
	public static ArrayList<StudySession> filterStudyPurpose(ArrayList<StudySession> studySessions, String studyPurposeFilter) {
		if (!studyPurposeFilter.equals(" No Preference ")) {
			ArrayList<StudySession> filteredSessions = new ArrayList<StudySession>();
			for (StudySession studySession : studySessions){
				if (studySession.getStudyStyle().equals(studyPurposeFilter)) {
					filteredSessions.add(studySession);
				}
			}
			return filteredSessions;
		} else {
			return studySessions;
		}
		
	}
	
	public static ArrayList<StudySession> filterCourse(ArrayList<StudySession> studySessions, String courseFilter) {
		if (!courseFilter.equals(" No Preference ")) {
			ArrayList<StudySession> filteredSessions = new ArrayList<StudySession>();
			for (StudySession studySession : studySessions){
				if (studySession.getCourse().equals(courseFilter)) {
					filteredSessions.add(studySession);
				}
			}
			return filteredSessions;
		} else {
			return studySessions;
		}
		
	}
}
