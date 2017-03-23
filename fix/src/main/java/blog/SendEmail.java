package blog;

import org.json.JSONException;
import org.json.JSONObject;

import com.googlecode.objectify.ObjectifyService;

import java.io.IOException;
import java.util.Date;
import java.util.Calendar;
import java.util.List;

import email.Sendgrid;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SendEmail extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp)

			throws IOException {
		List<Subscriber> subs = ObjectifyService.ofy().load().type(Subscriber.class).list();
		String content = generateEmail();
		if (content != null) {
			for (Subscriber s : subs) {
				Sendgrid mail = new Sendgrid("mathew41796@gmail.com", "skittle1");
				mail.setTo(s.toString()).setFrom("mathew41796@gmail.com")
						.setSubject("Daily Update from The Maw of the Dog Blog").setText("bruh").setHtml(content);
						
				try {
					mail.send();
					System.out.print("Email sent");
				} catch (JSONException e) {
					e.printStackTrace();
					System.out.print("Email not sent");
				}
			}
		}
		resp.sendRedirect("/blog.jsp");

	}

	private String generateEmail() {
		String message = "<h3>Here are the titles of the hottest new posts from The Maw of the Dog Blog:</h3><br>";
		int numNewPosts = 0;
		List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list();
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DAY_OF_YEAR, -1);
		Date yesterday = c.getTime();
		for (Post p : posts) {
			if (p.getDate().after(yesterday)) {
				message = message + "<blockquote><h2>" + p.getTitle() + "</h2></blockquote><br>";
				numNewPosts++;
			}
		}
		message = message
				+ "<br>Check out <a href=http://homework-1-159007.appspot.com/>the blog</a>! <small>To unsubscribe, log in and press the button on the home page.</small></br>";
		return numNewPosts > 0 ? message : null;
	}

}
