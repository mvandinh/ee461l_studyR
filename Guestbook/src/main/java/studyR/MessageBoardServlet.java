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

public class MessageBoardServlet extends HttpServlet {
	
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	    Ref<Profile> userProfileRef = ObjectifyService.ofy().load().type(Profile.class).id(user.getUserId());	// Grab User profile
	    Profile userProfile = userProfileRef.get();
		
	  
	    //update The study session
	    String messageText = req.getParameter("messageText");
		String studySessionId = req.getParameter("studySessionId");
		Ref<StudySession> studySessionRef = ObjectifyService.ofy().load().type(StudySession.class).id(studySessionId);
		StudySession studySession = studySessionRef.get();
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
	    String[] memberList = studySession.getMemberList().clone();
	    String[] messageList;
	    String[] messageNameList;
	    if(studySession.getMessageList() != null){
	    	messageList = new String[studySession.getMessageList().length + 1];
	    	messageNameList = new String[messageList.length];
	    	for(int i = 1; i < messageList.length; i++){
	    		messageList[i] = studySession.getMessageList()[i - 1];
	    		messageNameList[i] = studySession.getMessageNameList()[i - 1];
	    	}
	    }
	    else{
	    	messageList = new String[1];
	    	messageNameList = new String[1];
	    }
	    messageList[0] = messageText;
	    messageNameList[0] = user.getNickname();
	    String id = studySession.getId();
	    String sessionname = studySession.getName();
	    int currentNumMembers = studySession.getCurrentNumMembers();
	    ofy().delete().type(StudySession.class).id(studySessionId).now();
		StudySession replacement = new StudySession(name, description, startTime, duration, date, groupSize, studyStyle, studyPurpose, course, host, memberList, messageList, messageNameList, id, currentNumMembers - 1);
		ofy().save().entity(replacement).now();
		
		
		//update the profiles
		boolean member;
		messageText = ("[" + sessionname + "] " + user.getNickname() + ": " + req.getParameter("messageText"));
		List<Profile> profiles = ObjectifyService.ofy().load().type(Profile.class).list();
		for(Profile p: profiles){
			member = false;
			for(int i = 0; i < replacement.getCurrentNumMembers(); i++){
				if(replacement.getMemberList()[i].equals(p.getUserID()) && !(replacement.getMemberList()[i].equals(userProfile.getUserID()))){
					member = true;
					break;
				}
			}
			if(member){
				String userName = p.getName();
				String email = p.getEmail();
				String phone = p.getPhone();
				String bio = p.getBio();
				String timePrefs = p.getTimePrefs();
				String pgroupSize = p.getGroupSize();
				String groupLongevity = p.getGroupLongevity();
				String userID = p.getUserID();
				String courses = p.getCourses();
				String[] recentMessages = new String[5];
				for(int i = 0; i < 4; i++){
					recentMessages[i + 1] = p.getRecentMessages()[i];
				}
				recentMessages[0] = messageText;
				Profile preplacement = new Profile(userName, email, phone, bio, courses, timePrefs, groupLongevity, pgroupSize, userID, recentMessages);
				
				ofy().delete().type(Profile.class).id(userID).now();
				ofy().save().entity(preplacement).now();
			}
		}
		resp.sendRedirect("/messageBoard.jsp");
	}

}