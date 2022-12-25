class PostDiscussionVoteInput {
  final int id;
  final int vote;

  PostDiscussionVoteInput({
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
