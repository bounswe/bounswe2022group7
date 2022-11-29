import 'package:android/models/models.dart';

// imported to use dummy data for now
import 'package:android/data/data.dart';

class Event extends Post {
  final EventInfo eventInfo;
  final List<User> collaborators;
  final List<User> participants;
  final DateTime creationDate;
  final List<String> commentList;
  final Location location;
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
    required this.location,
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
    return Event(
      id: json['id'],
      eventInfo: EventInfo.fromJson(json['eventInfo']),
      // *** User model has not been implemented by the back-end team yet ***
      // use the dummy data for now, uncomment below when the back-end team is done

      // creator: User.fromJson(json['creator']),
      // collaborators: json['collaborators'].map((e) => User.fromJson(e)).toList(),
      // participants: json['participants'].map((e) => User.fromJson(e)).toList(),

      creator: ahmet,
      collaborators: [mehmet],
      participants: [tom],

      creationDate: DateTime.parse(json['creationDate']),

      // Comment model has not been implemented, just store as strings
      commentList: json['commentList'].cast<String>(),

      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : Location(
              id: 1,
              address: 'Van Gogh Museum, Amsterdam',
              latitude: 52.358,
              longitude: 4.881,
            ),
      rules: json['rules'],

      // attendees: json['attendees'].map((e) => User.fromJson(e)).toList(),
      // bookmarkedBy: json['bookmarkedBy'].map((e) => User.fromJson(e)).toList(),
      attendees: [],
      bookmarkedBy: [],
    );
  }
}
