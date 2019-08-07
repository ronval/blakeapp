# README

This app requires 
ruby '2.3.3'
Postgress

Run "bundle" to install all the required gems
create the db with
"rails db:create"
"rails db:migrate" 
"rails db:seed"

To run the test just run "rspec" in the console within apps path/directory


When running seeding the DB is will 

create 4 teachers
1 subject
3 lesson with each having 3 sections
1 student who is enrolled in one subject
3 assignments for the student each having 3 assignment_chapters

You can add more teachers and classes and add lessons to new classes.


When doing things as a "teacher" the app set the teacher to the last teacher created
When doing things as a student it also uses the last student created. This is because its a simple app with out roles or authorization


The app covers PART 1, PART 2 and PART 3 of the task provided. 
I hope I have an app that satisfies these things.

Below is a video of the app in action. 

https://youtu.be/6_U7XzzAvRw

If you have any questions please let me know. Thank you for your time :)





