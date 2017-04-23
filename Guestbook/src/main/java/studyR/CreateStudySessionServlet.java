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

public class CreateStudySessionServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String groupName = req.getParameter("groupName");
		String className = req.getParameter("className");
		String day = req.getParameter("select");
		String timeStart = req.getParameter("firstTime");
		String AmPmOne = req.getParameter("AmPmOne");
		String timeEnd = req.getParameter("secondTime");
		String AmPmTwo = req.getParameter("AmPmTwo");
		
		
		resp.sendRedirect("/userInterface.jsp");
	}
}
