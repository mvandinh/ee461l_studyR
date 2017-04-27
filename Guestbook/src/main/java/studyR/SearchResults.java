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
    ArrayList<String> searchResultsId;
    
    public SearchResults(){}
    
    public SearchResults(User user, ArrayList<StudySession> filteredSearch) {
        this.user = user;
        this.searchResultsId = new ArrayList<String>();
        for (StudySession studySession : filteredSearch) {
        	this.searchResultsId.add(studySession.getId());
        }
        id = user.getUserId() + "_searchResults";
    }

    public ArrayList<String> getSearchResultsId() {
        return searchResultsId;
    }
    
    public String getId() {
    	return id;
    }
}