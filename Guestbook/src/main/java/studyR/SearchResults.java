package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.ArrayList;
import java.util.Collections;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Serialize;

@Entity

public class SearchResults {
    @Id String id;
    User user;
    @Embed ArrayList<StudySession> searchResults;
    
    public SearchResults(){}
    
    public SearchResults(User user, ArrayList<StudySession> filteredSearch) {
        this.user = user;
        this.searchResults = new ArrayList<StudySession>(filteredSearch);
        id = user.getUserId() + "_searchResults";
        ofy().save().entity(this).now();
    }

    public ArrayList<StudySession> getSearchResults() {
        return searchResults;
    }
    
    public String getId() {
    	return id;
    }
}