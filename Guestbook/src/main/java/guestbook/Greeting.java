package guestbook;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

 

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;

 

 

@Entity

public class Greeting implements Comparable<Greeting> {

	public static boolean showAll = false;
	
	static {

        ObjectifyService.register(Greeting.class);

    }
    @Id Long id;

    User user;
    
    String title;

    String content;

    Date date;

    private Greeting() {}

    public Greeting(User user, String title, String content) {

        this.user = user;
        
        this.title = title;

        this.content = content;

        date = new Date();

    }

    public User getUser() {

        return user;

    }

    public String getTitle() {
    	
    	return title;
    	
    }
    
    public String getContent() {

        return content;

    }
    
    public String getDate() {
    	
    	DateFormat df = new SimpleDateFormat("MM/dd/yy");
    	return df.format(date);
    	
    	
    }

    @Override

    public int compareTo(Greeting other) {

        if (date.after(other.date)) {

            return 1;

        } else if (date.before(other.date)) {

            return -1;

        }

        return 0;

    }

}