# Terpal
A tool to help newbie terps easily find the buildings where their classes will be held @UMD.

<a name="br1"></a>**CMSC436 Group Project Final Report**

**Project Team 8:**

Tanmay Prakash, Justin DeVito, Uyen Nguyen, Boming Lyu, Kimberly Juliano

**Overview**

Many freshman students struggle navigating a UMD which is a large campus and is only getting

larger. The first few weeks can be difficult to locate your classes and their respective buildings.

Some students even forget class altogether. Our app TerpPal seeks to solve this problem. TerpPal

allows students to make their semester schedule, notify them ahead of time(given how ahead

they want to be notified), and provide them directions from their current location to their next

class.

**Goals**

The primary goal of TerPal is to create a tool to help newbie terps easily find the buildings where

their classes will be held. Below are some features that we want the app to have:

(1) Students can add courses to the main view with the default or custom colors of users'
 choices. Beside that, the app allows students to set up a notification reminder for some
 amount of minutes before their class time.

(2) Users are able to delete the courses.

(3) The app will provide directions to classroom buildings using the latitude and longitude
 data for campus buildings from umd.io. We prefer to accomplish this by linking the user
 to the device’s default maps app).

(4) The app also contains a dark mode toggle in the settings that allows users to change the

color scheme manually.




<a name="br2"></a>(5) The app includes a view that gives the information about the developers and displays the
 app logo with an animation of a turtle representing Testudo.

(6) The app’s visual appearance can be enhanced with styles and colors.

**User Interactions**

The first user interaction to demonstrate is adding a course. Upon opening the app for the

first time, the user will be shown this screen. The user can select the “+” icon to be shown

the fields to fill in that correspond to their course, which is shown below.

The “Code,” “Section,” and “Building” sections are all text fields. The user simply needs

to type in their course code, section and building code and TerPal will recognize the text.




<a name="br3"></a>Next, we have our color picker, which will give our course a background color when it is

displayed with the rest of the users' courses. Below are all of the ways a user can choose

their color.

Under that we have the notification options. The user can toggle between having a

reminder notification or not having a reminder notification. If the reminder notification is

toggled on, it will then allow the user to choose a time. For the user to choose their time

they can add or subtract with the “+” and “-” buttons, which increment by 5. When the

reminder notification is toggled on, the user will receive a notification the specified

amount of minutes before their class starts, that their class is starting.



<a name="br4"></a>Lastly we have the class times section. We can add a class time by choosing “+ add class

time.” Then the menu shown below will appear, and the user can choose what day of the

week and time their class occurs from a dropdown menu. If the class occurs more than

once a week, the user can add another day of the week and time combination by pressing

the “+ add class time” button again. The user can additionally remove the time by

pressing the “-” next to their inputted course.

When the user is done, they can press “Done” and their course will be added to their

course list. The user can do this for as many courses as they are taking.




<a name="br5"></a>Pressing the building code shown with their course will bring the user to the “Apple Maps”

application, and automatically direct them from their current location to the building their class is

in.

If the user makes a mistake when inputting their course, or wants to change the course color, they

can press the edit button in the top left corner. This will allow them to delete the course and

create a new one with their edited fields.



<a name="br6"></a>When the user presses “Done” their course list will return to normal with their saved changes.

Next, if a user presses the gear icon on the top right next to the “+” icon, it will bring them to the

settings menu. In this menu they can turn on dark mode, similar to the dark mode available in

Apple’s iPhone user settings. Dark mode can be toggled on and off at any time via the settings

menu.

Finally, if the user presses the TerPal icon in the middle of the navigation bar will reveal

an animation, along with the names of our group members.




<a name="br7"></a>**Development Process**

TerPal was developed outside of class. Our team would meet occasionally on Zoom to discuss

progress and split up what we needed to achieve going forward. Our schedule for this work was

determined mostly by the due dates for the milestones, and development sped up as those

deadlines approached.

We first tried to create an app with basic views in Milestone One. In doing so, we implemented

