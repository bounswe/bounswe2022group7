import 'dart:developer';

import 'package:android/models/models.dart';
import 'package:android/models/comment/comment_model.dart';

class ArtItem extends Post {
  final ArtItemInfo artItemInfo;
  final DateTime creationDate;
  final User? owner;
  final bool onAuction;
  final double? lastPrice;
  final List<Comment> commentList;
  final List<String> bookmarkedBy;
  final List<String> likedBy;
  int likeStatus;
  int bookmarkStatus;

  ArtItem({
    required int id,
    required AccountInfo creatorAccountInfo,
    required this.artItemInfo,
    required this.creationDate,
    this.owner,
    required this.onAuction,
    this.lastPrice,
    required this.commentList,
    required this.bookmarkedBy,
    required this.likedBy,
  })  : likeStatus = 0,
        bookmarkStatus = 0,
        super(
          type: "Art Item",
          id: id,
          creatorAccountInfo: creatorAccountInfo,
          postInfo: artItemInfo,
        );

  factory ArtItem.fromJson(Map<String, dynamic> json) {
    List<Comment> commentList = [];

    if (json['commentList'] != null) {
      try {
        for (int i = 0; i < json['commentList'].length; i++) {
          Comment c = Comment.fromJson(json['commentList'][i]);
          commentList.add(c);
        }
      } catch (err) {
        commentList = [];
      }
    }
    ArtItem ai = ArtItem(
      id: json['id'] ?? 8,
      artItemInfo: ArtItemInfo.fromJson(json),
      creatorAccountInfo: AccountInfo.fromJson(
          json['creatorAccountInfo'] == null
              ? json['creator']
              : json['creatorAccountInfo']),
      creationDate: DateTime.parse(json['creationDate']),
      // why does this use accountInfo?
      // owner: User.fromJson(json['owner']["accountInfo"]),

      // Auction model has not been implemented yet
      onAuction: false,

      lastPrice: json['lastPrice'],

      // Comment model has not been implemented yet just store as strings
      commentList: commentList,

      bookmarkedBy: json['bookmarkedByUsernames'] != null
          ? List<String>.from(json['bookmarkedByUsernames'])
          : [],
      likedBy: json['likedByUsernames'] != null
          ? List<String>.from(json['likedByUsernames'])
          : [],
    );

    return ai;
  }

  void updateStatus(String? username) {
    int statusBookmark = 0;
    int statusLike = 0;
    if (username != null) {
      for (var marker in bookmarkedBy) {
        if (marker == username) {
          statusBookmark = 1;
        }
      }
      for (var liker in likedBy) {
        if (liker == username) {
          statusLike = 1;
        }
      }
    }
    bookmarkStatus = statusBookmark;
    likeStatus = statusLike;
  }
}
