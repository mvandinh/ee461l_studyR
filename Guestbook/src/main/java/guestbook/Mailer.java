package guestbook;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;  

import javax.mail.*;  
import javax.mail.internet.InternetAddress;  
import javax.mail.internet.MimeMessage;

import com.googlecode.objectify.ObjectifyService;  
  
public class Mailer {  
	
	@SuppressWarnings("deprecation")
	public static void send(){ 
	
		ObjectifyService.register(StudySession.class);
	
		List<StudySession> posts = ObjectifyService.ofy().load().type(StudySession.class).list();   
	
		Collections.sort(posts); 
		
		Date current = new Date();
		
		current.setDate(current.getDay() - 1);
		
		for (StudySession post : posts){
			if (post.date.before(current)){
				posts.remove(post);
			}
		}
		
		if (posts.isEmpty()){
			return;
		}
		
		ObjectifyService.register(Email.class);
	
		List<Email> subscribers = ObjectifyService.ofy().load().type(Email.class).list();   
		  
		//1st step) Get the session object    
		Properties props = new Properties();  
		props.put("mail.smtp.host", "mail.javatpoint.com");//change accordingly  
		props.put("mail.smtp.auth", "true");  
		  
		Session session = Session.getDefaultInstance(props);
		
		
		//2nd step: compose message  
		try {  
			
			String subject = "Daily updates from Minh and Ethan's punderful blog";	
			
			MimeMessage message = new MimeMessage(session);  
			
			message.setFrom(new InternetAddress("m.vandinh@gmail.com"));  
			
			for (Email subscriber : subscribers){
				message.addRecipient(Message.RecipientType.TO,new InternetAddress(subscriber.getEmail()));  
			}
			
			message.setSubject(subject);
			
			String body = "";
			/*
			for (Greeting post : posts){
				body.concat(post.getTitle() + ": " + post.getContent());
			}*/
			
			String header = body + "Check van-cranmer.appspot.com for new posts!\n Or, you can unsubscribe at van-cranmer.appspot.com/subscribe.jsp";
			
			message.setText(header,"text/html");  
		   
			//3rd step: send message 
			
			Transport.send(message);  
			  
		 } catch (MessagingException e) {  
		    throw new RuntimeException(e);  
		 }      
	}  
}  
