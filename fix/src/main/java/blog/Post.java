package blog;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

 

 

@Entity

public class Post implements Comparable<Post> {

    @Id long id;

    User user;

    String content;

    Date date;
    
    String title;
    


    private Post() {}

    public Post(User user, String content, String title) {

        this.user = user;

        this.content = content;
        
        this.title = title;
        
        this.date = new Date();


    }
    
    public Date getDate(){
    	return this.date;
    }
    
    public String getPostTime(){
    	return new SimpleDateFormat("MM-dd-yyyy").format(date);
    }
    
    public User getUser() {

        return user;

    }

    public String getContent() {

        return content;

    }
    
    public String getTitle() {

        return title;

    }
    

    @Override

    public int compareTo(Post other) {

        if (date.after(other.date)) {

            return 1;

        } else if (date.before(other.date)) {

            return -1;

        }

        return 0;

    }
    
    
    public String getId(){
    	return String.valueOf(id);
    }

}