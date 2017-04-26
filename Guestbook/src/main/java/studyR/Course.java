package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.*;

@Entity
public class Course {

    @Id String courseName;
	int uniqueID;
	
	public Course(){
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
