package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import studyR.Profile;
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;

//This Servlet gets the data from editProfile.jsp, creates a new Profile object,
//deletes the old corresponding Profile object, and saves the new one.
public class EditProfile extends HttpServlet {  

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String userName = req.getParameter("userName");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String bio = req.getParameter("bioText");
		ArrayList<String> timePrefs = new ArrayList<String>();
		//IMPORTANT: the 4 in the for-loop corresponds to the maximum number of time ranges users can input.
		//			 Change this value if we change the number of allowed time ranges as specified in editProfile.jsp.
		for(char i = '0'; i<'4'; i++){
			if(req.getParameter("select_" + i) != null){
				String day = req.getParameter("select_" + i);
				String timeStart = req.getParameter("firstTime_" + i);
				String AmPmOne = req.getParameter("AmPmOne_" + i);
				String timeEnd = req.getParameter("secondTime_" + i);
				String AmPmTwo = req.getParameter("AmPmTwo_" + i);
				timePrefs.add(day + ", " + timeStart + AmPmOne + " to " + timeEnd + AmPmTwo);
			}
		}
		String groupSize = req.getParameter("groupSize");
		if(groupSize == null){
			groupSize = "Any";
		}	
		String groupLongevity = req.getParameter("groupLongevity");
		//Map<String, Boolean> studyStyles = new HashMap<String, Boolean>();
		//studyStyles.put("Group Discussion",!(req.getParameter("Group Discussion") == null));
		//studyStyles.put("Practice Questions", !(req.getParameter("Practice Questions") == null));
		//studyStyles.put("Project Group", !(req.getParameter("Project Group") == null));
		//studyStyles.put("Exam Review", !(req.getParameter("Exam Review") == null));
		//String userID = req.getParameter("userID");
		Profile replacement = new Profile(userName, email, phone, bio, null, timePrefs, studyStyles, groupLongevity, groupSize, userID);
		
		ofy().delete().type(Profile.class).id(userID).now();
		ofy().save().entity(replacement).now();
		resp.sendRedirect("/userInterface.jsp");
	}
	
}

