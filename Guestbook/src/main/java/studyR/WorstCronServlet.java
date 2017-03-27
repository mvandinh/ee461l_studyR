package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;
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

import com.google.appengine.labs.repackaged.org.json.JSONException;
import com.googlecode.objectify.ObjectifyService;
  
  
public class WorstCronServlet extends HttpServlet {  
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {           
		Sendgrid sendMe = new Sendgrid("minh.vandinh", "yolothejolo2014");
		ObjectifyService.register(StudySession.class);
		List<StudySession> posts = ObjectifyService.ofy().load().type(StudySession.class).list();
		List<StudySession> postsFinal = new ArrayList<StudySession>(); 
		Collections.sort(posts); 
		Date current = new Date(System.currentTimeMillis() - (24 * 60 * 60 * 1000));
		for (StudySession post : posts){
			if (post.date.after(current)){
				postsFinal.add(post);
			}
		}
		if (postsFinal.isEmpty()){
			return;
		}
		ObjectifyService.register(Email.class);
		List<Email> subscribers = ObjectifyService.ofy().load().type(Email.class).list();
		for (Email subscriber : subscribers) {
			sendMe.addTo(subscriber.getEmail());
		}
		sendMe.setFrom("m.vandinh@gmail.com");
		sendMe.setSubject("UPDATE: Minh and Ethan's Punderful Blog");
		String body = "POSTS FROM THE LAST 24 HOURS:\n\n";
		for (StudySession post : postsFinal){
			body += post.getTitle() + ": " + post.getContent() +"\n\n";
		}
		String header = body + "Check van-cranmer.appspot.com for new posts!\n Or, you can unsubscribe at van-cranmer.appspot.com/subscribe.jsp";
		sendMe.setText(header);
		try {
			sendMe.send();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }  
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// redirect to index if the user is trying to access directly this page
		Email email = new Email(req.getParameter("email"));
		boolean duplicate = false;
		ObjectifyService.register(Email.class);
		List<Email> subscribers = ObjectifyService.ofy().load().type(Email.class).list();
		for (Email subscriber: subscribers) {
			if (subscriber.getEmail().equals(email.getEmail())) {
				ObjectifyService.ofy().delete().type(Email.class).id(subscriber.id).now();
				duplicate = true;
				break;
			}
		}
		if (!duplicate) {
			ObjectifyService.ofy().save().entity(email).now();
		}
	    resp.sendRedirect("/ofyguestbook.jsp");
	}
  
}