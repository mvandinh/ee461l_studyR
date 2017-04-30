package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Serialize;



@Entity

public class StudySession implements Comparable<StudySession> {
    @Id String id;
    String name;
    String description;
    String startTime;
    String duration;
    Date date;
    int groupSize;
    String studyStyle;
    String studyPurpose;
    String course;
    @Embed Profile host;
    String[] memberList;
    String[] messageList;
    String[] messageNameList;
    int currentNumMembers = 1;
    
    public StudySession(){}
    
    public StudySession(
    		String name, 
    		String description, 
    		String startTime,
    		String duration,
    		String course,
    		Date date,
    		int groupSize,
    		String studyStyle,
    		String studyPurpose, 
    		Profile host
    		) {
        this.name = name;
        this.description = description;
        this.startTime = startTime;
        this.duration = duration;
        this.course = course;
        this.groupSize = groupSize;
        this.studyStyle = studyStyle;
        this.studyPurpose = studyPurpose;
        this.host = host;
        this.date = date;
        this.memberList = new String[10];
        this.messageList = new String[0];
        this.messageNameList = new String[0];
        memberList[0] = host.getUserID();
        id = host.getUserID() + date;
    }
    
    // copy constructor
    public StudySession(
    	    String name,
    	    String description,
    	    String startTime,
    	    String duration,
    	    Date date,
    	    int groupSize,
    	    String studyStyle,
    	    String studyPurpose,
    	    String course,
    	    Profile host,
    	    String[] memberList,
    	    String[] messageList,
    	    String[] messageNameList,
    	    String id,
    	    int currentNumMembers
    	    ) {
        this.name = name;
        this.description = description;
        this.startTime = startTime;
        this.duration = duration;
        this.date = date;
        this.groupSize = groupSize;
        this.studyStyle = studyStyle;
        this.studyPurpose = studyPurpose;
        this.course = course;
        this.host = host;
        this.memberList = memberList;
        this.messageList = messageList;
        this.messageNameList = messageNameList;
        this.id = id;
        this.currentNumMembers = currentNumMembers + 1;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
    	return description;
    }
    
    public String getStartTime() {
        return startTime;
    }
    
    public String getDuration() {
        return duration;
    }
    
    public String getCourse() {
        return course;
    }
    
    public Date getRealDate() {
    	return date;
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
    
    public String[] getMemberList() {
    	return memberList;
    }
    
    public String[] getMessageList(){
    	return messageList;
    }
    
    public String[] getMessageNameList(){
    	return messageNameList;
    }
    
    public String getId() {
    	return id;
    }
    
    public int getCurrentNumMembers() {
    	return currentNumMembers;
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