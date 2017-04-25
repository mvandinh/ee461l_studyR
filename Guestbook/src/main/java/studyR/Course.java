package studyR;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Id;

public class Course {

    @Id Long id;
	String courseName;
	int uniqueID;
	
	public Course(){
		id = (long) 0; //TODO change this obviously
		courseName = "UNTITLED";
		uniqueID = 0;
	}
	
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
