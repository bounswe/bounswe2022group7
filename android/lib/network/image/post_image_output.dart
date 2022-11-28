class PostImageOutput {
  final String status;
  final int id;

  PostImageOutput({
    required this.status,
    required this.id,
  });

  factory PostImageOutput.fromJson(Map<String, dynamic> parsedJson) {
    return PostImageOutput(
      status: parsedJson["status"],
      id: parsedJson["id"],
    );
  }
}
