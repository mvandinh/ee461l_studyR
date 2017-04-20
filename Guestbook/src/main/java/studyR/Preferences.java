package studyR;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class Preferences{
	private HashMap<String, ArrayList<Period>> timePrefs;
	private Map<String, Boolean> studyStyles;
	private String groupLongevity;
	private int groupSize;

	public Preferences(HashMap<String, ArrayList<Period>> timePrefs, 
					   Map<String, Boolean> studyStyles,
					   String groupLongevity,
					   int groupSize){
		this.timePrefs = timePrefs;
		this.studyStyles = studyStyles;
		this.groupLongevity = groupLongevity;
		this.groupSize = groupSize;
	}
	
	public HashMap<String, ArrayList<Period>> getTimePrefs(){
		return timePrefs;
	}

	public void setTimePrefs(HashMap<String, ArrayList<Period>> timePrefs) {
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

	public int getGroupSize() {
		return groupSize;
	}

	public void setGroupSize(int groupSize) {
		this.groupSize = groupSize;
	}
	
}
