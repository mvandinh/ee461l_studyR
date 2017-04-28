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

import com.googlecode.objectify.Key;



//This Servlet gets the data from editProfile.jsp, creates a new Profile object,
//deletes the old corresponding Profile object, and saves the new one.
public class Deleter extends HttpServlet {  

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		List<Key<Profile>> deleteProfiles = ofy().load().type(Profile.class).keys().list();
		for(Key<Profile> k : deleteProfiles){
			ofy().delete().key(k);
		}
		List<Key<StudySession>> deleteSessions = ofy().load().type(StudySession.class).keys().list();
		for(Key<StudySession> k : deleteSessions){
			ofy().delete().key(k);
		}
		resp.sendRedirect("/logIn.jsp");
		return;
	}
	
}

