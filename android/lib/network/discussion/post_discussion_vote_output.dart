import 'package:android/models/discussion_model.dart';

class PostDiscussionVoteOutput {
  final String status;
  final Discussion? discussion;

  PostDiscussionVoteOutput({
    required this.status,
    this.discussion,
  });

  factory PostDiscussionVoteOutput.fromJson(Map<String, dynamic> parsedJson) {
    return PostDiscussionVoteOutput(
      status: "OK",
      discussion: Discussion.fromJson(parsedJson),
    );
  }
}
