# List Of Contents

- [1. Group Milestone Review](#1-group-milestone-review)
  * [1.1. Executive Summary](#11-executive-summary)
  * [1.2. Summary of work performed by each team member](#12-summary-of-work-performed-by-each-team-member)
    + [Sabri Mete Akyüz](#sabri-mete-akyüz)
    + [Enes Aydoğduoğlu](#enes-aydoğduoğlu)
    + [Erim Erkin Doğan](#erim-erkin-doğan)
    + [Güney İzol](#güney-İzol)
    + [Ali Can Milani](#ali-can-milani)
    + [Başak Önder](#başak-önder)
    + [Cahid Arda Öz](#cahid-arda-öz)
    + [Musa Şimşek](#musa-şimşek)
    + [Atilla Türkmen](#atilla-türkmen)
    + [Can Atakan Uğur](#can-atakan-uğur)
    + [Demet Yayla](#demet-yayla)
  * [1.3. Progress According to Requirements](#13-progress-according-to-requirements)
  * [1.4. API Endpoints](#14-api-endpoints)
  * [1.5. User Interface & User Experience](#15-user-interface---user-experience)
  * [1.6. Annotations](#16-annotations)
  * [1.7. Standards](#17-standards)
  * [1.8. Scenarios](#18-scenarios)
- [2. Project Artifacts](#2-project-artifacts)
  * [2.1. Manuels](#21-manuels)
  * [2.2. Software Requirements Specification](#22-software-requirements-specification)
  * [2.3. Software Design Documents](#23-software-design-documents)
  * [2.4. User Scenarios And Mockups](#24-user-scenarios-and-mockups)
  * [2.5. Project Plan](#25-project-plan)
  * [2.6. Unit Tests](#26-unit-tests)
- [3. Individual Contribution Reports](#3-individual-contribution-reports)
  * [Sabri Mete Akyüz](#sabri-mete-akyüz-1)
  * [Enes Aydoğduoğlu](#enes-aydoğduoğlu-1)
  * [Erim Erkin Doğan](#erim-erkin-doğan-1)
  * [Güney İzol](#güney-İzol-1)
  * [Ali Can Milani](#ali-can-milani-1)
  * [Başak Önder](#başak-önder-1)
  * [Cahid Arda Öz](#cahid-arda-öz-1)
  * [Musa Şimşek](#musa-şimşek-1)
  * [Atilla Türkmen](#atilla-türkmen-1)
  * [Can Atakan Uğur](#can-atakan-uğur-1)
  * [Demet Yayla](#demet-yayla-1)

# 1. Group Milestone Review

## 1.1. Executive Summary

## 1.2. Summary of work performed by each team member

### Sabri Mete Akyüz

### Enes Aydoğduoğlu

### Erim Erkin Doğan

### Güney İzol

| Task | Link |
| --- | --- |
|  Try to implement web annotations service with different tools. (We decided that we didn't needed this so this issue was canceled) | [#570](https://github.com/bounswe/bounswe2022group7/issues/570) |
| Use the [Promise API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) more effectively in our web annotations implementation | [#591](https://github.com/bounswe/bounswe2022group7/issues/591) |
| Text annotations | [#594](https://github.com/bounswe/bounswe2022group7/issues/594) |
| Remove the unused tag field from the annotation editor | [#623](https://github.com/bounswe/bounswe2022group7/issues/623) |
| Fix bugs in annotations | [#631](https://github.com/bounswe/bounswe2022group7/issues/631) |
| Add web client interface screenshots to the final report | [Report section](https://github.com/bounswe/bounswe2022group7/blob/master/deliverables/CMPE451_Customer_Presentation_Milestone_Final/milestone_report.md#web) |
| Write the annotations part of the final report | [Report section](https://github.com/bounswe/bounswe2022group7/blob/master/deliverables/CMPE451_Customer_Presentation_Milestone_Final/milestone_report.md#16-annotations)
| Write the standards part of the final report | [Report section](https://github.com/bounswe/bounswe2022group7/edit/master/deliverables/CMPE451_Customer_Presentation_Milestone_Final/milestone_report.md#17-standards) |

### Ali Can Milani

### Başak Önder

### Cahid Arda Öz

### Musa Şimşek

### Atilla Türkmen

### Can Atakan Uğur

### Demet Yayla

## 1.3. Progress According to Requirements

## 1.4. API Endpoints

Can be found here: http://ideart.tk/api/swagger-ui/index.html#/

### Link to the API:
http://ideart.tk/api/

### Example Calls for API:
3 Core functionalties: signup, create art item, get events while surfing on homepage

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/23843320-7f0920be-e1e0-43bf-b3fe-81f8a8b0236a?action=collection%2Ffork&collection-url=entityId%3D23843320-7f0920be-e1e0-43bf-b3fe-81f8a8b0236a%26entityType%3Dcollection%26workspaceId%3Df5538b89-0ba7-43a8-82d7-6ef4ca2c35da)

To run the endpoints from Postman, following environment variables must be defined:
- userToken: required format is like this: "Bearer {TOKEN}". 
TOKEN should be obtained by signing up as Regular user
- artistToken: required format is like this: "Bearer {TOKEN}". 
TOKEN should be obtained by signing up as Artist user

## 1.5. User Interface & User Experience
### Web
- [Signup](https://github.com/bounswe/bounswe2022group7/blob/master/frontend/src/pages/Authentication/SignUpPage.js)
![image](https://user-images.githubusercontent.com/56518500/210164181-0239d93a-7923-41a6-bbb0-e5af683ed9f1.png)
![image](https://user-images.githubusercontent.com/56518500/210166381-0314fce0-6782-4c5d-a765-a403b6d4a3f6.png)

- [Signin](https://github.com/bounswe/bounswe2022group7/blob/master/frontend/src/pages/Authentication/SignInPage.js)
![image](https://user-images.githubusercontent.com/56518500/210164210-3bbf2fd2-d2e0-4b4f-8a7a-18cb1432eb10.png)

- [Home page](https://github.com/bounswe/bounswe2022group7/blob/master/frontend/src/pages/HomePage/HomePage.js)
![image](https://user-images.githubusercontent.com/56518500/210166395-01945663-17c7-40cb-975c-55890c4773d7.png)

- [Profile page](https://github.com/bounswe/bounswe2022group7/blob/master/frontend/src/pages/ProfilePage/Profile.js)
![image](https://user-images.githubusercontent.com/56518500/210166418-8789e440-8a38-4993-9bda-0384124e75f2.png)

- [Art Item Page](https://github.com/bounswe/bounswe2022group7/blob/master/frontend/src/pages/ArtItemPage/ArtItemPage.js)
![image](https://user-images.githubusercontent.com/56518500/210166449-0f457063-0dbd-4f4c-952a-2606d2972b99.png)
![image](https://user-images.githubusercontent.com/56518500/210166476-e9e3f564-824b-4924-abe4-45b6a0c7b99f.png)

- [Event Page](https://github.com/bounswe/bounswe2022group7/blob/master/frontend/src/pages/EventPage/EventPage.js)
![image](https://user-images.githubusercontent.com/56518500/210166506-9e360b02-b921-44d8-ab6b-df7c116181a5.png)
![image](https://user-images.githubusercontent.com/56518500/210166545-66d73ef7-ea87-4d2f-9f79-e75334cc07ab.png)

- [Discussion Post](https://github.com/bounswe/bounswe2022group7/blob/master/frontend/src/pages/DiscussionPage/DiscussionPostPage.js)
![image](https://user-images.githubusercontent.com/56518500/210166575-c324d9a9-e0ab-4f9f-b4be-426955ae0ee2.png)

### Mobile
- [Signup](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/register.dart)

![Screenshot (233)](https://user-images.githubusercontent.com/59166549/210167894-4e5a5180-97d0-487b-bfb6-ea7dd094d73a.png)

- [Signin](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/login.dart)

![Screenshot (232)](https://user-images.githubusercontent.com/59166549/210167938-be4e869e-2553-4faa-8dd9-61af27904cec.png)

- [Homepage](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/home_page.dart)

![Screenshot (231)](https://user-images.githubusercontent.com/59166549/210167974-c855a211-2534-48df-bfd8-e185b4afb667.png)
![Screenshot (237)](https://user-images.githubusercontent.com/59166549/210167976-cab694f6-9a38-47b4-a194-963fe8a4a227.png)

- [Search Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/search.dart)

![Screenshot (238)](https://user-images.githubusercontent.com/59166549/210167992-649d30a3-7137-4afa-8e62-bbb49097f12d.png)

- [Art Item Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/art_item_page.dart)

![Screenshot (239)](https://user-images.githubusercontent.com/59166549/210168005-77116e53-26f7-401b-928b-e7f74c7153d5.png)

- [Event Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/event_page.dart)

![Screenshot (240)](https://user-images.githubusercontent.com/59166549/210168018-75624950-42db-45ab-9cbd-4d486fd127d2.png)
![Screenshot (241)](https://user-images.githubusercontent.com/59166549/210168019-10d7fe99-d616-4e6c-9287-51e557bb67f0.png)

- [Discussion Forum Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/discussion_forum_page.dart)

![Screenshot (242)](https://user-images.githubusercontent.com/59166549/210168034-77397238-37da-4de2-9919-6b0e0b2cf27d.png)

- [Discussion Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/discussion_page.dart)

![Screenshot (243)](https://user-images.githubusercontent.com/59166549/210168040-444ad71e-8530-436b-bb59-b0e893be8add.png)

- [Profile Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/profile_page.dart)

![Screenshot (254)](https://user-images.githubusercontent.com/59166549/210168063-fb65edd3-06e6-4542-a323-141e672bf8c0.png)

- [Account Info Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/account_info_page.dart)

![Screenshot (235)](https://user-images.githubusercontent.com/59166549/210167916-01d545df-c86b-4f91-9f2e-384d02259494.png)
![Screenshot (236)](https://user-images.githubusercontent.com/59166549/210167919-4cc2dc3c-a453-4968-8152-ff68d7d69d15.png)

- [Settings Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/settings_page.dart)

![Screenshot (244)](https://user-images.githubusercontent.com/59166549/210168117-ec1971d0-7eeb-4dbe-a9e9-44d5c2a44d15.png)

- [Create Art Item Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/create_art_item_page.dart)

![Screenshot (245)](https://user-images.githubusercontent.com/59166549/210168127-198fa526-c0c2-429c-a289-ac4fe45a6fa6.png)

- [Create Event Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/create_event_page.dart)

![Screenshot (246)](https://user-images.githubusercontent.com/59166549/210168135-3b333352-bd64-46af-9b20-ca36836c3e5c.png)
![Screenshot (247)](https://user-images.githubusercontent.com/59166549/210168136-7c1c3f72-63db-4dec-a038-1a2c0f06bdf5.png)

- [Image Annotation Page](https://github.com/bounswe/bounswe2022group7/blob/master/android/lib/pages/image_annotation_page.dart)

![Screenshot (251)](https://user-images.githubusercontent.com/59166549/210168165-a2690a61-7a8c-4da5-9368-d93754650b95.png)
![Screenshot (253)](https://user-images.githubusercontent.com/59166549/210168167-f403bdf5-1677-41db-ba88-4cdff754fa46.png)

## 1.6. Annotations
We have implemented CRUD (Create, Read, Update, Delete) functionality with our web annotations web service. Since web annotations are json-ld documents, we used MongoDB as the database and implemented a minimal web service with the Koa framework on top of it. We return an identifier for the newly created annotations in the ETag response header. Our web client supports creating image and text annotations. Although we don't fully implemented every possible way to annotate web resources, the parts that are implemented are sufficient for our users to effectively benefit in their daily uses of the platform.

In order to create an image annotation, the web client allows users to select and identify a portion of the image and sends a post request with the resulting json-ld document to the /annotations/ endpoint. Similarly, for annotation a portion of a text, the user highlights the portion they want to annotate, and the web client sends the resulting annotation document to the /annotations/ endpoint.

Different type of annotations and different type of contents that are being annotated are differentiated by prepending the type and the id of the content to the annotation id with a dash character ('-') separating the two, so that the same endpoint (/annotations/{content-id} where {content-id} is the id of the content being annotated) can be used to retrieve the relevant annotation documents for different content types. For example, e23-afb445...76 represents a text annotation made on the description of an event. Image annotations don't have a letter at the beginning that indicates the type of the content being annotated. Ids of other type of annotations (all of which are text annotations) start with the first letter of the content type being annotated (a: art item, e: event, d: discussion post).
## 1.7. Standards
[The W3 Web Annotation Data Model](https://www.w3.org/TR/annotation-model/) standard precisely describes what web annotations are and includes clear examples of various ways they can be represented and modelled. In order not to reinvent the wheel, we used an existing library that complies with the W3 standard, called [Recogito](https://github.com/recogito/recogito-js). Using this library in our implementation of annotations in the web client of our app helped us tremendously in that it is used by many people and thus tested extensively. This way we delivered a standards-compliant web implementation of Web Annotation Data Model in a faster and more stable way.
## 1.8. Scenarios

# 2. Project Artifacts

## 2.1. Manuels

## 2.2. Software Requirements Specification

## 2.3. Software Design Documents

## 2.4. User Scenarios And Mockups

## 2.5. Project Plan

## 2.6. Unit Tests

# 3. Individual Contribution Reports

## Sabri Mete Akyüz

## Enes Aydoğduoğlu

## Erim Erkin Doğan

## Güney İzol
### Member
I am a member of the frontend team. You can find my weekly contributions on my [effort page](https://github.com/bounswe/bounswe2022group7/wiki/G%C3%BCney-%C4%B0zol-(Effort-Tracking)).

### Responsibilities
I have worked on frontend development infrastructure and implementation of the home page. I also worked on both the backend and frontend implementation of web annotation features of our project. I researched about the web annotation standard and read the standard's documents. 

### Main Contributions
#### Issues
- Try to implement web annotations service with different tools. (We decided that we didn't needed this so this issue was canceled) [#570](https://github.com/bounswe/bounswe2022group7/issues/570)
- Use the [Promise API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) more effectively in our web annotations implementation [#591](https://github.com/bounswe/bounswe2022group7/issues/591)
- Text annotations [#594](https://github.com/bounswe/bounswe2022group7/issues/594)
- Remove the unused tag field from the annotation editor [#623](https://github.com/bounswe/bounswe2022group7/issues/623)
- Fix bugs in annotations [#631](https://github.com/bounswe/bounswe2022group7/issues/631)
- Add web client interface screenshots to the final report. [Report section](https://github.com/bounswe/bounswe2022group7/blob/master/deliverables/CMPE451_Customer_Presentation_Milestone_Final/milestone_report.md#web)
- Write the annotations part of the final report. [Report section](https://github.com/bounswe/bounswe2022group7/blob/master/deliverables/CMPE451_Customer_Presentation_Milestone_Final/milestone_report.md#16-annotations)
- Write the standards part of the final report. [Report section](https://github.com/bounswe/bounswe2022group7/edit/master/deliverables/CMPE451_Customer_Presentation_Milestone_Final/milestone_report.md#17-standards)

#### Pull Requests
- Improve annotations [#627](https://github.com/bounswe/bounswe2022group7/pull/627)
##### Reviewed
- [#612](https://github.com/bounswe/bounswe2022group7/pull/612)
- [#628](https://github.com/bounswe/bounswe2022group7/pull/628)
- [#635](https://github.com/bounswe/bounswe2022group7/pull/635)
- [#637](https://github.com/bounswe/bounswe2022group7/pull/637)

## Ali Can Milani

## Başak Önder

## Cahid Arda Öz

## Musa Şimşek

## Atilla Türkmen

## Can Atakan Uğur

## Demet Yayla
