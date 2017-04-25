package studyR;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Embed;
import com.googlecode.objectify.annotation.Entity;

import com.googlecode.objectify.annotation.Id;



@Entity

public class SearchResults {
    @Id String id;
    User user;
    @Embed private ArrayList<StudySession> searchResults;
    
    public SearchResults(){}
    
    public SearchResults(User user, ArrayList<StudySession> filteredSearch) {
        this.user = user;
        this.searchResults = filteredSearch;
        id = user.getUserId() + "_searchResults";
        Collections.sort(searchResults);
        ofy().save().entity(this).now();
    }

    public ArrayList<StudySession> getSearchResults() {
        return searchResults;
    }
}