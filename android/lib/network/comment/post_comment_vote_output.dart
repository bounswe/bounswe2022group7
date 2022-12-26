import 'package:android/models/comment/comment_model.dart';

class PostCommentVoteOutput {
  final String status;
  final Comment? comment;

  PostCommentVoteOutput({
    required this.status,
    this.comment,
  });

  factory PostCommentVoteOutput.fromJson(Map<String, dynamic> parsedJson) {
    return PostCommentVoteOutput(
      status: "OK",
      comment: Comment.fromJson(parsedJson),
    );
  }
}
