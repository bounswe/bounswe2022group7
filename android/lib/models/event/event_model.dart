import 'package:android/models/models.dart';

// imported to use dummy data for now
import 'package:android/data/data.dart';

class Event extends Post {
  final EventInfo eventInfo;
  final String eventType;
  final List<User>? collaborators;
  final List<String>? participants;
  final DateTime creationDate;
  final List<String>? commentList;
  final Location? location;
  final String? rules;
  final List<User>? attendees;
  final List<User>? bookmarkedBy;
  final List<int>? artItemList;

  Event({
    required int id,
    required this.eventType,
    required AccountInfo creatorAccountInfo,
    required this.eventInfo,
    this.collaborators,
    this.participants,
    required this.creationDate,
    this.commentList,
    this.location,
    this.rules,
    this.attendees,
    this.bookmarkedBy,
    this.artItemList,
  }) : super(
          type: "Event",
          id: id,
          creatorAccountInfo: creatorAccountInfo,
          postInfo: eventInfo,
        );

  factory Event.fromJson(Map<String, dynamic> json) {
    AccountInfo creatorAccountInfo =
        AccountInfo.fromJson(json["creatorAccountInfo"]);
    DateTime creationDate = DateTime.parse(json['creationDate']);
    List<String> commentList = json['commentList'].cast<String>();
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
}
