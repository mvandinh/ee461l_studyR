package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.ArrayList;
import java.util.HashMap;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Id;

public class Profile {
	
    @Id Long id;
    public static HashMap<User, Profile> allUsers = new HashMap<User, Profile>();
    private String name;
    private String bio;
    private String email;
    private String phone;
    private ArrayList<Course> courses = new ArrayList<Course>();
    
    
	public Profile(User user) {
		this.name = user.getNickname();
		this.bio = "";
		this.email = user.getEmail();
		this.phone = "";
		this.courses = null;
		allUsers.put(user, this);
		ofy().save().entity(this).now();
	}
	
	public String getName() {
		return name;
	}
	
	public String getBio() {
		return bio;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public ArrayList<Course> getCourses() {
		return courses;
	}
}
