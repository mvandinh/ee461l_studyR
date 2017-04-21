package studyR;

import java.util.ArrayList;
import java.util.Map;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Preferences{
	@Id String id;
	private ArrayList<String> timePrefs;
	private Map<String, Boolean> studyStyles;
	private String groupLongevity;
	private String groupSize;

	public Preferences(String id,
					   ArrayList<String> timePrefs,
					   String groupSize,
					   String groupLongevity,
					   Map<String, Boolean> studyStyles
					   ){
		this.id = id;
		this.timePrefs = timePrefs;
		this.studyStyles = studyStyles;
		this.groupLongevity = groupLongevity;
		this.groupSize = groupSize;
	}
	
	public Preferences(){}
	
	public ArrayList<String> getTimePrefs(){
		return timePrefs;
	}

	public void setTimePrefs(ArrayList<String> timePrefs) {
		this.timePrefs = timePrefs;
	}
	
	public Map<String, Boolean> getStudyStyles() {
		return studyStyles;
	}

	public void setStudyStyles(Map<String, Boolean> studyStyles) {
		this.studyStyles = studyStyles;
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
	
}
