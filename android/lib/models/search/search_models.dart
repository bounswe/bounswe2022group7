import 'package:android/models/models.dart';

class UserSearch {
  final List<User> userList;

  UserSearch({required this.userList});

  factory UserSearch.fromJson(Iterable listOfUsers) {
    return UserSearch(
      userList: listOfUsers.map((user) => User.fromJson(user)).toList(),
    );
  }
}

class EventSearch {
  final List<Event> eventList;

  EventSearch({required this.eventList});

  factory EventSearch.fromJson(Iterable listOfEvents) {
    return EventSearch(
      eventList: listOfEvents.map((event) => Event.fromJson(event)).toList(),
    );
  }
}

// class OnlineGallerySearch extends PhysicalExhibitonSearch {
//   OnlineGallerySearch({required super.eventList});
// }

class DiscussionPostSearch {
  final List<Discussion> discussionList;

  DiscussionPostSearch({required this.discussionList});

  factory DiscussionPostSearch.fromJson(Iterable listOfDiscussions) {
    return DiscussionPostSearch(
      discussionList: listOfDiscussions
          .map((discussion) => Discussion.fromJson(discussion))
          .toList(),
    );
  }
}

class ArtItemSearch {
  final List<ArtItem> artItemList;

  ArtItemSearch({required this.artItemList});

  factory ArtItemSearch.fromJson(Iterable listOfArtItems) {
    return ArtItemSearch(
      artItemList:
          listOfArtItems.map((artItem) => ArtItem.fromJson(artItem)).toList(),
    );
  }
}
