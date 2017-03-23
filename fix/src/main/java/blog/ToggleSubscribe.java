/* WebApp URL: http://homework-1-159007.appspot.com/ 
	Matthew Edwards
	EID: mwe295
	Ahsan Khan
	EID: ajk2723
*/

package blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;


public class ToggleSubscribe extends HttpServlet {
		static{
			ObjectifyService.register(Subscriber.class);
		}
	public void doPost(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {
		if(req.getParameter("action").equals("subscribe")){
		
			String user = req.getParameter("subscriber");
		    Subscriber s = new Subscriber(user);
		    Date date = new Date();
		    s.id = date.getTime();
		    ofy().save().entity(s).now();
		}
		
		if(req.getParameter("action").equals("unsubscribe")){
			
			String user = req.getParameter("subscriber");
			Subscriber obj = null;
			List<Subscriber> subs = ObjectifyService.ofy().load().type(Subscriber.class).list();
			for(Subscriber s: subs){
				if(s.toString().equals(user)){
					obj = s;
					break;
				}
			}
			Key<Subscriber> k = Key.create(Subscriber.class, obj.id);
			ObjectifyService.ofy().delete().key(k).now();
		}
	    
	    
    resp.sendRedirect("/blog.jsp");

    }
}