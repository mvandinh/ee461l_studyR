package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;



@Entity

public class StudySession implements Comparable<StudySession> {

	public static boolean showAll = false;

    @Id Long id;
    private String name;
    private String description;
    Date date;
    int groupSize;
    String studyStyle;
    String studyPurpose;
    @Embed private Course course;
    
    public StudySession(){}
    
    public StudySession(
    		String name, 
    		String description, 
    		Date date, 
    		Course course,
    		int groupSize,
    		String studyStyle,
    		String studyPurpose
    		) {
        this.name = name;
        this.description = description;
        this.date = date;
        this.course = course;
        this.groupSize = groupSize;
        this.studyStyle = studyStyle;
        this.studyPurpose = studyPurpose;
        ofy().save().entity(this).now();
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
    
    public int getGroupSize() {
    	return groupSize;
    }
    
    public String getStudyStyle() {
    	return studyStyle;
    }
    
    public String getStudyPurpose() {
    	return studyPurpose;
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
}