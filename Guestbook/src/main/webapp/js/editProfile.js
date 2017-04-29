//This function is from https://www.w3schools.com/howto/howto_js_tabs.asp
function openCity(evt, cityName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the link that opened the tab
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}

//This function is really long, but all it does is create a bunch of input fields.
function addTimeReference(loc, maxClicks, day, timeOne, AmPmOneReq, timeTwo, AmPmTwoReq){
	 var clicks = document.getElementById("clicks").innerHTML;
	 if(clicks < maxClicks){		
			var idNum = 0;
			for(var i = 0; i < maxClicks; i++){
				if(document.getElementById("select_" + i) == null){
					idNum = i;
					break;
				}
			}
		  	var br = document.createElement("br");
		  		br.id = "br_" + idNum;
		  	var select = document.createElement("select");
		  		select.id = "select_" + idNum;
		  		select.name = "select_" + idNum;
			    var mon = document.createElement("option");
			    	mon.text =	"Monday";
			    	mon.id = "Monday_" + idNum;
			    var tues = document.createElement("option");
			    	tues.text = "Tuesday";
			    	tues.id = "Tuesday_" + idNum;
			    var wednes = document.createElement("option");
			    	wednes.text = "Wednesday"
			    	wednes.id = "Wednesday_" + idNum;
			    var thurs = document.createElement("option");
			    	thurs.text = "Thursday";
			    	thurs.id = "Thursday_" + idNum;
			    var fri = document.createElement("option");
			    	fri.text =	"Friday";
			    	fri.id = "Friday_" + idNum;
			    var sat = document.createElement("option");
			    	sat.text =	"Saturday";
			    	sat.id = "Saturday_" + idNum;
			    var sun = document.createElement("option");
			    	sun.text = "Sunday";
			    	sun.id = "Sunday_" + idNum;
			    select.add(mon);
			    select.add(tues);
			    select.add(wednes);
			    select.add(thurs);
			    select.add(fri);
			    select.add(sat);
			    select.add(sun);
			    var dayOpts = select.options;
			    for(var i = 0; i < 7; i++){
			    	if(dayOpts[i].text == day){
			    		select.selectedIndex = i;
			    	}
			    }
		    var from = document.createElement("b");
		    	from.innerHTML = " from ";
		    	from.id = "from_" + idNum;
		    var firstTime = document.createElement("input");
		    	firstTime.id = "firstTime_" + idNum;
		    	firstTime.name = "firstTime_" + idNum;
		    	firstTime.value = timeOne;
		    	firstTime.type = "text";
		    	firstTime.pattern = "([0]?[0-9]|1[0-2]):[0-5][0-9]";
		    	firstTime.size = "5";
		  	var AmPmOne = document.createElement("select");
		  		AmPmOne.id = "AmPmOne_" + idNum;
		  		AmPmOne.name = "AmPmOne_" + idNum;
			  		var AmOne = document.createElement("option");
			  			AmOne.text = "AM"
			  		var PmOne = document.createElement("option");
			  			PmOne.text = "PM"
		  		AmPmOne.add(AmOne);
			  	AmPmOne.add(PmOne);
			    var AmPmOneOpts = AmPmOne.options;
			    for(var i = 0; i < 2; i++){
			    	if(AmPmOneOpts[i].text == AmPmOneReq){
			    		AmPmOne.selectedIndex = i;
			    	}
			    }
		    var to = document.createElement("b"); 		
		   		to.innerHTML = " to ";
		   		to.id = "to_" + idNum;
		    var secondTime = document.createElement("input");
		    	secondTime.id = "secondTime_" + idNum;
		    	secondTime.name = "secondTime_" + idNum;
		    	secondTime.value = timeTwo;
		    	secondTime.type = "text";
			    secondTime.pattern = "([0]?[0-9]|1[0-2]):[0-5][0-9]";
		    	secondTime.size = "5";
		  	var AmPmTwo = document.createElement("select");
		  		AmPmTwo.id = "AmPmTwo_" + idNum;
		  		AmPmTwo.name = "AmPmTwo_" + idNum;
		  		var AmTwo = document.createElement("option");
		  			AmTwo.text = "AM";
		  		var PmTwo = document.createElement("option");
		  			PmTwo.text = "PM";
		  		AmPmTwo.add(AmTwo);
			  	AmPmTwo.add(PmTwo);
			    var AmPmTwoOpts = AmPmTwo.options;
			    for(var i = 0; i < 2; i++){
			    	if(AmPmTwoOpts[i].text == AmPmTwoReq){
			    		AmPmTwo.selectedIndex = i;
			    	}
			    }
		    var deleteButton = document.createElement("button");
		   		deleteButton.id = idNum;
		   		deleteButton.type = "button";
		   		deleteButton.innerHTML = "delete time";
		   		deleteButton.onclick = function(){		   		
		   			var deleteThis = document.getElementById("from_" + deleteButton.id);
		   			deleteThis.parentNode.removeChild(deleteThis);
		   			deleteThis = document.getElementById("firstTime_" + deleteButton.id);
					deleteThis.parentNode.removeChild(deleteThis);
					deleteThis = document.getElementById("secondTime_" + deleteButton.id);
					deleteThis.parentNode.removeChild(deleteThis);		
					deleteThis = document.getElementById("br_" + deleteButton.id);
					deleteThis.parentNode.removeChild(deleteThis);
					deleteThis = document.getElementById("select_" + deleteButton.id);
					deleteThis.parentNode.removeChild(deleteThis);
					deleteThis = document.getElementById("to_" + deleteButton.id);
					deleteThis.parentNode.removeChild(deleteThis);
					deleteThis = document.getElementById("AmPmTwo_" + deleteButton.id);
					deleteThis.parentNode.removeChild(deleteThis);
					deleteThis = document.getElementById("AmPmOne_" + deleteButton.id);
					deleteThis.parentNode.removeChild(deleteThis);
					clicks = document.getElementById("clicks").innerHTML;
					clicks--;
					document.getElementById("clicks").innerHTML = clicks;
					this.parentNode.removeChild(this);					
		   		}
		    var nextLine = document.getElementById(loc);
		    nextLine.parentNode.insertBefore(br, nextLine.nextSibiling);
		    nextLine.parentNode.insertBefore(select, nextLine.nextSibiling);
		    nextLine.parentNode.insertBefore(from, nextLine.nextSibiling);
		    nextLine.parentNode.insertBefore(firstTime, nextLine.nextSibiling);
		    nextLine.parentNode.insertBefore(AmPmOne, nextLine.nextSibiling);
		    nextLine.parentNode.insertBefore(to, nextLine.nextSibiling);
		    nextLine.parentNode.insertBefore(secondTime, nextLine.nextSibiling);
		    nextLine.parentNode.insertBefore(AmPmTwo, nextLine.nextSibiling);
		    nextLine.parentNode.insertBefore(deleteButton, nextLine.nextSibiling);		    
		    clicks++
	        document.getElementById("clicks").innerHTML = clicks;
		  }
}

