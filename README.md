# README: myCUplanner
======

### Project Info:
------
Authors: Josh Fermin and Louis Bouddhou

Project for Software Methods Engineering and Tools course, Spring 2014.

A web application that will be deployed to heroku to help computer science students at CU Boulder schedule their upcoming courses.

### MVC:
------
* Models: 

...User Model:
..* Name
..* Email
..* Password-hash
..* Courses Previously Taken

...Course Model:
..* Course Number
..* Course Title
..* Instructor
..* Course Schedule
..* Course Prerequisites


* Views:
...Log In View:
..* Simple log-in view

...Sign Up View:
..* Will allow users to sign up with their previous courses

...Class Diagram View:
..* A view that will show users a diagram of what they have completed and what they need to take

...User Home Page: Will include two partials:
..* Schedule View
..* Calendar Edit View

* Controllers:
...User controller
...Class/calendar controller


