import 'package:android/models/profile/account_info.dart';

class Comment {
  final int id;
  final String text;
  final DateTime creationDate;
  final DateTime lastEditDate;
  final List<String> downVotedUsernames;
  final List<String> upVotedUsernames;
  final int upvotes, downvotes;
  final AccountInfo authorAccountInfo;
  int voteStatus;

  Comment({
    required this.id,
    required this.text,
    required this.creationDate,
    required this.lastEditDate,
    required this.downVotedUsernames,
    required this.upVotedUsernames,
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
      downVotedUsernames: List<String>.from(json["downVotedUsernames"]),
      upVotedUsernames: List<String>.from(json["upVotedUsernames"]),
      downvotes: json["downVotedUsernames"].length,
      upvotes: json["upVotedUsernames"].length,
      authorAccountInfo: AccountInfo.fromJson(json["authorAccountInfo"]),
    );

    return com;
  }

  void updateStatus(String? username) {
    int status = 0;
    if (username != null) {
      for (var upvoter in upVotedUsernames) {
        if (upvoter == username) {
          status = 1;
        }
      }
      for (var downvoter in downVotedUsernames) {
        if (downvoter == username) {
          status = -1;
        }
      }
    }
    voteStatus = status;
  }
}
