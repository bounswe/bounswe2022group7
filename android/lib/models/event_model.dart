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
}
