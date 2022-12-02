import 'package:android/models/models.dart';

// imported to use dummy data for now
import 'package:android/data/data.dart';

class Event extends Post {
  final EventInfo eventInfo;
  final List<User> collaborators;
  final List<User> participants;
  final DateTime creationDate;
  final List<String> commentList;
  final Location? location;
  final String? rules;
  final List<User> attendees;
  final List<User> bookmarkedBy;

  Event({
    required int id,
    required User creator,
    required this.eventInfo,
    required this.collaborators,
    required this.participants,
    required this.creationDate,
    required this.commentList,
    this.location,
    this.rules,
    required this.attendees,
    required this.bookmarkedBy,
  }) : super(
          type: "Event",
          id: id,
          creator: creator,
          postInfo: eventInfo,
        );

  factory Event.fromJson(Map<String, dynamic> json) {
    EventInfo info;
    int? index = json["index"];

    Map<String, dynamic> event_info;
    event_info = json["eventInfo"] is int ? json["creator"]["hostedEvents"][index]["eventInfo"] : json["eventInfo"];
    info = EventInfo.fromJson(event_info);

    Map<String, dynamic>? location;
    if(json["location"] != null) {
      location = json["location"] is int
          ? json["creator"]["hostedEvents"][index]["location"]
          : json["location"];
    }


    return Event(
      id: json['id'],

      eventInfo: info,
      creator: User.fromJson(json["creator"]["accountInfo"]),
      collaborators: [mehmet],
      participants: [tom],

      creationDate: DateTime.parse(json['creationDate']),

      // Comment model has not been implemented, just store as strings
      commentList: json['commentList'].cast<String>(),

      location: location == null ? null : Location.fromJson(location),
      rules: json['rules'],

      // attendees: json['attendees'].map((e) => User.fromJson(e)).toList(),
      // bookmarkedBy: json['bookmarkedBy'].map((e) => User.fromJson(e)).toList(),
      attendees: [],
      bookmarkedBy: [],
    );
  }
}
