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

## 1.6. Annotations

## 1.7. Standards

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
I am a member of the frontend team. You can find my weekly contributions on my [effort page](https://github.com/bounswe/bounswe2022group7/wiki/G%C3%BCney-%C4%B0zol-(Effort-Tracking))

### Responsibilities
I have worked on frontend development infrastructure and implementation of the home page. I also worked on both the backend and frontend implementation of web annotation features of our project. I researched about the web annotation standard and read the standard's documents. 

### Main Contributions
#### Issues
- Try to implement web annotations service with different tools. (We decided that we didn't needed this so this issue was canceled) [#570](https://github.com/bounswe/bounswe2022group7/issues/570)
- Use the [Promise API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) more effectively in our web annotations implementation [#591](https://github.com/bounswe/bounswe2022group7/issues/591)
- Text annotations [#594](https://github.com/bounswe/bounswe2022group7/issues/594)
- Remove the unused tag field from the annotation editor [#623](https://github.com/bounswe/bounswe2022group7/issues/623)
- Fix bugs in annotations [#631](https://github.com/bounswe/bounswe2022group7/issues/631)
- Add web client interface screenshots to the final report

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
