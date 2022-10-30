import 'package:android/models/models.dart';

class Event {
  final int id;
  final EventInfo eventInfo;
  final User creator;
  final List<User> collaborators;
  final List<User> participants;
  final DateTime creationDate;
  final DateTime lastEdited;
  final List<String> commentList;
  final String location;
  final String? rules;
  final List<User> attendees;
  final List<User> bookmarkedBy;

  Event(
      {required this.id,
      required this.eventInfo,
      required this.creator,
      required this.collaborators,
      required this.participants,
      required this.creationDate,
      required this.lastEdited,
      required this.commentList,
      required this.location,
      this.rules,
      required this.attendees,
      required this.bookmarkedBy});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      eventInfo: EventInfo.fromJson(json['eventInfo']),
      creator: User.fromJson(json['creator']),
      collaborators: json['collaborators'].map((e) => User.fromJson(e)).toList(),
      participants: json['participants'].map((e) => User.fromJson(e)).toList(),
      creationDate: DateTime.parse(json['creationDate']),
      lastEdited: DateTime.parse(json['lastEdited']),
      commentList: json['commentList'].map((e) => e.toString()).toList(),
      location: json['location'],
      rules: json['rules'],
      attendees: json['attendees'].map((e) => User.fromJson(e)).toList(),
      bookmarkedBy: json['bookmarkedBy'].map((e) => User.fromJson(e)).toList(),
    );
  }

}
