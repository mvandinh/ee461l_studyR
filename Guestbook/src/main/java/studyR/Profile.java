package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.ArrayList;
import java.util.HashMap;
import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Profile {
	
    @Id String id;
    public static HashMap<User, Profile> allUsers = new HashMap<User, Profile>();
    private String name;
    private String bio;
    private String email;
    private String phone;
    private ArrayList<Course> courses;
    @Embed Preferences preferences;
    
    public Profile(){}
    
    
	public Profile(User user) {
		this.name = user.getNickname();
		this.bio = "";
		this.email = user.getEmail();
		this.phone = "";
		this.courses = null;
		allUsers.put(user, this);
		id = user.getUserId();
		ofy().save().entity(this).now();
	}
	//TODO make a copy constructor
	//TODO this constructor
	public Profile( 
			String name, 
			String email, 
			String phone, 
			String bio, 
			ArrayList<Course> courses,
			Preferences preferences,
			String id)
	{
		this.id = id;
		this.name = name;
		this.bio = bio;
		this.phone = phone;
		this.courses = courses;
		this.email = email;
		this.preferences = preferences;
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
	
	public Preferences getPreferences(){
		return preferences;
	}
	
	public boolean compareID(String toCompare){
		return id.equals(toCompare);
	}
}
