import 'package:android/models/comment/comment_model.dart';
import 'package:android/models/models.dart';

class Event extends Post {
  final EventInfo eventInfo;
  final String eventType;
  final List<User>? collaborators;
  final List<String>? participants;
  final DateTime creationDate;
  final List<Comment> commentList;
  final Location? location;
  final String? rules;
  final List<User>? attendees;
  final List<User>? bookmarkedBy;
  final List<int>? artItemList;
  int participationStatus;
  int bookmarkStatus;

  Event({
    required int id,
    required this.eventType,
    required AccountInfo creatorAccountInfo,
    required this.eventInfo,
    this.collaborators,
    this.participants,
    required this.creationDate,
    required this.commentList,
    this.location,
    this.rules,
    this.attendees,
    this.bookmarkedBy,
    this.artItemList,
  })  : participationStatus = 0,
        bookmarkStatus = 0,
        super(
          type: "Event",
          id: id,
          creatorAccountInfo: creatorAccountInfo,
          postInfo: eventInfo,
        );

  factory Event.fromJson(Map<String, dynamic> json) {
    AccountInfo creatorAccountInfo =
        AccountInfo.fromJson(json["creatorAccountInfo"]);
    DateTime creationDate = DateTime.parse(json['creationDate']);

    List<Comment> commentList = [];
    for (int i = 0; i < json["commentList"].length; i++) {
      Comment c = Comment.fromJson(json["commentList"][i]);
      commentList.add(c);
    }

    EventInfo eventInfo = EventInfo.fromJson(json["eventInfo"]);
    List<String> participants = json["participantUsernames"].cast<String>();
    Location? location =
        json["location"] != null ? Location.fromJson(json["location"]) : null;

    return Event(
      id: json['id'],
      eventType: json['type'],
      creatorAccountInfo: creatorAccountInfo,
      creationDate: creationDate,
      commentList: commentList,
      eventInfo: eventInfo,
      collaborators: [],
      participants: participants,
      location: location,
      rules: json['rules'],
      attendees: [],
      bookmarkedBy: [],
      artItemList: json["artItemList"] != null
          ? List<int>.from(json["artItemList"])
          : [],
    );
  }

  void updateStatus(String? username) {
    int statusParticipation = 0;
    int statusBookmark = 0;

    if (username != null) {
      if (participants != null) {
        for (var participant in participants!) {
          if (participant == username) {
            statusParticipation = 1;
          }
        }
      }
      if (bookmarkedBy != null) {
        for (var marker in bookmarkedBy!) {
          if (marker.username == username) {
            statusBookmark = 1;
          }
        }
      }
    }
    participationStatus = statusParticipation;
    bookmarkStatus = statusBookmark;
  }
}
