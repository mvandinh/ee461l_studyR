package studyR;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Date;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.google.appengine.api.users.User;

public class testStudyR {

	User user;
	Profile testProfile;
	StudySession studySession1;
	StudySession studySession2;
	StudySession studySession3;
	SearchResults searchResults;
	ArrayList<StudySession> allStudySessions;

	   @Before
	   // Informs JUnit that this method should be run before each test
	   public void setUp() {
		   user = new User("test@gmail.com", "gmail.com");
		   testProfile = new Profile("ProfileTest", "test@email.com", "123-456-7890", "testing testing 123", null, null, null, null, "0123", new String[5], null);
		   studySession1 = new StudySession("StudyTest1", "describe me", "11:00", "1", "EE302", new Date(), 5, "Quiet", "Homework", testProfile);
		   studySession2 = new StudySession("StudyTest2", "describe me", "11:00", "1", "EE302", new Date(), 5, "Loud", "Exam Review", testProfile);
		   studySession3 = new StudySession("StudyTest3", "describe me", "11:00", "1", "EE302", new Date(), 5, "Quiet", "Class Discussion", testProfile);
		   allStudySessions = new ArrayList<StudySession>();
		   allStudySessions.add(studySession1);
		   allStudySessions.add(studySession2);
		   allStudySessions.add(studySession3);
		   searchResults = new SearchResults(user, allStudySessions);
	   }

	   @After
	   // Informs JUnit that this method should be run after each test
	   public void tearDown() {
	       // No tear down needed for this test
	   }
	   
	   // UNIT TESTING
	   @Test
	   public void testProfile() {
		   assertFalse(testProfile == null);
	   }
	   
	   @Test
	   public void testStudySession() {
		   assertFalse(studySession1 == null);
		   assertFalse(studySession2 == null);
		   assertFalse(studySession3 == null);
	   }
	   
	   @Test
	   public void testSearchResults() {
		   assertFalse(searchResults == null);
	   }

}
