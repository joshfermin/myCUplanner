![Alt text](/app/assets/images/myCUplannerLogo.png?raw=true)

### Project Info:
------

Authors: Josh Fermin and Louis Bouddhou

Project for Software Methods Engineering and Tools course, Spring 2014.

A web application that will be deployed to heroku to help computer science students at CU Boulder schedule their upcoming courses.

Is currently deployed by heroku at: https://mycuplanner.herokuapp.com/ 
Note: The app deployed on heroku may not be the same as the source code seen here (i.e. it was not pushed recently to heroku).

### Screenshots:
------
#### Sign Up Page:
![Alt text](/../ScreenshotsForREADME/app/assets/screenshots/SignUp.png?raw=true)

#### Select Courses Taken:
![Alt text](/../ScreenshotsForREADME/app/assets/screenshots/SelectCoursesTaken.png?raw=true)

#### Selecting Courses for next semester:
![Alt text](/../ScreenshotsForREADME/app/assets/screenshots/CoursesForNextSem.png?raw=true)

#### Sending those courses to Calendar:
![Alt text](/../ScreenshotsForREADME/app/assets/screenshots/SendToCalendar.png?raw=true)

#### Calendar View
![Alt text](/../ScreenshotsForREADME/app/assets/screenshots/CalendarView.png?raw=true)

### MVC:
------
* Models: 

	1. User Model:
		* Name
		* Email
		* Password-hash
		* Courses Previously Taken

	2. Course Model:
		* Course Number
		* Course Title
		* Instructor
		* Course Schedule
		* Course Prerequisites
		
	3. Events Model:
		* Event Title
		* Start / End Time
		* All day
		* Description


* Views:
	1. Log In View:
		* Simple log-in view

	2. Sign Up View:
		* Will allow users to sign up with their previous courses

	3. Class Diagram View:
		* A view that will show users a diagram of what they have completed and what they need to take

	4. User Home Page: Will include two partials:
		* Schedule View
		* Calendar Edit View

* Controllers:
	1. User controller
	2. Class/calendar controller
	3. Event Controller


