import 'package:android/models/profile/account_info.dart';

class Comment {
  final int id;
  final String text;
  final DateTime creationDate;
  final DateTime lastEditDate;
  final List<int> downVotedUserIds;
  final List<int> upVotedUserIds;
  final int upvotes, downvotes;
  final AccountInfo authorAccountInfo;
  int voteStatus;

  Comment({
    required this.id,
    required this.text,
    required this.creationDate,
    required this.lastEditDate,
    required this.downVotedUserIds,
    required this.upVotedUserIds,
    required this.downvotes,
    required this.upvotes,
    required this.authorAccountInfo,
  }) : voteStatus = 0;

  factory Comment.fromJson(Map<String, dynamic> json) {
    DateTime creationDate = DateTime.parse(json['creationDate']);
    DateTime editDate = DateTime.parse(json['lastEditDate']);
    Comment com = Comment(
      id: json["id"],
      text: json["text"],
      creationDate: creationDate,
      lastEditDate: editDate,
      downVotedUserIds: List<int>.from(json["downVotedUserIds"]),
      upVotedUserIds: List<int>.from(json["upVotedUserIds"]),
      downvotes: json["downVotedUserIds"].length,
      upvotes: json["upVotedUserIds"].length,
      authorAccountInfo: AccountInfo.fromJson(json["authorAccountInfo"]),
    );

    return com;
  }

  void updateStatus(int? userId) {
    int status = 0;
    if (userId != null) {
      for (var upvoteId in upVotedUserIds) {
        if (upvoteId == userId) {
          status = 1;
        }
      }
      for (var downvoteId in downVotedUserIds) {
        if (downvoteId == userId) {
          status = -1;
        }
      }
    }
    voteStatus = status;
  }
}
