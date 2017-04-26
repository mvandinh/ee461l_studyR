package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.HashSet;
import java.util.Set;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.*;

@Entity
public class Course {

    @Id String courseName;
	int uniqueID;
	
	public static Set<Course> courseList = new HashSet<Course>();
	
	public Course(){
		courseName = "UNTITLED";
		uniqueID = 0;
	}
	
	public Course(String courseName, int uniqueID) {
		this.courseName = courseName;
		this.uniqueID = uniqueID;
		courseList.add(this);
	}
	
	public String getCourseName() {
		return courseName;
	}
	
	public int getUniqueID() {
		return uniqueID;
	}
}
