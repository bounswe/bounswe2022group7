import 'package:android/models/models.dart';
import 'package:android/models/comment/comment_model.dart';


class ArtItem extends Post {
  final ArtItemInfo artItemInfo;
  final DateTime creationDate;
  final User? owner;
  final bool onAuction;
  final String? auction;
  final double? lastPrice;
  final List<Comment> commentList;
  final List<User> bookmarkedBy;

  ArtItem({
    required int id,
    required AccountInfo creatorAccountInfo,
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
          creatorAccountInfo: creatorAccountInfo,
          postInfo: artItemInfo,
        );

  factory ArtItem.fromJson(Map<String, dynamic> json) {
    print("art item accoun info: ${json["creatorAccountInfo"]}");
    List<Comment> commentList = [];
    for (int i = 0; i < json["commentList"].length; i++) {
      Comment c = Comment.fromJson(json["commentList"][i]);
      commentList.add(c);
    }
    ArtItem ai = ArtItem(
      id: json['id'] ?? 8,
      artItemInfo: ArtItemInfo.fromJson(json),
      creatorAccountInfo: AccountInfo.fromJson(json['creatorAccountInfo']),
      creationDate: DateTime.parse(json['creationDate']),
      // why does this use accountInfo?
      // owner: User.fromJson(json['owner']["accountInfo"]),

      // Auction model has not been implemented yet
      onAuction: false,
      auction: null,

      lastPrice: json['lastPrice'],

      // Comment model has not been implemented yet just store as strings
      commentList: commentList,

      bookmarkedBy: json['bookMarkedByIds'] != null
          ? List<User>.from(
              json['bookMarkedByIds'].map((x) => User.fromJson(x)))
          : [],
    );

    print("ai");
    return ai;
  }
}
