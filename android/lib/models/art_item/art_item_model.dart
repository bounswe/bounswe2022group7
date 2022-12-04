import 'package:android/models/models.dart';

class ArtItem extends Post {
  final ArtItemInfo artItemInfo;
  final DateTime creationDate;
  final User? owner;
  final bool onAuction;
  final double? lastPrice;
  final List<String> commentList;

  ArtItem({
    required int id,
    required AccountInfo creatorAccountInfo,
    required this.artItemInfo,
    required this.creationDate,
    this.owner,
    required this.onAuction,
    this.lastPrice,
    required this.commentList,
  }) : super(
          type: "Art Item",
          id: id,
          creatorAccountInfo: creatorAccountInfo,
          postInfo: artItemInfo,
        );

  factory ArtItem.fromJson(Map<String, dynamic> json) {
    ArtItem ai = ArtItem(
      id: json['id'] ?? 8,
      artItemInfo: ArtItemInfo.fromJson(json),
      creatorAccountInfo: AccountInfo.fromJson(json['creatorAccountInfo']),
      creationDate: DateTime.parse(json['creationDate']),
      // why does this use accountInfo?
      // owner: User.fromJson(json['owner']["accountInfo"]),

      // Auction model has not been implemented yet
      onAuction: false,

      lastPrice: json['lastPrice'],

      // Comment model has not been implemented yet just store as strings
      commentList:
          List<String>.from(json['commentList'].map((x) => x.toString())),
    );

    return ai;
  }
}
