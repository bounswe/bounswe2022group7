class postCommentInfo {
  final String text;
  final int postid;

  postCommentInfo({
    required this.text,
    required this.postid,
  });

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "commentedObjectId": postid,
    };
  }
}
