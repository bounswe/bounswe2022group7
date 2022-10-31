import 'package:android/models/models.dart';

class ArtItem {
  final int id;
  final ArtItemInfo artItemInfo;
  final User creator;
  final DateTime creationDate;
  final User owner;
  final bool onAuction;
  final String? auction;
  final double? lastPrice;
  final List<String> commentList;
  final List<User> bookmarkedBy;

  ArtItem({
    required this.id,
    required this.artItemInfo,
    required this.creator,
    required this.creationDate,
    required this.owner,
    required this.onAuction,
    this.auction,
    this.lastPrice,
    required this.commentList,
    required this.bookmarkedBy,
  });

  factory ArtItem.fromJson(Map<String, dynamic> json) {
    return ArtItem(
      id: json['id'],

      artItemInfo: ArtItemInfo.fromJson(json['artItemInfo']),

      creator: User.fromJson(json['creator']),
      creationDate: DateTime.parse(json['creationDate']),
      owner: User.fromJson(json['owner']),

      // Auction model has not been implemented yet
      onAuction: false,
      auction: null,

      lastPrice: json['lastPrice'],

      // Comment model has not been implemented yet just store as strings
      commentList:
          List<String>.from(json['commentList'].map((x) => x.toString())),

      bookmarkedBy:
          List<User>.from(json['bookmarkedBy'].map((x) => User.fromJson(x))),
    );
  }
}
