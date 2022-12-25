import 'package:android/models/profile/account_info.dart';

class Comment {
  final int id;
  final String text;
  final DateTime creationDate;
  final DateTime lastEditDate;
  final int upvotes, downvotes;
  final AccountInfo authorAccountInfo;
  bool? liked;
  bool? disliked;

  Comment(
      {required this.id,
      required this.text,
      required this.creationDate,
      required this.lastEditDate,
      required this.downvotes,
      required this.upvotes,
      required this.authorAccountInfo,
      this.liked,
      this.disliked});

  factory Comment.fromJson(Map<String, dynamic> json) {
    DateTime creationDate = DateTime.parse(json['creationDate']);
    DateTime editDate = DateTime.parse(json['lastEditDate']);
    Comment com = Comment(
      id: json["id"],
      text: json["text"],
      creationDate: creationDate,
      lastEditDate: editDate,
      downvotes: json["downVotedUsernames"].length,
      upvotes: json["upVotedUsernames"].length,
      authorAccountInfo: AccountInfo.fromJson(json["authorAccountInfo"]),
      liked: false,
      disliked: false,
    );

    return com;
  }
}
