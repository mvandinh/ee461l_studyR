package studyR;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Id;

public class Course {

	static { ObjectifyService.register(Email.class); }
	
    @Id Long id;
	String courseName;
	int uniqueID;
	
	public Course(String courseName, int uniqueID) {
		this.courseName = courseName;
		this.uniqueID = uniqueID;
	}
	
	public String getCourseName() {
		return courseName;
	}
	
	public int getUniqueID() {
		return uniqueID;
	}
}
