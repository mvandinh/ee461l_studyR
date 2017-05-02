package studyR;

import java.sql.Time;

public class Period{
	private String day;
	private Time start;
	private Time end;
	
	public Period(String day, Time start, Time end){
		this.day = day; //Monday through Sunday
		this.start = start;
		this.end = end;
	}
	
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public Time getStart() {
		return start;
	}
	public void setStart(Time start) {
		this.start = start;
	}
	public Time getEnd() {
		return end;
	}
	public void setEnd(Time end) {
		this.end = end;
	}

	
}