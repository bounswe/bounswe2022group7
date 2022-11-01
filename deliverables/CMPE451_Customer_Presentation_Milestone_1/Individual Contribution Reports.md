# Individual Contribution Reports

## Sabri Mete Akyüz

### Member

My name is Sabri Mete Akyuz . Contacts can be found on [my personal wiki page](https://github.com/bounswe/bounswe2022group7/wiki/Sabri-Mete-Akyüz). You can also find [my time tracking on the wiki](https://github.com/bounswe/bounswe2022group7/wiki/Sabri-Mete-Akyüz-(Effort-Tracking)).

### Responsibilities

- I am a member of the backend team. I worked on research and implementation. I also helped managing the backend team.

### Main Contributions

Before starting the project we decided to use Kotlin with Sprin Boot and MySql. To start the project, I created the backend branch with initial code for the backend. I created temporary databases for the backend team to test their code. I also looked into authentication/authorization and implemented authentication handling. I implemented the login and signup endpoints. Reviewed a lot of PRs and issues. 

Issues I opened:
- [#243 Revision of Requirements](https://github.com/bounswe/bounswe2022group7/issues/243)
- [#287 Implementation of endpoints that return Events and ArtItems](https://github.com/bounswe/bounswe2022group7/issues/287)
- [#299 Implementation of RegisteredUser Class](https://github.com/bounswe/bounswe2022group7/issues/299)
- [#305 Implementation of AccountInfo Class](https://github.com/bounswe/bounswe2022group7/issues/305)
- [#306 Update hardcoded endpoints from homepage controller](https://github.com/bounswe/bounswe2022group7/issues/306)
- [#323 Add JsonManagedReference and JsonBackReference Annotations](https://github.com/bounswe/bounswe2022group7/issues/323)

Issues I was assigned
- [#237 Update team members](https://github.com/bounswe/bounswe2022group7/issues/237)
- [#243 Revision of Requirements](https://github.com/bounswe/bounswe2022group7/issues/243)
- [#251 Backend Code Initialization](https://github.com/bounswe/bounswe2022group7/issues/251)
- [#259 Uploading Target File to the Backend Directory](https://github.com/bounswe/bounswe2022group7/issues/259)
- [#271 Implementation of Authentication Part](https://github.com/bounswe/bounswe2022group7/issues/271)
- [#273 [BACKEND] Research on built-in authentication](https://github.com/bounswe/bounswe2022group7/issues/273)
- [#308 Implementation of Login and Signup Endpoints](https://github.com/bounswe/bounswe2022group7/issues/308)
- [#310 Research on Inheritance and Hibernate Entegration](https://github.com/bounswe/bounswe2022group7/issues/310)
- [#341 [Backend] Disabling Token Requirement in Endpoints](https://github.com/bounswe/bounswe2022group7/issues/341)

Issues I reviewed
- [#243 Revision of Requirements](https://github.com/bounswe/bounswe2022group7/issues/243)
- [#287 Implementation of endpoints that return Events and ArtItems](https://github.com/bounswe/bounswe2022group7/issues/287)
- [#295 Fix: Unable to Save to Database](https://github.com/bounswe/bounswe2022group7/issues/295)
- [#299 Implementation of RegisteredUser Class](https://github.com/bounswe/bounswe2022group7/issues/299)
- [#305 Implementation of AccountInfo Class](https://github.com/bounswe/bounswe2022group7/issues/305)
- [#306 Update hardcoded endpoints from homepage controller](https://github.com/bounswe/bounswe2022group7/issues/306)
- [#323 Add JsonManagedReference and JsonBackReference Annotations](https://github.com/bounswe/bounswe2022group7/issues/323)
- [#344 [Backend] Recursion Problem in Art Items](https://github.com/bounswe/bounswe2022group7/issues/344)

### Pull Requests

- [#317](https://github.com/bounswe/bounswe2022group7/pull/317): With this PR, I implement authentication and authorization mechanism as well as login and signup endpoints. 
- [#342](https://github.com/bounswe/bounswe2022group7/pull/342): With this PR, I allowed everyone to send requests for generic endpoints.

### Additional Information

Since the backend code initialization is done on a new branch. Pull request was not needed. That's why related issue doesn't have a Pull request.


## Enes Aydoğduoğlu
### Member
My name is Enes Aydoğduoğlu. I am in the frontend development team. You can check out [my personal wiki page](https://github.com/bounswe/bounswe2022group7/wiki/Enes-Aydo%C4%9Fduo%C4%9Flu) and [my effort tracking page](https://github.com/bounswe/bounswe2022group7/wiki/Enes-Aydo%C4%9Fduo%C4%9Flu-(Effort-Tracking))

### Responsibilities
I have taken part in the frontend development of our project. I worked on research, documentation, and testing.

### Main Contributions
Since I was involved in the project this term, I first examined every document of the project on github. I reviewed the diagrams and contributed to the updating of the requirements. I create my wiki and effort tracking pages. I tried to add the event page on the frontend, but I could not add it successfully.
Issues:
- [Adding Event Page to frontend [#356]](https://github.com/bounswe/bounswe2022group7/issues/356)
- [Revising System Requirements [#254]](https://github.com/bounswe/bounswe2022group7/issues/254)
### Pull requests

### As Reviwers
- [#324](https://github.com/bounswe/bounswe2022group7/pull/324)
## Erim Erkin Doğan
### Member
My name is Erim Erkin Doğan, I am a senior student. My contact information can be found [my personal wiki page](https://github.com/bounswe/bounswe2022group7/wiki/Erim-Erkin-Do%C4%9Fan) and weekly updates can be found in my [tracking page](https://github.com/bounswe/bounswe2022group7/wiki/Erim-Erkin-Do%C4%9Fan-(Effort-Tracking)).

### Responsibilities
I am a member of frontend team. I worked on setting up infrastructure for our application (docker, deployment, ci/cd) in colloboration with both backend and frontend teams. 

### Main Contributions

I have generally worked on building, testing and researching infrastructure related tasks. I researched about Github ACtions, AWS and its technologies, serving backend and frontend from the same network with domains in mind. I have implemented CI and CD for both backend and frontend applications with Github Actions. I have setup database with AWS's RDS service, while setting automatic deployment with AWS ECS after pushing the built docker image to AWS ECR. For frontend and relaying API from a context path, I have setup NGINX to act as our webserver, serving frontend static files and reverse proxying the API.

As most of my tasks were around setting up initial infrastructure for deployment and testing my contribution to frontend was minimal, implementing the api integration and form validation for login and signup pages were my only contributions.

#### Significant issues:
- [Setting up AWS Deployment & CI/CD [#282]](https://github.com/bounswe/bounswe2022group7/issues/282): This issue is a "mega thread" for infrastructure setup for our application. I have decided on platforms, technologies and setup the infrastructure with them, resulting in a succesful deployment of our application.
- [[Frontend] Revise and connect signup and login to backend [#338]](https://github.com/bounswe/bounswe2022group7/issues/338): Implemented connection between sign-up and sign-in pages of frontend and backend application. Added form validation to sign-up and sign-in pages.

### Pull Requests
- [#276 Dockerization of backend application](https://github.com/bounswe/bounswe2022group7/pull/276): Took over and merged the dockerization of backend from Basak and implemented development and production images. Actively fixed bugs caused by different operating systems or architectures (arm64, amd64) before merging to ensure everyone could run the backend application.
- [#286 Merge docker implementation with frontend branch](https://github.com/bounswe/bounswe2022group7/pull/286): Implemented production and deployment images for frontend application. Created CI with Github Actions.
- [#346 [Frontend] Merge revised signup and signing pages to develop](https://github.com/bounswe/bounswe2022group7/pull/346): Integrated frontend's sign-in and sign-up pages with API. Added new fields for sign-up. Added form validation for login and signup forms.
- [#354 [Frontend] Merge configuration changes for AWS deployment](https://github.com/bounswe/bounswe2022group7/pull/354): Implemented and merged the AWS deployment configuration and CD setup for frontend application.
- [#355 [Backend] Merge docker and AWS deployment configurations](https://github.com/bounswe/bounswe2022group7/pull/355): Merged the AWS deployment configuration and CI/CD setup for backend deployment.


## M.Ekrem Gezgen

## Güney İzol
### Member
My name is Güney İzol. I am in the frontend development team. You can check out [my personal wiki page](https://github.com/bounswe/bounswe2022group7/wiki/G%C3%BCney-%C4%B0zol) and [my effort tracking page](https://github.com/bounswe/bounswe2022group7/wiki/G%C3%BCney-%C4%B0zol-(Effort-Tracking))

### Responsibilities
I have taken part in the frontend development of our project. I worked on various research, configuration, and development activities.

### Main Contributions
- Open our discord server for communication [#246](https://github.com/bounswe/bounswe2022group7/issues/246)
- Research frontend libraries and tools that would make us as productive as possible and suggested the findings to our teammates.
- Configure our frontend infrastructure so that other team members could have a head start in development. [#253](https://github.com/bounswe/bounswe2022group7/issues/253)
- Design and implement the home page layout. 
- Make the home page layout responsive so that it adapts to different screen sizes. [#272](https://github.com/bounswe/bounswe2022group7/issues?q=is%3Aissue+is%3Aclosed+assignee%3Aguneyizol)
- Review the backend design and make suggestions
- Fetch data from backend apis and display them on the home page. [#332](https://github.com/bounswe/bounswe2022group7/issues/332)
- Switch our development and build environment from parcel to Create-React-App, which uses webpack. ([relevant commit](https://github.com/bounswe/bounswe2022group7/pull/337/commits/5ebd0ed4ce67d1d583483da0f3605182d4c2e6bc))

### Pull requests
- Fetch data for home page [#337](https://github.com/bounswe/bounswe2022group7/pull/337)
### As Reviwers
- [#349](https://github.com/bounswe/bounswe2022group7/pull/349)
- [#289[(https://github.com/bounswe/bounswe2022group7/issues/289)

## Ali Can Milani

### Member

My name is Ali Can Milani. Contacts can be found on [my personal wiki page](https://github.com/bounswe/bounswe2022group7/wiki/Ali-Can-Milani). You can also find [my time tracking on the wiki](https://github.com/bounswe/bounswe2022group7/wiki/Ali-Can-Milani-(Effort-Tracking)).

### Responsibilities

- I am a member of the mobile team. I worked on research and implementation. 

### Main Contributions

We decided to use Flutter for the mobile development. I created the user interface of the login page. And i made the integrations of the home page with the endpoints.

Code related significant issues:
- [#280 Implementation of Login Page](https://github.com/bounswe/bounswe2022group7/issues/280): I implemented the login page UI of the mobile app and connected necessary page navigations.
- [#263 Implementation of Register Page](https://github.com/bounswe/bounswe2022group7/issues/263): I reviewed the registration page UI of the mobile app.
- [#351 Implement the Home page endpoint integrations](https://github.com/bounswe/bounswe2022group7/issues/351): I made the necessary connections to the get methods related to the home page. 

Management related significant issues:
- [#248 Review and Update the Use Case Diagram](https://github.com/bounswe/bounswe2022group7/issues/248): I updated the Use Case Diagram according to the updated requirements.
- [#304 Create Mobile Meeting Notes #3](https://github.com/bounswe/bounswe2022group7/issues/304): I took the meeting notes of the third mobile team meeting.

### Pull Requests
 
- [#281 Dev/android/loginpage](https://github.com/bounswe/bounswe2022group7/pull/281): I added the login page UI to the android branch.
- [#267 Mobile Register Page](https://github.com/bounswe/bounswe2022group7/pull/267): I reviewed and merge the register page UI to the android branch.
- [#362 Dev/android/home page](https://github.com/bounswe/bounswe2022group7/pull/362): I added the home page endpoint connections to the development branch.

## Başak Önder

### Member

My name is Başak Önder . Contacts can be found on [my personal wiki page](https://github.com/bounswe/bounswe2022group7/wiki/Başak-Önder). You can also find [my time tracking on the wiki](https://github.com/bounswe/bounswe2022group7/wiki/Başak-Önder-(Effort-Tracking))).

### Responsibilities

- I am a member of the backend team. I worked on research and implementation, and also debugging. 

### Main Contributions

I started to work on dockerization issue of backend and database. I researched about this topic and started to work on the structure. We finished and concluded this part successfully with Erkin. Before starting the project we decided to use Kotlin with Sprin Boot and MySql. I had no previous experienced with Kotlin. Hence, I researched about it and also took guide from other members of backend team about implementation. After this research and with this guidance, I implemented classes related to sign up/log in functions and home page. Also, implemented one endpoint about art items and a few endpoints to create data to database.

Issues I opened:
- [#257 Implementation of OnlineGallery and ArtItemInfo Classes](https://github.com/bounswe/bounswe2022group7/issues/257)
- [#259 Uploading Target File to the Backend Directory](https://github.com/bounswe/bounswe2022group7/issues/259)
- [#271 Implementation of Authentication Part](https://github.com/bounswe/bounswe2022group7/issues/271)
- [#301 Single Event Endpoint](https://github.com/bounswe/bounswe2022group7/issues/301)
- [#308 Implementation of Login and Signup Endpoints](https://github.com/bounswe/bounswe2022group7/issues/308)
- [#309 Fix: Remove wrong usage of cascade ](https://github.com/bounswe/bounswe2022group7/issues/309)

Issues I was assigned
- [#237 Update team members](https://github.com/bounswe/bounswe2022group7/issues/237)
- [#243 Revision of Requirements](https://github.com/bounswe/bounswe2022group7/issues/243)
- [#252 Backend Dockerization and Deployment to AWS](https://github.com/bounswe/bounswe2022group7/issues/252)
- [#278 Implementation of Visitor and Guest Classes](https://github.com/bounswe/bounswe2022group7/issues/278)
- [#299 Implementation of RegisteredUser Class](https://github.com/bounswe/bounswe2022group7/issues/299)
- [#302 Implement Single Art Item Endpoint](https://github.com/bounswe/bounswe2022group7/issues/302)
- [#305 Implementation of AccountInfo Class](https://github.com/bounswe/bounswe2022group7/issues/305)
- [#306 Update hardcoded endpoints from homepage controller](https://github.com/bounswe/bounswe2022group7/issues/306)
- [#310 Research on Inheritance and Hibernate Entegration](https://github.com/bounswe/bounswe2022group7/issues/310)
- [#323 Add JsonManagedReference and JsonBackReference Annotations](https://github.com/bounswe/bounswe2022group7/issues/323)
- [#344 [Backend] Recursion Problem in Art Items](https://github.com/bounswe/bounswe2022group7/issues/344)

Issues I reviewed
- [#247 Revising the Mock-ups](https://github.com/bounswe/bounswe2022group7/issues/247)
- [#250 Revisions on UML Class Diagram](https://github.com/bounswe/bounswe2022group7/issues/250)
- [#259 Uploading Target File to the Backend Directory](https://github.com/bounswe/bounswe2022group7/issues/259)
- [#271 Implementation of Authentication Part](https://github.com/bounswe/bounswe2022group7/issues/271)
- [#296 Fix Comment and Discussion Post structures](https://github.com/bounswe/bounswe2022group7/issues/296)
- [#301 Single Event Endpoint](https://github.com/bounswe/bounswe2022group7/issues/301)
- [#308 Implementation of Login and Signup Endpoints](https://github.com/bounswe/bounswe2022group7/issues/308)

### Pull Requests

- [#276](https://github.com/bounswe/bounswe2022group7/pull/276): With this PR, backend and database parts are dockerized.
- [#277](https://github.com/bounswe/bounswe2022group7/pull/277): With this PR, home-page related classes are implemented.
- [#300](https://github.com/bounswe/bounswe2022group7/pull/300): With this PR, registered user class is implemented.
- [#307](https://github.com/bounswe/bounswe2022group7/pull/307): With this PR, account info class is implemented.
- [#311](https://github.com/bounswe/bounswe2022group7/pull/311): With this PR, hard coded data is removed from the endpoints.
- [#322](https://github.com/bounswe/bounswe2022group7/pull/322): With this PR, endpoint that returns single art item is implemented.
- [#325](https://github.com/bounswe/bounswe2022group7/pull/325): With this PR, necessary key related with security is added to env variables.
- [#327](https://github.com/bounswe/bounswe2022group7/pull/327): With this PR, all backend related commits are merged to the develop branch.
- [#345](https://github.com/bounswe/bounswe2022group7/pull/345): With this PR, debug the nested loop bug related with JsonReferences.

### As Reviewer
- [#275](https://github.com/bounswe/bounswe2022group7/pull/275)
- [#303](https://github.com/bounswe/bounswe2022group7/issues/303)


### Additional Information

In addition to the work I have done for the milestone, I would like to learn  more in-depth knowledge about how to implement class diagram relations in Kotlin and about the Kotlin features has that facilitates our work. 

## Cahid Arda Öz

### Member

My name is Cahid Arda Öz and I am the communicator of group 7. Contacts can be found on [my personal wiki page](https://github.com/bounswe/bounswe2022group7/wiki/Cahid-Arda-%C3%96z). You can also find [my time tracking on the wiki](https://github.com/bounswe/bounswe2022group7/wiki/Cahid-Arda-%C3%96z-(Effort-Tracking)).

### Responsibilities

- I was the communicator of the team and I was responsible for communications with the TA.
- I am a member of the frontend team. I worked on research and implementation.

### Main Contributions

To start the project, I used the foundation created by Güney to format the project directory structure. I also looked into authentication and implemented authentication handling. I created the art item, sign up and sign in pages without functionality. Then I handled integration of art item page with the endpoints. In addition to the code, I contributed by helping new team members learn about the process.

Code related significant issues:
- [#268 Using Router in Frontend](https://github.com/bounswe/bounswe2022group7/issues/268): Güney had created the initial project files but there was a single route on the app. I used Router to manage more pages. I also changed folder structure of the project directory.
- [#290 Token Handling in the Frontend](https://github.com/bounswe/bounswe2022group7/issues/290): I learned about token handling in React and added token handling to our frontend.
- [#344 Recursion Problem in Art Items ](https://github.com/bounswe/bounswe2022group7/issues/344): I realised that there was a bug in the database usage. The backend team was aware of this issue and I provided some details about the problem.

Management related significant issues:
- [#242 Preparing Questions for the Customer Meeting](https://github.com/bounswe/bounswe2022group7/issues/242) and [#243 Revision of Requirements](https://github.com/bounswe/bounswe2022group7/issues/243): I worked with some of the new members in the team on the revision of requirements. They read the requirements and wrote their questions. I answered these questions and compiled some of their questions with other questions to prepare a question list. I also prepared an action item list for updating the requirements.

### Pull Requests

- [#269](https://github.com/bounswe/bounswe2022group7/pull/269): With this PR, I added the router implemenetation and the new folder structure.
- [#288](https://github.com/bounswe/bounswe2022group7/pull/288): With this PR, I added the static sign-up and sign-in pages.
- [#291](https://github.com/bounswe/bounswe2022group7/pull/291): With this PR, I added token handling to the frontend.
- [#324](https://github.com/bounswe/bounswe2022group7/pull/324): With this PR, we merged the changes we made in the frontend to the develop branch.

### Additional Information

In addition to the work I have done for the milestone, I wanted to learn about annotations and make sure that we will be able to implement them with our current tech stack in the frontend. I did some research, looked into several alternatives and tested them. I was able to verify that some of the tools are applicable and I planned next steps for annotation implementation. Details can be found in [#297](https://github.com/bounswe/bounswe2022group7/issues/297).

## Musa Şimşek

### Member

My name is Musa Şimşek. Contacts can be found on [my personal wiki page](https://github.com/bounswe/bounswe2022group7/wiki/Musa-Şimşek). You can also find [my time tracking on the wiki](https://github.com/bounswe/bounswe2022group7/wiki/Musa-Şimşek-(Effort-Tracking)).

### Responsibilities

- I am a member of the mobile team. I worked on research and implementation.

### Main Contributions

Before beginning to implementations, we decided to use Flutter on mobile app since one of the team members knows how to develop mobile apps in Flutter. After everyone in the mobile team learned the basics, we started to divide pages and I got profile page and made a research on [testing Flutter apps](https://github.com/bounswe/bounswe2022group7/wiki/Testing-Flutter-Apps), additionally. After implementing profile page, the first milestone was announced and I got the integration of the login page with backend.


Issues I opened:
- [#261 Research on Testing Fluttter Apps](https://github.com/bounswe/bounswe2022group7/issues/261)
- [#263 Implementation of Profile Page](https://github.com/bounswe/bounswe2022group7/issues/262)
- [#314 Integration of Login Page wtih Backend](https://github.com/bounswe/bounswe2022group7/issues/314)
- [#333 Update the App according to the new CurrrentUser Structure](https://github.com/bounswe/bounswe2022group7/issues/333)


Issues I was assigned
- [Revising the Mock-ups #247](https://github.com/bounswe/bounswe2022group7/issues/247)

Issues I reviewed
- [Add Widget Test for Register Page #359](https://github.com/bounswe/bounswe2022group7/issues/359)
- [Change Register Network Function According to Backend Endpoint #335](https://github.com/bounswe/bounswe2022group7/issues/335)
- [Test Mobile Application Functionality #334](https://github.com/bounswe/bounswe2022group7/issues/334)
- [Implement the Art Item page with endpoint integrations #331](https://github.com/bounswe/bounswe2022group7/issues/331)
- [Implement Event page with endpoint integrations #330](https://github.com/bounswe/bounswe2022group7/issues/330)
- [Implement Art Item and Event pages with endpoint integrations #316](https://github.com/bounswe/bounswe2022group7/issues/316)
- [Update the Register Page #294](https://github.com/bounswe/bounswe2022group7/issues/294)
- [[Mobile] Implement Home Page #265](https://github.com/bounswe/bounswe2022group7/issues/265)

### Pull Requests

- [[Mobile] Add Widget Test for Register Page #360](https://github.com/bounswe/bounswe2022group7/pull/360)
- [[Mobile] Merge Event Page integrations to Develop #348](https://github.com/bounswe/bounswe2022group7/pull/348)
- [final version of the login #340](https://github.com/bounswe/bounswe2022group7/pull/340)
- [Updated the Register Network Function According to Backend Implementation #336](https://github.com/bounswe/bounswe2022group7/pull/336)
- [Update register page #298](https://github.com/bounswe/bounswe2022group7/pull/298)
- [Dev/profilepage musa #279](https://github.com/bounswe/bounswe2022group7/pull/279)
- [Merge android/homepage to android #266](https://github.com/bounswe/bounswe2022group7/pull/266)

## Atilla Türkmen

### Member

My name is Atilla Türkmen. Contacts can be found on [my personal wiki page](https://github.com/bounswe/bounswe2022group7/wiki/Atilla-Türkmen). You can also find [my time tracking on the wiki](https://github.com/bounswe/bounswe2022group7/wiki/Atilla-Türkmen-(Effort-Tracking)).

### Responsibilities

- I am a member of the mobile team. I worked on research and implementation. I also helped managing the mobile team.

### Main Contributions

I have created the structure of the mobile Flutter application and generally created a foundation for my teammates' implementation. I have implemented register page UI and network connection with tests, form validators and implemented models and network connection for art item page. I also have implemented the class that stores user data in local storage and provides it to pages.

Code related significant issues:
- Register Form Implementation: [#263 Form Validators with Unit Tests](https://github.com/bounswe/bounswe2022group7/issues/263) [#294 Register Form UI](https://github.com/bounswe/bounswe2022group7/issues/294) [#318 Connecting Register Form to Backend](https://github.com/bounswe/bounswe2022group7/issues/318)
- Implementation of Storing User data in Local Storage: [#292 Save user data on login, user provider implementation](https://github.com/bounswe/bounswe2022group7/issues/292)
- Logout functionality with confirmation pop up: [#321](https://github.com/bounswe/bounswe2022group7/issues/321)
- Implementation of art item page network connection and models: [#339](https://github.com/bounswe/bounswe2022group7/issues/339)

Management related significant issues:
- [#241 Updating the Project Plan](https://github.com/bounswe/bounswe2022group7/issues/241): I worked on updating the project plan specifically about updating the tasks for the mobile team and estimating their time.

### Pull Requests

- [#267](https://github.com/bounswe/bounswe2022group7/pull/267): With this PR, I added the basic UI of the register page and validators with unit tests.
- [#293](https://github.com/bounswe/bounswe2022group7/pull/293): With this PR, I added the functionality for storing user information in local storage and providing it to pages.
- [#320](https://github.com/bounswe/bounswe2022group7/pull/320): With this PR, I connected the register form to backend endpoint.
- [#360](https://github.com/bounswe/bounswe2022group7/pull/360): With this PR, I added extra tests for register form.
- [#363](https://github.com/bounswe/bounswe2022group7/pull/363): With this PR, I added an .env file for storing our server connection information such as IP address and port number.

### Pull Requests I Reviewed

- [#281](https://github.com/bounswe/bounswe2022group7/pull/281): Reviewed login page UI implementation by Ali Can
- [#340](https://github.com/bounswe/bounswe2022group7/pull/340): Reviewed login page network implementation by Musa
- [#352](https://github.com/bounswe/bounswe2022group7/pull/352): Reviewed app name change by Atakan
- [#364](https://github.com/bounswe/bounswe2022group7/pull/364): Reviewed event page tests by Atakan
- [#365](https://github.com/bounswe/bounswe2022group7/pull/365): Reviewed art item page implementation by Atakan

## Can Atakan Uğur

### Member
I am a part of the Mobile Team in Group 7 and developing a collaborative art platform with my devoted team members. Feel free to get more information about me by [visiting my personal page](https://github.com/bounswe/bounswe2022group7/wiki/Can-Atakan-U%C4%9Fur). To have a general idea about my contributions, you may [check my effort tracking reports](https://github.com/bounswe/bounswe2022group7/wiki/Can-Atakan-U%C4%9Fur-(Effort-Tracking)).

### Responsibilities 
Although my main role is being a developer in the Mobile Team, I also took responsibilities on various fields. Those include planning our development, actively monitoring the designs for our implementation and our interactions with the customer. I also took the responsibility of being a presenter in our first Customer Presentation.

Apart from these fundamental responsibilities of mine, I participated in the discussions within the team and tried to be helpful for all of my friends. I have actively followed the development process, and been a participant of it. 

### Main Contributions

**Code Related Significant Issues**

1. Core Contributions:

* [Implement Home Page #265](https://github.com/bounswe/bounswe2022group7/issues/265)
* [Customize the Home Page for Guest Users #313](https://github.com/bounswe/bounswe2022group7/issues/313)
* [Implement Event page with endpoint integrations #330](https://github.com/bounswe/bounswe2022group7/issues/330)
* [Implement the Art Item page with endpoint integrations #331](https://github.com/bounswe/bounswe2022group7/issues/331)
* [Updating the App Name #350](https://github.com/bounswe/bounswe2022group7/issues/350)
* [Add tests for the Event Page #361](https://github.com/bounswe/bounswe2022group7/issues/361)


2. Significant Issue Conversations & Reviews:

* [Implementation of Profile Page #262](https://github.com/bounswe/bounswe2022group7/issues/262): Contributed via the discussions with Musa Şimşek.


**Management Related Significant Issues**

1. Core Contributions:

* [Review and update the Class Diagram #239](https://github.com/bounswe/bounswe2022group7/issues/239)
* [Review and update the Sequence Diagram for Annotations #240](https://github.com/bounswe/bounswe2022group7/issues/240)
* [Review and update the Project Plan #241](https://github.com/bounswe/bounswe2022group7/issues/241)
* [Fix Comment and Discussion Post structures #296](https://github.com/bounswe/bounswe2022group7/issues/296)
* [Preparing Deliverables for Milestone #329](https://github.com/bounswe/bounswe2022group7/issues/329)
* [Customer Meeting Presentation Preparation #353](https://github.com/bounswe/bounswe2022group7/issues/353) and being a presenter during the Customer Meeting Presentation.

2. Significant Issue Conversations & Reviews:

* [Review and Update Discussion Forum Sequence Diagram #245](https://github.com/bounswe/bounswe2022group7/issues/245#issuecomment-1277495036): Feedback about the Sequence Diagram revision.
* [Preparing Questions for the Customer Meeting #242](https://github.com/bounswe/bounswe2022group7/issues/242#issuecomment-1273758425): Feedback about the Customer Questions & recommendations.


### Pull Requests

* [Merge android/homepage to android #266](https://github.com/bounswe/bounswe2022group7/pull/266)
* [Merge changes in Android to Develop #328](https://github.com/bounswe/bounswe2022group7/pull/328)
* [[Mobile] Merge Event Page integrations to Develop #348](https://github.com/bounswe/bounswe2022group7/pull/348)
* [Merge app name updates into develop #352](https://github.com/bounswe/bounswe2022group7/pull/352)
* [Merge Event Page tests into Develop #364](https://github.com/bounswe/bounswe2022group7/pull/364)
* [Merge Art Item updates into Develop #365](https://github.com/bounswe/bounswe2022group7/pull/365)


### Pull Request Reviews

* [Dev/profilepage musa #279](https://github.com/bounswe/bounswe2022group7/pull/279#pullrequestreview-1153602119)
* [Implemented user provider #293](https://github.com/bounswe/bounswe2022group7/pull/293#pullrequestreview-1154478646)
* [Connected register form to backend #320](https://github.com/bounswe/bounswe2022group7/pull/320#pullrequestreview-1161024425)
* [Merge Changes in Frontend into Develop #324](https://github.com/bounswe/bounswe2022group7/pull/324#pullrequestreview-1161020804)
* [[Mobile] Add Widget Test for Register Page #360](https://github.com/bounswe/bounswe2022group7/pull/360#pullrequestreview-1162523766)
* [Dev/android/home page #362](https://github.com/bounswe/bounswe2022group7/pull/362#pullrequestreview-1162617659)
* [[Mobile] Added .env file for server configuration #363](https://github.com/bounswe/bounswe2022group7/pull/363#pullrequestreview-1162447300)


### Meetings

I had a **100% participation rate** in all General and Mobile Team meetings. Here are the meetings that I was the note-taker:

* Mobile Meeting #2 ([issue #285](https://github.com/bounswe/bounswe2022group7/issues/285))
* Mobile Meeting #1 ([issue #260](https://github.com/bounswe/bounswe2022group7/issues/260))
* General Meeting #1 ([issue #238](https://github.com/bounswe/bounswe2022group7/issues/238))


## Demet Yayla

### Member
I am Demet Yayla from group 7. We are working on an art platform that unite artists with art-lovers or rather anyone that has something to do related to art. I am on backend team for the product.

### Responsibilities
At the initial weeks, we worked on reviewing design documents and orientation of the group to more implementation-related work. We slightly changed the way we communicated, we decided on platforms and technological tools including languages we are to use. I helped new members of our team to orient with us. I periodically told them about how we proceed with things such as PR reviews, issues, meetings etc. There were four main items to review for design documents: UML class diagram, use case diagram, sequence diagrams, requirements. My partition in them was as follows:
-	I reviewed sequence diagram for discussion forum
-	I reviewed UML Class Diagram with Can Atakan Uğur
Other than that, generally speaking, most of my time spent was on inheritance related issues. During initialization for backend, I wrote initial backend entity classes. I also wrote the initial examples of controllers, initiated repositories. I helped with some bug fixes, searched really a lot on inheritance concept and how relational databases represent those, investigated paradigms. I searched a lot on hibernate annotations for relational database connections. I reviewed code.

### Main Contributions

Code Related Significant Issues:
-	[I created the initial entity classes for backend](https://github.com/bounswe/bounswe2022group7/issues/256)
-	[I wrote the endpoint that will return a single event with the id provided by frontend. If there is no such event in database with given id, endpoint will return nothing. The challenge here was to create an abstract class and connect two entity classes with this abstract class. The abstract class was not to be an entity class. Finding out the correct configuration of annotations was challenging](https://github.com/bounswe/bounswe2022group7/issues/301)
-	[We had problems connecting to database. I sensed that it had something to do with application.properties file. Also another error was popping up about database dialect. I found the correct configurations to be added to application.properties file and resolved the issue](https://github.com/bounswe/bounswe2022group7/issues/295)
-	[We have lists for entity classes interlaced. This requires usage of ManyToOne, OneToMany, OneToOne and ManyToMany annotations of Hibernate. We had to research and find the correct usages. The issue here is for this long-lasting attempt on research](https://github.com/bounswe/bounswe2022group7/issues/310)
-	[I did research on how to fix wrong usage of “cascade” type for many-to-many relations](https://github.com/bounswe/bounswe2022group7/issues/309)
-	[I researched about how to write integration tests for especially authenticated endpoints](https://github.com/bounswe/bounswe2022group7/issues/358)
- I was reviewer of following issues:
    - [Issue about single art item endpoint](https://github.com/bounswe/bounswe2022group7/issues/302)
    - [Bug fix about Json](https://github.com/bounswe/bounswe2022group7/pull/345)
    - [Issue about backend dockerization](https://github.com/bounswe/bounswe2022group7/issues/252)
- I was the owner of below PRs:
    - [PR about single event item endpoint](https://github.com/bounswe/bounswe2022group7/pull/319)
    - [PR about inheritance](https://github.com/bounswe/bounswe2022group7/pull/303)
    - [PR about homepage controller and endpoints](https://github.com/bounswe/bounswe2022group7/pull/275)

Management Related Significant Issues:
- I was selected as the backend team leader
- [Review and update class diagram with Can Atakan Uğur](https://github.com/bounswe/bounswe2022group7/issues/239)
- [Review and update Project Plan with team leaders and Can Atakan Uğur](https://github.com/bounswe/bounswe2022group7/issues/241)
- [Update Communication Plan](https://github.com/bounswe/bounswe2022group7/issues/244)
- [Review and update sequence diagram for Discussion forum](https://github.com/bounswe/bounswe2022group7/issues/245)
- [After the first backend meeting, update class diagram and requirements](https://github.com/bounswe/bounswe2022group7/issues/250)
- [Update the sequence diagram for discussion forum related to the latest modification on class diagram](https://github.com/bounswe/bounswe2022group7/issues/312)
- I was the notetaker for 2 backend meetings. We did three backend, three general team meetings so far and I attended them all. 
- [Review annotation sequence diagram](https://github.com/bounswe/bounswe2022group7/issues/240)
- Revision of [this issue](https://github.com/bounswe/bounswe2022group7/issues/329) about deliverables
- [Before milestone presentations, there were some pop-up mock data related requests to be injected to database related to art items and events. I worked on those](https://github.com/bounswe/bounswe2022group7/issues/347)
- Gave feedback on [this issue](https://github.com/bounswe/bounswe2022group7/issues/353) related to milestone presentations on Tuesday
- I will be one of the notetakers in milestone presentations

### Pull Requests
- [PR 319](https://github.com/bounswe/bounswe2022group7/pull/319)
- [PR 303](https://github.com/bounswe/bounswe2022group7/pull/303)
- [PR 275](https://github.com/bounswe/bounswe2022group7/pull/275)

### Pull Requests I Reviewed
- [PR 345](https://github.com/bounswe/bounswe2022group7/pull/345)
- [PR 345](https://github.com/bounswe/bounswe2022group7/pull/276)