the ContentView with two static buttons (Edit and +) with a model of three initial courses

(“CMSC436”, “CMSC414”, “CMSC430”). To give users the ability to add courses using +, we

then implemented AddCourseView. AddCourseView has multiple fields allowing users to: (1)

enter the class code and its section; (2) select the semester of the course; (3) choose the color for

a course to differentiate it from other courses; (4) turn on/off the reminder; (5) set the time

duration for the reminder to pop up.

The first setback we encountered was a bug that caused the app to crash when we used an inline

navigation title and opened a Sheet view. This was ultimately fixed by just mimicking the look of

the title by placing a Text view in the same spot (which is now the TerPal button that leads to the

about view).

What we achieved from Milestone One was a static app that had the initially desired look but

could not actually let users add their course and other related information.. In Milestones Two

and Three, we wanted to make these features work. We deleted the semester field from

AddCourseView since we thought it was unnecessary. Students primarily want to find the

courses for the current semester instead of the previous or future semesters. We also modified the

view so that it could keep track of the notification time, which was supposed to send a reminder

notification at the specified time. To make the app look more appealing, we added the About

view to it. This view animates the team members’ names and Testudo. Also, we wanted to

determine the class time and the classroom’s location by using users’ input of class code and

section selected to retrieve the information provided by Testudo through the umd.io API.




<a name="br8"></a>However the API does not provide the capabilities we were expecting when interacting with it

through the app, and pulling data was slow. To still implement functionality while making the

functionality flexible to the user’s needs, we decided to just allow the user to manually input the

class times and building code for each course.

Finally, we tried to implement the pop-up of the default map, data persistence, and allow users to

delete a class from the list of their selection. This was time consuming because we did not

recognize Color is not codable, which led to the Course model not conforming to the protocol.

Fortunately, we found the bugs and were lucky to find a reference source which makes Color

codable and, thus, resolved the problem.

Through this development process we learned more about designing UI for iOS apps, and

specifically how to make it fit in with the expectations of an iOS user (i.e. edit button on top left,

plus button on top right). We learned more about creating forms, designing structures to store

input information, and making that data codable so it can be saved to UserDefaults. We also were

able to get more experience with software planning and collaboration, and using git / GitLab to

integrate what we each worked on separately. Although we did not have time to add more

advanced features to the app, we are satisfied that our team has tried our best and fortunately to

submit our product on time.

**Future Directions:**

We use umd.io as a source of information for retrieving building locations. However, this source

is not updated. For example, it does not have information about the location of IRB. We have to

look for the longitude and latitude of IRB from another website. Moreover, we do not know how

to interact with the data from the umd.io API through http request. This capability seems to

involve concurrency, which is going to be covered in the final modules of this course.

To deal with these two issues, we had to hard-code the building locations into the app based on

the information we had retrieved from umd.io and other websites. In the future, we will likely

resolve these issues with Core Data and concurrency.




<a name="br9"></a>Another unanticipated issue is the possibility of user’s incorrect/invalid input of a building code.

For example, “MAN” is an invalid input for building codes. If a user enters “MAN”, closes and

reopens the app, then the Content View will show the initial view. To deal with this issue, we set

“ESJ” as the default building code. In the future, we can add an Alert popup to notify the user of

an invalid input. An alternative solution is to leverage the Course Name and Section to determine

the building location based on the umd.io API. If this can be done, the app will no longer require

users to manually enter the building codes.

Beside that, the edit button now just allows the user to delete the entire course and information

related to it. Hence, if the user only wants to change one of the attributes related to a course, they

have to delete the entire course and re-add the course with the updated information. We wish to

give the user more flexibility for editing any attribute associated with a course.




<a name="br10"></a>Finally, implementing the push notification is one of the future goals. When we implemented the

app, we had not learned about FireBase. Therefore, it was challenging to implement the push

notifications feature. We believe after studying the next-to-last module, we will have enough

knowledge to make it work.
