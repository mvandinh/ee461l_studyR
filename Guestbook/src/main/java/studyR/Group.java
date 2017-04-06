package studyR;

import java.util.ArrayList;
import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Id;

public class Group{
	
	static { ObjectifyService.register(Group.class); }
	
	@Id Long id;
	private String name;
	private ArrayList<Profile> members = new ArrayList<Profile>();
	private String groupBio = "No bio available.";
	
	public Group(String name){
		this.name = name;
	}
	
	public Group(String name, String groupBio){
		this(name);
		this.groupBio = groupBio;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ArrayList<Profile> getMembers() {
		return members;
	}

	public void setMembers(ArrayList<Profile> members) {
		this.members = members;
	}

	public String getGroupBio() {
		return groupBio;
	}

	public void setGroupBio(String groupBio) {
		this.groupBio = groupBio;
	}
	
	
}