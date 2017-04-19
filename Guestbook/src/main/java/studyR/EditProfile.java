package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.images.Image;
import com.google.appengine.labs.repackaged.org.json.JSONException;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
  
  
public class EditProfile extends HttpServlet {  

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String userName = req.getParameter("userName");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String bio = req.getParameter("bio");
		String userID = req.getParameter("userID");
		ArrayList<ArrayList<String>> timePrefs = new ArrayList<ArrayList<String>>();
		String blah = req.getParameter("select_0");
		for(char i = '0'; req.getParameter("select_" + i) != null; i++){
			ArrayList<String> timePrefToAdd = new ArrayList<String>();
			timePrefToAdd.add(req.getParameter("select_" + i));
			timePrefToAdd.add((req.getParameter("firstTime_" + i)).toString());
			timePrefToAdd.add((req.getParameter("secondTime_" + i)).toString());		
			timePrefs.add(timePrefToAdd);
		}

		
		
		
		
		
		resp.sendRedirect("/userInterface.jsp");
	}
	
}

