package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;



@Entity

public class StudySession implements Comparable<StudySession> {
    @Id String id;
    private String name;
    private String description;
    Date date;
    int groupSize;
    String studyStyle;
    String studyPurpose;
    @Embed private Course course;
    @Embed Profile host;
    @Embed ArrayList<Profile> memberList = new ArrayList<Profile>();
    
    public StudySession(){}
    
    public StudySession(
    		String name, 
    		String description, 
    		Course course,
    		int groupSize,
    		String studyStyle,
    		String studyPurpose, 
    		Profile host
    		) {
        this.name = name;
        this.description = description;
        this.date = new Date();
        this.course = course;
        this.groupSize = groupSize;
        this.studyStyle = studyStyle;
        this.studyPurpose = studyPurpose;
        this.host = host;
        memberList.add(host);
        id = host.id + date;
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
    
    public Profile getHost() {
    	return host;
    }
    
    public ArrayList<Profile> getMemberList() {
    	return memberList;
    }
    
    public String getId() {
    	return id;
    }
    
    public void addMember(Profile addition) {
    	memberList.add(addition);
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