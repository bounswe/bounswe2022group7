import 'package:android/models/models.dart';
import 'package:android/data/data.dart';

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

      artItemInfo: json['artItemInfo'] != null
          ? ArtItemInfo.fromJson(json['artItemInfo'])
          : ArtItemInfo(
              id: 0,
              name: "",
              description: "",
              category: "",
              imageUrl: 'https://api.multiavatar.com/Robo.png',
              labels: List<String>.empty()),

      creator: json['creator'] != null
          ? User.fromJson(json['creator'])
          : User(
              name: "",
              email: "",
              imageUrl: "https://api.multiavatar.com/Robo.png",
              username: "",
              userType: ""),
      creationDate: DateTime.parse(json['creationDate']),
      owner: json['owner'] != null
          ? User.fromJson(json['owner'])
          : User(
              name: "",
              email: "",
              imageUrl: "https://api.multiavatar.com/Robo.png",
              username: "",
              userType: ""),

      // Auction model has not been implemented yet
      onAuction: false,
      auction: "",

      lastPrice: json['lastPrice'] ?? 0.0,

      // Comment model has not been implemented yet just store as strings
      commentList: json['commentList'] != null
          ? List<String>.from(json['commentList'].map((x) => x.toString()))
          : [""],

      bookmarkedBy: json['bookmarkedBy'] != null
          ? List<User>.from(json['bookmarkedBy'].map((x) => User.fromJson(x)))
          : List<User>.empty(),
    );
  }
}
