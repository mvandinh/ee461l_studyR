package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;

import org.joda.time.Period;

  
  
public class EditProfile extends HttpServlet {  

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String userName = req.getParameter("userName");
		String groupLongevity = req.getParameter("groupLongevity");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String bio = req.getParameter("bioText");
		String userID = req.getParameter("userID");
		ArrayList<ArrayList<String>> timePrefs = new ArrayList<ArrayList<String>>();
		//IMPORTANT: the 4 in the for-loop corresponds to the maximum number of time ranges users can input.
		//			 Change this value if we change the number of allowed time ranges.
		for(char i = '0'; i<'4'; i++){
			if(req.getParameter("select_" + i) != null){
				ArrayList<String> timePrefToAdd = new ArrayList<String>();
				timePrefToAdd.add(req.getParameter("select_" + i));
				timePrefToAdd.add(req.getParameter("firstTime_" + i));
				timePrefToAdd.add(req.getParameter("secondTime_" + i));		
				String blah = req.getParameter("firstTime_" + i);
				//Time test = new Period(req.getParameter("firstTime_" + i));
				timePrefs.add(timePrefToAdd);
			}
		}
		
		Profile replacement = new Profile(userID, userName, bio, email, phone, null);
		Profile other = new Profile();

		resp.sendRedirect("/userInterface.jsp");
	}
	
}