//TODO: do actual error checking (for phone numbers and time inputs)
function errorMessage(){
	if(document.getElementById("newLine") != null){
		var deleteThis = document.getElementById("newLine");
		deleteThis.parentNode.removeChild(deleteThis);
		deleteThis = document.getElementById("errorMessage");
		deleteThis.parentNode.removeChild(deleteThis);
	}
	var numberTimes = parseInt(document.getElementById("clicks").innerHTML);
	var timeStringOne, AmPmOneString, AmPmTwoString, timeTwoString, j, timeInMinsOne, timeInMinsTwo;
	var errorMessage = document.createElement("b");
	errorMessage.innerHTML = "";
	for (j = 0; j < numberTimes; j++){
		timeInMinsOne = 0;
		timeInMinsTwo = 0;
		timeStringOne = document.getElementById("firstTime_" + j).value;
		AmPmOneSelect = document.getElementById("AmPmOne_" + j);
		AmPmOneString = AmPmOneSelect.options[AmPmOneSelect.selectedIndex].text;
		timeTwoString = document.getElementById("secondTime_" + j).value;
		AmPmTwoSelect = document.getElementById("AmPmTwo_" + j);
		AmPmTwoString = AmPmTwoSelect.options[AmPmTwoSelect.selectedIndex].text;
		if(parseInt(timeStringOne.substring(0,2)) < 12){
			timeInMinsOne = 60*parseInt(timeStringOne.substring(0,2));
		}
		if(AmPmOneString == "PM"){
			timeInMinsOne += 12*60;
		}
		timeInMinsOne += parseInt(timeStringOne.substring(3,5));
		if(parseInt(timeTwoString.substring(0,2)) < 12){
			timeInMinsTwo = 60*parseInt(timeTwoString.substring(0,2));
		}
		if(AmPmTwoString == "PM"){
			timeInMinsTwo += 12*60;
		}
		timeInMinsTwo += parseInt(timeTwoString.substring(3,5));
		if(timeInMinsOne > timeInMinsTwo){
			errorMessage.innerHTML = "ERROR: One or more of your time preference ranges end before it begins.<br>";
		}
	}
	var cancelLoc = document.getElementById("cancel");
	var newLine = document.createElement("br");
	newLine.id = "newLine";
	errorMessage.id = "errorMessage";
	cancelLoc.parentNode.insertBefore(newLine, cancelLoc.nextSibiling);
	cancelLoc.parentNode.insertBefore(errorMessage, cancelLoc.nextSibiling);
	if(errorMessage.innerHTML.length > 1){
		return false;
	}
	return true;
}

