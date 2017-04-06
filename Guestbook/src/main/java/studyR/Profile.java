package studyR;

import java.util.ArrayList;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Id;

public class Profile {

	static { ObjectifyService.register(Profile.class); }
	
    @Id Long id;
	private User user;
    private String name;
    private String bio;
    private String email;
    private String phone;
    private ArrayList<Course> courses = new ArrayList<Course>();
    
    
	public Profile(User user) {
		this.user = user;
		this.name = "";
		this.bio = "";
		this.email = "";
		this.phone = "";
		this.courses = null;
	}
	
	public User getUser() {
		return user;
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
	
	public String getphone() {
		return phone;
	}
	
	public ArrayList<Course> getCourses() {
		return courses;
	}
}
