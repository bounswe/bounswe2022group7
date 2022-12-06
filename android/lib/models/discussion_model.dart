import 'package:android/models/models.dart';

class Discussion {
  final int id;
  final String title;
  final String textBody;
  final AccountInfo creatorAccountInfo;
  final int creatorId;
  final DateTime? creationDate;
  final DateTime? lastEditDate;
  final List<String>? upVotedUsernames;
  final List<String>? downVotedUsernames;
  //final Comment commentList;

  Discussion(
      {required this.id,
      required this.title,
      required this.textBody,
      required this.creatorAccountInfo,
      required this.creatorId,
      this.creationDate,
      this.lastEditDate,
      this.upVotedUsernames,
      this.downVotedUsernames});

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json['id'],
      title: json['title'],
      textBody: json['textBody'],
      creatorAccountInfo: AccountInfo.fromJson(json['creatorAccountInfo']),
      creatorId: json['creatorId'],
      creationDate: DateTime.parse(json['creationDate']),
      lastEditDate: DateTime.parse(json['lastEditDate']),
      upVotedUsernames: json['upVotedUsernames'].cast<String>(),
      downVotedUsernames: json['downVotedUsernames'].cast<String>(),
    );
  }
}
