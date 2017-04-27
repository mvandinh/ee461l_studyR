package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Profile implements Serializable{
	
    @Id String id;
    public static HashMap<User, Profile> allUsers = new HashMap<User, Profile>();
    private String name;
    private String bio;
    private String email;
    private String phone;
    //This will need an @Embed tag when we actually get around to making the Course class
    private ArrayList<Course> courses;
    //@Embed Preferences preferences;
    private ArrayList<String> timePrefs;
	private String studyStyles;
	private String groupLongevity;
	private String groupSize;
    
	public Profile(){}
    
    //This should only be called if the user doesn't already have a saved profile.
    //The only scenario where a user should not have a saved profile is if they are a new user.
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
	
	//TODO should we have a copy constructor?
	public Profile( 
			String name, 
			String email, 
			String phone, 
			String bio, 
			ArrayList<Course> courses,
			ArrayList<String> timePrefs,
			String studyStyles,
			String groupLongevity,
			String groupSize,
			String id)
	{
		this.id = id;
		this.name = name;
		this.bio = bio;
		this.phone = phone;
		this.courses = courses;
		this.email = email;
		this.studyStyles = studyStyles;
		this.groupLongevity = groupLongevity;
		this.timePrefs = timePrefs;
		this.groupSize = groupSize;
	}
	
	public String getUserID(){
		return id;
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
	
	public boolean compareID(String toCompare){
		return id.equals(toCompare);
	}
	
	public ArrayList<String> getTimePrefs(){
		return timePrefs;
	}

	public void setTimePrefs(ArrayList<String> timePrefs) {
		this.timePrefs = timePrefs;
	}
	
	public String getStudyStyles() {
		return studyStyles;
	}

	public String getGroupLongevity() {
		return groupLongevity;
	}

	public void setGroupLongevity(String groupLongevity) {
		this.groupLongevity = groupLongevity;
	}

	public String getGroupSize() {
		return groupSize;
	}

	public void setGroupSize(String groupSize) {
		this.groupSize = groupSize;
	}
}
