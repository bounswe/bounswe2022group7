import 'package:android/models/models.dart';

class GetDiscussionOutput {
  final String status;
  final Discussion? discussion;

  GetDiscussionOutput({required this.status, this.discussion});

  factory GetDiscussionOutput.fromJson(Map<String, dynamic> json) {
    return GetDiscussionOutput(
      status: "OK",
      discussion: Discussion.fromJson(json),
    );
  }
}
