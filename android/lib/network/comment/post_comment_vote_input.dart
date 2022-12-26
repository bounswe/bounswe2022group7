class PostCommentVoteInput {
  final int id;
  final int vote;

  PostCommentVoteInput({
    required this.id,
    required this.vote,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "vote": vote,
    };
  }
}
