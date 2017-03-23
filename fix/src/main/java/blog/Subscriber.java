/*  WebApp URL: http://homework-1-159007.appspot.com/ 
	Matthew Edwards
	EID: mwe295
	Ahsan Khan
	EID: ajk2723
*/

package blog;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity

public class Subscriber{

    @Id long id;

    String user;


    private Subscriber() {}

    public Subscriber(String user) {

        this.user = user;
    }
    
    
    public String getUser() {

        return user;

    }

    
    public String getId(){
    	return String.valueOf(id);
    }
    
    public String toString(){
    	return user;
    }

}