package studyR;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Email {
	
	static { ObjectifyService.register(Email.class); }
	
    @Id Long id;

	
	String email;
	
	public Email(){
		this.email = null;
	}
	
	public Email(String email){
		this.email = email;
	}
	
	public String getEmail(){
		return email;
	}
}
