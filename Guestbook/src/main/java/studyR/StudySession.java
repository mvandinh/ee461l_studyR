package studyR;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

 

import com.google.appengine.api.users.User;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;



@Entity

public class StudySession implements Comparable<StudySession> {

	public static boolean showAll = false;

    @Id Long id;
    private String name;
    private String description;
    Date date;
    private Course course;
    
    public StudySession(){
    	name = "UNTITLED";
    	description = "UNTITLED";
    	date = new Date();
    	course = new Course();
    	id = date.getTime(); // TODO We should make the ID something more random than the date
    }
    
    public StudySession(String name, String description, Date date, Course course) {
        this.name = name;
        this.description = description;
        this.date = date;
        this.course = course;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
    	return description;
    }
    
    public Course getCourse() {
        return course;
    }
    
    public String getDate() {
    	DateFormat df = new SimpleDateFormat("MM/dd/yy");
    	return df.format(date);
    }

    @Override
    public int compareTo(StudySession other) {
        if (date.after(other.date)) {
            return 1;
        } else if (date.before(other.date)) {
            return -1;
        }
        return 0;
    }

	public String getTitle() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getContent() {
		// TODO Auto-generated method stub
		return null;
	}

}