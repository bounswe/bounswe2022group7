# Table of Contents
* [Glossary](#glossary)
* [1\. Functional Requirements](#1-functional-requirements)
  * [1.1. User Requirements](#11-user-requirements)
    * [1.1.1. Sign Up](#111-sign-up)
    * [1.1.2. Sign In](#112-sign-in)
    * [1.1.3. Guest Users](#113-guest-users)
    * [1.1.4. Comments](#114-Comments)
    * [1.1.5. Events](#115-events)
    * [1.1.6. Copyright](#116-copyright)
    * [1.1.7. Account Verification](#117-account-verification)
    * [1.1.8. Bidding](#118-bidding)
    * [1.1.9. Home Page](#119-home-page)
    * [1.1.10. Profile Page](#1110-profile-page)
    * [1.1.11. Reporting and Blocking](#1111-reporting-and-blocking)
    * [1.1.12. Communications](#1112-communications)
    * [1.1.13. Annotations](#1113-annotations)
    * [1.1.14. Search and Filter](#1114-search-and-filter)
    * [1.1.15. Admin User](#1115-admin-user)

  * [1.2. System Requirements](#12-system-requirements)
    * [1.2.1. Registered User/Artist Data](#121-registered-userartist-data)
    * [1.2.2. Events](#122-events)
    * [1.2.3. Account Verification](#123-account-verification)
    * [1.2.4. Bidding](#124-bidding)
    * [1.2.5. Recommendation](#125-recommendation)
    * [1.2.6. Artistic Value Calculation](#126-artistic-value-creation)

* [2\. Non-Functional Requirements](#2-non-functional-requirements)
  * [2.1 Annotations](#21-annotations)
  * [2.2 Accessibility](#22-accessibility)
  * [2.3 Performance and Reliability](#23-performance-and-reliability)
  * [2.4 Security](#24-security)
  * [2.5 Legal and Ethical Issues](#25-legal-and-ethical-issues)

# Glossary
* **Artistic Values**: Determined based on an internal point system calculated using the user's various activities.
* **Guest User**: A user with restricted abilities who have not signed in to the platform.
* **Home Page**: The main page of the platform which welcomes the users. 
* **Interaction Level**: A number every user has, that is measured by the number of replies/shares the user has on the platform.
* **Physical Exhibitions**: Art exhibitions created by users with sufficient artistic value points that take place in a physical location. 
* **Online Galleries**: A collection of pieces of art created by users with sufficient artistic value points that take place on the online platform.
* **Popularity Level**: A number every user has that is measured by the number of followers, copyrighted items, and art exhibitions user has on the platform.
* **Registered User/Artist**: Users or artists who have signed in with an email address and password to the platform.
* **User Level**: A number every user has that is calculated by using the user's interaction and popularity levels.
* **Verified Account**: A user account verified on the user's demand according to the calculated artistic values.
* **Comment**: A comment of strings. It either represents a comment in comments section which belongs to an art item, an exhibition or a post on the discussion page


# 1. Functional Requirements

## 1.1 User Requirements

### 1.1.1. Sign Up
* 1.1.1.1: Guest users shall be able to register for an account by providing an email address and a password.
* 1.1.1.2: Duplicate email addresses shall not be accepted.
* 1.1.1.3: Guest users who are trying to sign up shall also pick a unique username to complete the registration process.
* 1.1.1.4: Duplicate usernames shall not be accepted.
* 1.1.1.5: Guest users could provide extra information while signing up, like name, surname, location, age.
* 1.1.1.6: Guest users shall choose their account type, "Artist" or a "Regular User".
* 1.1.1.7: Users shall be able to change their email address and password, anytime.
* 1.1.1.8: Users shall be able to delete their accounts without any requisites, anytime.

### 1.1.2. Sign In
* 1.1.2.1: Users shall be able to sign in using their email and password combination.
* 1.1.2.2: Users shall be able to sign out without a restriction.
* 1.1.2.3: Users shall be able to use "Remember Me" option when signing in. This way, they will automatically be signed in when they access the platform.

### 1.1.3. Guest Users
* 1.1.3.1: Guest Users shall be able to view profile pages, art items, pages of online/physical exhibitions.
* 1.1.3.2: Guest Users shall be able to use the search/filter functionality.
* 1.1.3.3: Guest Users shall not be able to make any changes in the state of the system.

### 1.1.4 Comments

* 1.1.4.1: Registered users and artists shall be able to view comments that belong to art items or exhibitions
* 1.1.4.2: Registered users and artists shall be able to create comments on the discussion page.
   * 1.1.4.2.1: Registered users and artists shall be able to edit their comments in the discussion page.
   * 1.1.4.2.2: Registered users and artists shall be able to remove their comments in the discussion page.


### 1.1.5 Events

* 1.1.5.1: Artists shall be able to arrange events by themselves or collaboratively.
* 1.1.5.2: Artists shall be able to edit events. 
  * 1.1.5.2.1: Artists shall be able to add collaborators to events.
  * 1.1.5.2.2: Artists shall be able to remove collaborators from events.
  * 1.1.5.2.3: Artists shall be able to edit event information (title, description, time, etc.).  
  * 1.1.5.2.4: Artists shall be able to edit event location in Physical Exhibitions.
  * 1.1.5.2.5: Artists shall be able to edit external platform links in Online Galleries.
* 1.1.5.3: Artists shall be able to remove events they created.
* 1.1.5.4: Artists shall be able to arrange **Online Galleries** using the platform.
   * 1.1.5.4.1: Artists shall be able to add art items to Online Galleries.
   * 1.1.5.4.2: Artists shall be able to remove art items from Online Galleries.
   * 1.1.5.4.3: Artists shall be able to indicate and link an outside platform for their Online Galleries if they choose to host it in another platform.
* 1.1.5.5: Artists shall be able to arrange **Physical Exhibitions** using the platform.
   * 1.1.5.5.1: Artists shall be able to mark event location in Physical Exhibitions via using geotagging. 
* 1.1.5.6: Users shall be able to indicate that their participation in the event.
* 1.1.5.7: Users shall be able to cancel their participation to a event.
* 1.1.5.8: Users shall be notified when an event is created by a followed artist.

### 1.1.6 Copyright

* 1.1.6.1: Artists shall be able to demand copyright protection for their art items
* 1.1.6.2: Users and artists shall be able to report infringements of copyright

### 1.1.7 Account Verification

* 1.1.7.1: Users shall be able to apply to be verified.

### 1.1.8 Bidding

* 1.1.8.1: Artists shall be able to sell their copyrighted art items with a bidding system.
* 1.1.8.2: Users and artists shall be able to bid for art items on the bidding system.
   * 1.1.8.2.1: An artist shall be able to determine a minimum limit that buyer can't bid below.
   * 1.1.8.2.2: Bidders shall not be able to bid below the last offer but can increase it.
* 1.1.8.3: If an artist accepts an offer given, s/he can put a deadline for the owner of the winning offer to complete the payment so that fake bids, bid rigging, etc. can be prevented.
* 1.1.8.4: Artists shall not be able to end the bidding by withdrawing the item and not selling it at all.

### 1.1.9 Home Page

* 1.1.9.1: The home page shall highlight the most popular artworks and events of the previous week as well as the events in the coming days that are highly anticipated by the users for the guests.
* 1.1.9.2: The home page shall be customized for registered users with upcoming events and artworks of the followed artists. 
* 1.1.9.3: Guest users shall be able to see popular artworks and events in the home page.

### 1.1.10 Profile Page

* 1.1.10.1 Followers and the users that a certain user follows shall be visible in his/her profile page.
* 1.1.10.2 The physical exhibitions/online galleries that a user is attending shall be visible in his/her profile page.
* 1.1.10.3 The profile page shall include name, surname, location, username and profile picture.
* 1.1.10.4 The profile page shall include the art items that the user has made a bid for.
* 1.1.10.5 The profile page shall include the verification status of the user.
* 1.1.10.6 The users shall be able to edit the information included in their profile pages.
* 1.1.10.7 Art items that an artist have shall be visible in his/her profile page.

### 1.1.11 Reporting and Blocking

* 1.1.11.1 Users shall be able to block any other user as they would like.
* 1.1.11.2 Users shall be able to unblock the users that they have previously blocked as they would like.
* 1.1.11.3 Users shall be able to report the art works and the artists for copyright infringement by filling the details about the original art work.

### 1.1.12 Communications
* 1.1.12.1: Registered users and artists shall be able to follow other users.
* 1.1.12.2: Registered users and artists shall be notified about activities done by followed users.

### 1.1.13 Annotations
* 1.1.13.1: Registered users shall be able to annotate text segments with corresponding links.
    * 1.1.13.1.2: Registered users shall be able to annotate text segments in replies in comments.
    * 1.1.13.1.3: Artists shall be able to annotate text segments in their own exhibition descriptions and online gallery descriptions.
    * 1.1.13.1.4: Artists shall be able to annotate text segments in their own art item descriptions.
* 1.1.13.2: Registered users shall be able to annotate various content by adding custom labels.
    * 1.1.13.2.1: Registered users shall be able to label discussion comments.
    * 1.1.13.2.2: Artists shall be able to label their own exhibition and online galleries.
    * 1.1.13.2.3: Artists shall be able to label their own art items.
* 1.1.13.3: Registered users shall be able to bookmark discussion comments, art items, exhibitions and online galleries.

### 1.1.14 Search and Filter
* 1.1.14.1: Guest and registered users shall be able to use the search bar to semantically search for exhibitions, art items, users, comments on the discussion page
* 1.1.14.2: Guest and registered users shall be able to filter the search results based on artist, location, date.

### 1.1.15 Admin User

* 1.1.15.1: Admin user shall be able to view the copyright infringement reports.
* 1.1.15.2: Admin user shall be able to accept or reject a copyright infringement report. When the report is accepted, the art item will be removed.
* 1.1.15.3: Admin user shall be able to remove events from the platform.
* 1.1.15.4: Admin user shall be able to remove replies from comments.

## 1.2 System Requirements

### 1.2.1 Registered User/Artist Data

* 1.2.1.1: System shall keep track of the artists followed by the user or artist.
* 1.2.1.2: System shall track certain activities and calculate **interaction level**. 
    * 1.2.1.2.1: Replies under comments shall be tracked.
    * 1.2.1.2.2: comments about exhibitions, online galleries, collections or pieces of art shall be tracked.
* 1.2.1.3: System shall keep track of *number of followers, number of copyrighted items and number of art exhibitions*. Using these data, system shall calculate a **popularity level**.
* 1.2.1.6: System shall enable or disable a user's certain activities according to the user's level.

### 1.2.2 Events

* 1.2.2.1: System shall keep track of the geotagging information of the physically held events. This information will be used to infer the location of the events by search engine.

### 1.2.3 Account Verification

* 1.2.3.1: When a user or an artist applies to be verified, system shall be able to verify their account based on calculated artistic values. (See the glossary for the definition of artistic values and the factors that affect the calculations.)

### 1.2.4 Bidding
* 1.2.4.1: System shall end the auction after some time, say 1 day

### 1.2.5 Recommendation

* 1.2.5.1: System shall be able to recommend users artworks or artists based on their activities
* 1.2.5.2: System shall be able to recommend the user events using the data about the events attended by the user.

### 1.2.6 Artistic Value Calculation
* 1.2.6.1: System shall calculate artistic values of its users so that additional functionalities are provided to those users who have sufficient artistic value.
    * 1.2.6.1.1: The artistic value calculations include the number of online galleries hosted and the interaction those online galleries have got
    * 1.2.6.1.2: The artistic value calculations include the number of physical exhibitions attended and the interest in those physical exhibitions
    * 1.2.6.1.3: The artistic value calculations include the number of artworks published on the online platform and the interaction those artworks have got
    * 1.2.6.1.4: The artistic value calculations include the participation in the discussions that take place on the online platform

* 1.2.6.2: Custom coefficients shall be used to calculate a user's activity points.


# 2\. Non-Functional Requirements

## 2.1 Annotations

* 2.1.1 Annotations shall comply with the [W3C Web Annotation Data Model](https://www.w3.org/TR/annotation-model/#annotations
).
* 2.1.2 Annotations shall follow [W3C standards](https://www.w3.org/TR/annotation-model/#annotations
).

## 2.2 Accessibility
* 2.2.1 Platform shall support English language.
* 2.2.2 Platform shall be accessible via a web browser and an android device.
    * 2.2.2.1 Platform shall support modern web browsers (Chrome, Opera, Safari, Firefox, Edge)
    * 2.2.2.2 Platform shall support Android version 10 or above.
    * 2.2.2.3 The size of android application should be less than 200MB.
* 2.2.3 The user interface of the platform (color theme, design etc.) shall not obscure the artworks displayed on the screen. The design shall emphasize and bring the displayed artworks into the forefront.

## 2.3 Performance and Reliability
* 2.3.1 The uptime shall be at least 99%.
* 2.3.2 The response time shall be as short as possible(maximum limit 3 sec).
* 2.3.3 The platform shall support at least 5000 users actively using it at the same time.
* 2.3.4 The platform shall have 85 percent maintainability for 24 hours.

## 2.4 Security
* 2.4.1 The platform shall support HTTPS protocol
* 2.4.2 The passwords of users shall be encrypted in the database
* 2.4.3 The password shall be at least 8 characters long, with at least 1 uppercase letter, 1 lowercase letter and 1 special symbol.
* 2.4.4 A verification email shall be sent for the verification of the user email address.

## 2.5 Legal and Ethical Issues
* 2.5.1 Usage of personal information should shall comply with the rules of [GDPR](https://gdpr.eu/) and [KVKK](https://www.kvkk.gov.tr/).
* 2.5.2 Users shall read and accept “Terms of Use” and “Privacy Policy” before signing up

