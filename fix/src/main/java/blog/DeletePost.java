/* WebApp URL: http://homework-1-159007.appspot.com/ 
	Matthew Edwards
	EID: mwe295
	Ahsan Khan
	EID: ajk2723
*/

package blog;

import com.googlecode.objectify.ObjectifyService;
import blog.Post;
import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class DeletePost extends HttpServlet {
		
	
    public void doPost(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {
    	
    	String postNum = req.getParameter("post");
		List<com.googlecode.objectify.Key<Post>> keys = ObjectifyService.ofy().load().type(Post.class).keys().list();
		com.googlecode.objectify.Key<Post> keyToDelete = keys.get(Integer.parseInt(postNum));
		ObjectifyService.ofy().delete().keys(keyToDelete).now();
	    resp.sendRedirect("/blog.jsp");
		
	}

}

