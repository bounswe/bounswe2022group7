import 'package:android/models/models.dart';

Future<UserSearch> userSearchJsonConverter(Iterable json) async {
  var user_list = <
      Account>[]; //= await json.map((user) async => await accountJsonConverter(user)).toList();
  for (var iter in json) {
    Account acc = await accountJsonConverter(iter);
    user_list.add(acc);
  }
  return UserSearch(
    userList: user_list,
  );
}

class UserSearch {
  final List<Account> userList;

  UserSearch({required this.userList});

  factory UserSearch.fromJson(Iterable listOfUsers) {
    var user_list = listOfUsers.map((user) => Account.fromJson(user)).toList();
    return UserSearch(
      userList: user_list,
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
