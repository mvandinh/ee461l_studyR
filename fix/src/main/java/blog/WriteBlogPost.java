package blog;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
/* WebApp URL: http://homework-1-159007.appspot.com/ 
Matthew Edwards
EID: mwe295
Ahsan Khan
EID: ajk2723
*/

import com.google.appengine.api.users.UserServiceFactory;
import blog.Post;
import java.io.IOException;
import java.util.Date;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static com.googlecode.objectify.ObjectifyService.ofy;


public class WriteBlogPost extends HttpServlet {
		
	public void doPost(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {

		
    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();
    String content = req.getParameter("content");
    String title = req.getParameter("title");
    Date date = new Date();
    if((!title.equals(""))&&(!content.equals(""))&&(user!=null)){
    Post p = new Post(user, content, title);
    
    p.id = date.getTime();
    
    ofy().save().entity(p).now();
    }
    resp.sendRedirect("/blog.jsp");

    }
}