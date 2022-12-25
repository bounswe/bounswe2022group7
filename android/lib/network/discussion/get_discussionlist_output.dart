import 'package:android/models/models.dart';

class GetDiscussionListOutput {
  final String status;
  final List<Discussion>? list;

  GetDiscussionListOutput({required this.status, this.list});

  factory GetDiscussionListOutput.fromJson(Iterable json) {
    List<Discussion> discList =
        List<Discussion>.from(json.map((model) => Discussion.fromJson(model)));
    return GetDiscussionListOutput(
      status: "OK",
      list: discList,
    );
  }
}