function addCourse(coursesString){
	var idNum = 0;
	for(var i = 0; i < 5; i++){
		if(document.getElementById("course_" + i) == null){
			idNum = i;
			break;
		}
	}
	var insertLoc = document.getElementById("courseButton");
	var courses = document.getElementById("courses").innerHTML;
	var select = document.createElement("select");
	select.id = "course_" + idNum;
	select.name = "course_" + idNum;
	var courseList = coursesString.split("|");
	if(courses < 5){		
		for(var i = 0; i < courseList.length-1; i++){
		    var thisCourse = document.createElement("option");
		    thisCourse.text = courseList[i];
		    select.add(thisCourse);
		}
		var deleteButton = document.createElement("button");
		deleteButton.value = idNum;
   		deleteButton.id = "courseButton_" + idNum;
   		deleteButton.type = "button";
   		deleteButton.innerHTML = "delete course";
   		deleteButton.onclick = function(){		   		
   			var deleteThis = document.getElementById("course_" + deleteButton.value);
   			deleteThis.parentNode.removeChild(deleteThis);
   			var deleteThis = document.getElementById("newLineCourse_" + deleteButton.value);
   			deleteThis.parentNode.removeChild(deleteThis);
   			courses = document.getElementById("courses").innerHTML;
			courses--;
			document.getElementById("courses").innerHTML = courses;
			this.parentNode.removeChild(this);					
   		}
		courses++;
		document.getElementById("courses").innerHTML = courses;
		var newLineCourse = document.createElement("br");
		newLineCourse.id = "newLineCourse_" + idNum;
		insertLoc.parentNode.insertBefore(newLineCourse, insertLoc.nextSibiling);
		insertLoc.parentNode.insertBefore(select, insertLoc.nextSibiling);
		insertLoc.parentNode.insertBefore(deleteButton, insertLoc.nextSibiling);
	}
}

function addCourseQualified(coursesString, courseSelect){
	var idNum = 0;
	for(var i = 0; i < 5; i++){
		if(document.getElementById("course_" + i) == null){
			idNum = i;
			break;
		}
	}
	var insertLoc = document.getElementById("courseButton");
	var courses = document.getElementById("courses").innerHTML;
	var select = document.createElement("select");
	select.id = "course_" + idNum;
	select.name = "course_" + idNum;
	var courseList = coursesString.split("|");
	if(courses < 5){		
		for(var i = 0; i < courseList.length-1; i++){
		    var thisCourse = document.createElement("option");
		    thisCourse.text = courseList[i];	   
		    select.add(thisCourse);
		    if(courseSelect == courseList[i]){
		    	select.selectedIndex = i;
		    }
		}
		var deleteButton = document.createElement("button");
		deleteButton.value = idNum;
   		deleteButton.id = "courseButton_" + idNum;
   		deleteButton.type = "button";
   		deleteButton.innerHTML = "delete course";
   		deleteButton.onclick = function(){		   		
   			var deleteThis = document.getElementById("course_" + deleteButton.value);
   			deleteThis.parentNode.removeChild(deleteThis);
   			var deleteThis = document.getElementById("newLineCourse_" + deleteButton.value);
   			deleteThis.parentNode.removeChild(deleteThis);
   			courses = document.getElementById("courses").innerHTML;
			courses--;
			document.getElementById("courses").innerHTML = courses;
			this.parentNode.removeChild(this);					
   		}
		courses++;
		document.getElementById("courses").innerHTML = courses;
		var newLineCourse = document.createElement("br");
		newLineCourse.id = "newLineCourse_" + idNum;
		insertLoc.parentNode.insertBefore(newLineCourse, insertLoc.nextSibiling);
		insertLoc.parentNode.insertBefore(select, insertLoc.nextSibiling);
		insertLoc.parentNode.insertBefore(deleteButton, insertLoc.nextSibiling);
	}
}

//This prevents the form from submitting if you press enter
$(document).on("keypress", ":input:not(textarea)", function(event) {
    return event.keyCode != 13;
});


