package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.sql.Time;
import java.util.ArrayList;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;

  
public class EditProfile extends HttpServlet {  

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String userName = req.getParameter("userName");
		String groupLongevity = req.getParameter("groupLongevity");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String bio = req.getParameter("bioText");
		String userID = req.getParameter("userID");
		ArrayList<Period> timePrefs = new ArrayList<Period>();
		//IMPORTANT: the 4 in the for-loop corresponds to the maximum number of time ranges users can input.
		//			 Change this value if we change the number of allowed time ranges.
		for(char i = '0'; i<'4'; i++){
			if(req.getParameter("select_" + i) != null){
				//Start and end times need to be in miliseconds
				long timeStart = Integer.parseInt(req.getParameter("firstTimeMinute_" + i))*60*1000 +
								 ((req.getParameter("AmPmOne" + i)) == "PM" ? 12*60*60*1000 : 0);
				if(!req.getParameter("firstTimeHour_" + i).equals("12")){
					timeStart += Integer.parseInt(req.getParameter("firstTimeHour_" + i))*60*60*1000;
				}
				long timeEnd = Integer.parseInt(req.getParameter("SecondTimeMinute_" + i))*60*1000 +
						 	   ((req.getParameter("AmPmTwo" + i)) == "PM" ? 12*60*60*1000 : 0);
				if(!req.getParameter("SecondTimeHour_" + i).equals("12")){
					timeEnd += Integer.parseInt(req.getParameter("SecondTimeHour_" + i))*60*60*1000;
				}
				Period addPeriod = new Period(req.getParameter("select_" + i), new Time(timeStart), new Time(timeEnd));
			}
		}
		
		Profile replacement = new Profile(userID, userName, bio, email, phone, null);
		Profile other = new Profile();

		resp.sendRedirect("/userInterface.jsp");
	}
	
}

