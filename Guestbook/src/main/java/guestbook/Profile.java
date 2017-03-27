package guestbook;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Id;

public class Profile {

	static { ObjectifyService.register(Email.class); }
	
    @Id Long id;
	User user;
    String name;
    String bio;
    String email;
    String phone;
    Course[] courses;
    
	
	public Profile(User user) {
		this.user = user;
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
	
	public Course[] getCourses() {
		return courses;
	}
}
