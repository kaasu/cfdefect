**CFDefect is a ColdFusion  based bug/issue tracking system.**

## INTODUCTION: ##

I started this project after looking at Ray Camden's _Lighthouse Pro_ which I use at my day job. This project is essentially a replica of all the features of Lighthouse with different architecture. I wanted to experiment with different frameworks and provide CF community a sample application that can be useful for new comers and probably seasoned developers. The application uses a plethora of various frameworks, techniques and patterns which includes but not limited to Fusebox, ColdSpring, Reactor, AJAX, Aspect Oriented Programming, unobtrusive Javascript and various others.

## FEATURES: ##

Here is an overview of some features

  * Easy and simple to use.

  * Multiple project support.

  * Security - control access to project and administrator by user/group.

  * Assign bugs and track those througout the life cycle of an issue.

  * Customizable to add severities, project loci, statuses etc.

  * RSS feed for each project.

  * Email notifications.

  * Charts and reports in Excel + HTML format.

## TECHNICAL DETAILS. ##

I will try my best to summarize various part of this slightly complex application.

  * Fusebox was chosen as a Controller Framework, however application core is designed in such a manner that replacing Fusebox with Model-Glue or Mach-II will be quite trivial. Details on Fusebox can be found on its site which is listed under links.

  * ColdSpring is acting as the driving machinary for dependency injection and control all service components. Details about ColdSpring can be find on its site which is listed under links.

  * Reactor is the ORM framework that handles database transactions. Details on Reactor be foundd on its site which is listed under links.

  * Aspected Oriented Programming (AOP). In order to send emails notification, the AOP feature from ColdSpring is put into practice. An Around Advice is developed which acts around Issue Service.

  * Unobtrusive Javascript using behaviour.

  * Ajax using Javascript prototype library.

## FUTURE PLANS ##

As the time permits and based on user feedback, I am planning on adding more features.  Here is the first initial list

  * Allows multiple applications - similar to a blogging software that allows multiple blogs.

  * PDF reports using Apache FOP.

  * Translate application to Model-Glue/Mach-II/Flex.

  * Auto save on description boxes.

etc