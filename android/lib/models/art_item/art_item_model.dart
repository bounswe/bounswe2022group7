import 'package:android/models/models.dart';

class ArtItem extends Post {
  final ArtItemInfo artItemInfo;
  final DateTime creationDate;
  final User? owner;
  final bool onAuction;
  final String? auction;
  final double? lastPrice;
  final List<String> commentList;
  final List<User> bookmarkedBy;

  ArtItem({
    required int id,
    required User creator,
    required this.artItemInfo,
    required this.creationDate,
    this.owner,
    required this.onAuction,
    this.auction,
    this.lastPrice,
    required this.commentList,
    required this.bookmarkedBy,
  }) : super(
          type: "Art Item",
          id: id,
          creator: creator,
          postInfo: artItemInfo,
        );

  factory ArtItem.fromJson(Map<String, dynamic> json) {
    ArtItem ai = ArtItem(
      id: json['id'] ?? 8,
      artItemInfo: ArtItemInfo.fromJson(json),
      creator: User.fromJson(json['creatorAccountInfo']),
      creationDate: DateTime.parse(json['creationDate']),
      // why does this use accountInfo?
      // owner: User.fromJson(json['owner']["accountInfo"]),

      // Auction model has not been implemented yet
      onAuction: false,
      auction: null,

      lastPrice: json['lastPrice'],

      // Comment model has not been implemented yet just store as strings
      commentList:
          List<String>.from(json['commentList'].map((x) => x.toString())),

      bookmarkedBy:
          List<User>.from(json['bookMarkedByIds'].map((x) => User.fromJson(x))),
    );

    return ai;
  }
}
