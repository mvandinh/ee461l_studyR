package studyR;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

public class Search {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		ObjectifyService.register(StudySession.class);
		List<StudySession> studySessions = ObjectifyService.ofy().load().type(StudySession.class).list();
		Collections.sort(studySessions);
		
		// ADVANCED FILTERS
    	/*int groupSizeFilter = Integer.parseInt(req.getParameter("groupSize"));
    	String studyStyleFilter = req.getParameter("studyStyle");
    	String studyPurposeFilter = req.getParameter("studyPurpose");
    	int filter;
		for (StudySession studySession : studySessions){
			if (studySession.getStudyStyle().equals(studyStyleFilter)) {
				
			}
			if (studySession.getStudyPurpose().equals(studyPurposeFilter)) {
				
			}
		}*/
		resp.sendRedirect("/search.jsp");
	}
}
