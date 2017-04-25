package studyR;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;


public class Search {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
		ObjectifyService.register(StudySession.class);
		List<StudySession> studySessions = ObjectifyService.ofy().load().type(StudySession.class).list();
		Collections.sort(studySessions);
		ArrayList<StudySession> filteredSearch = new ArrayList<StudySession>();
		
    	int groupSizeFilter = Integer.parseInt(req.getParameter("groupSize"));
    	String studyStyleFilter = req.getParameter("studyStyle");
    	String studyPurposeFilter = req.getParameter("studyPurpose");
    	if (studyStyleFilter.equals("No Preference") && (studyPurposeFilter.equals("No Preference"))) {	// No Preferences Set
    		
    	}
		for (StudySession studySession : studySessions){
			if (!studySession.getStudyStyle().equals(studyStyleFilter)) {
				continue;
			}
			if (!studySession.getStudyPurpose().equals(studyPurposeFilter)) {
				continue;
			}
			if (!((groupSizeFilter + 1 <= studySession.getGroupSize()) && (studySession.getGroupSize() <= groupSizeFilter + 1))) {
				continue;
			}
			filteredSearch.add(studySession);
		}
		SearchResults searchResults = new SearchResults(user, filteredSearch);
		resp.sendRedirect("/search.jsp");
	}
	
	public ArrayList<StudySession> filterGroupSize(ArrayList<StudySession> studySessions, int groupSizeFilter) {
		for (StudySession studySession : studySessions){
		
		}
		return studySessions;
	}
}
