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
    private String courses;
    //@Embed Preferences preferences;
    private String timePrefs;
	private String groupLongevity;
	private String groupSize;
	private String[] recentMessages;
	private String[] privateMessages;
    
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
		this.recentMessages = new String[5];
		ofy().save().entity(this).now();
	}
	
	//TODO should we have a copy constructor?

	//TODO should we have a copy constructor?
	public Profile( 
			String name, 
			String email, 
			String phone, 
			String bio, 
			String courses,
			String timePrefs,
			String groupLongevity,
			String groupSize,
			String id,
			String[] recentMessages,
			String[] privateMessages)
	{
		this.id = id;
		this.name = name;
		this.bio = bio;
		this.phone = phone;
		this.courses = courses;
		this.email = email;
		this.groupLongevity = groupLongevity;
		this.timePrefs = timePrefs;
		this.groupSize = groupSize;
		this.recentMessages = recentMessages;
		this.privateMessages = privateMessages;
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
	
	public String getCourses() {
		return courses;
	}
	
	public boolean compareID(String toCompare){
		return id.equals(toCompare);
	}
	
	public String getTimePrefs(){
		return timePrefs;
	}

	public void setTimePrefs(String timePrefs) {
		this.timePrefs = timePrefs;
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
	
	public String[] getRecentMessages(){
		return recentMessages;
	}
	
	public String[] getPrivateMessages(){
		return privateMessages;
	}
}
