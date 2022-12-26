import 'package:android/models/models.dart';

class SearchUserOutput {
  final String status;
  final UserSearch? userSearch;

  SearchUserOutput({
    required this.status,
    this.userSearch,
  });

  factory SearchUserOutput.fromJson(Iterable json) {
    return SearchUserOutput(
      status: "OK",
      userSearch: UserSearch.fromJson(json),
    );
  }
}

class SearchPhysicalExhibitonOutput {
  final String status;
  final EventSearch? physicalExhibitonSearch;

  SearchPhysicalExhibitonOutput({
    required this.status,
    this.physicalExhibitonSearch,
  });

  factory SearchPhysicalExhibitonOutput.fromJson(Iterable json) {
    return SearchPhysicalExhibitonOutput(
      status: "OK",
      physicalExhibitonSearch: EventSearch.fromJson(json),
    );
  }
}

class SearchOnlineGalleryOutput {
  final String status;
  final EventSearch? onlineGallerySearch;

  SearchOnlineGalleryOutput({
    required this.status,
    this.onlineGallerySearch,
  });

  factory SearchOnlineGalleryOutput.fromJson(Iterable json) {
    return SearchOnlineGalleryOutput(
      status: "OK",
      onlineGallerySearch: EventSearch.fromJson(json),
    );
  }
}

class SearchDiscussionPostOutput {
  final String status;
  final DiscussionPostSearch? discussionPostSearch;

  SearchDiscussionPostOutput({
    required this.status,
    this.discussionPostSearch,
  });

  factory SearchDiscussionPostOutput.fromJson(Iterable json) {
    return SearchDiscussionPostOutput(
      status: "OK",
      discussionPostSearch: DiscussionPostSearch.fromJson(json),
    );
  }
}

class SearchArtItemOutput {
  final String status;
  final ArtItemSearch? artItemSearch;

  SearchArtItemOutput({
    required this.status,
    this.artItemSearch,
  });

  factory SearchArtItemOutput.fromJson(Iterable json) {
    return SearchArtItemOutput(
      status: "OK",
      artItemSearch: ArtItemSearch.fromJson(json),
    );
  }
}
