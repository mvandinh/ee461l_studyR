package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;


public class Search extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
		ObjectifyService.register(StudySession.class);
		List<StudySession> studySessions = ObjectifyService.ofy().load().type(StudySession.class).list();
		Collections.sort(studySessions);
		ArrayList<StudySession> filteredSearch = new ArrayList<StudySession>();
		filteredSearch.addAll(studySessions);
		String groupSize = (req.getParameter("groupSize")).replaceAll("[\\s*|\\d*]", "");
		int groupSizeFilter;
		if (groupSize.equals("")) {
			groupSizeFilter = -1;
		} else {
			groupSizeFilter = Integer.parseInt(groupSize);
		}
    	String studyStyleFilter = req.getParameter("studyStyle");
    	String studyPurposeFilter = req.getParameter("studyPurpose");
    	filteredSearch = filterGroupSize(filteredSearch, groupSizeFilter);
    	filteredSearch = filterStudyStyle(filteredSearch, studyStyleFilter);
    	filteredSearch = filterStudyPurpose(filteredSearch, studyPurposeFilter);
		ofy().save().entity(new SearchResults(user, filteredSearch)).now();
		resp.sendRedirect("/search.jsp");
	}
	
	public static ArrayList<StudySession> filterGroupSize(ArrayList<StudySession> studySessions, int groupSizeFilter) {
		ArrayList<StudySession> filteredSessions = new ArrayList<StudySession>();
		if (groupSizeFilter != -1) {
			for (StudySession studySession : studySessions){
				if ((groupSizeFilter - 1 <= studySession.getGroupSize()) && (studySession.getGroupSize() <= groupSizeFilter + 1)) {
					filteredSessions.add(studySession);
				}
			}
		}
		return filteredSessions;
	}
	
	public static ArrayList<StudySession> filterStudyStyle(ArrayList<StudySession> studySessions, String studyStyleFilter) {
		ArrayList<StudySession> filteredSessions = new ArrayList<StudySession>();
		if (!studyStyleFilter.equals("No Preference")) {
			for (StudySession studySession : studySessions){
				if (studySession.getStudyStyle().equals(studyStyleFilter)) {
					filteredSessions.add(studySession);
				}
			}
		}
		return filteredSessions;
	}
	
	public static ArrayList<StudySession> filterStudyPurpose(ArrayList<StudySession> studySessions, String studyPurposeFilter) {
		ArrayList<StudySession> filteredSessions = new ArrayList<StudySession>();
		if (!studyPurposeFilter.equals("No Preference")) {
			for (StudySession studySession : studySessions){
				if (!studySession.getStudyStyle().equals(studyPurposeFilter)) {
					filteredSessions.add(studySession);
				}
			}
		}
		return filteredSessions;
	}
}
