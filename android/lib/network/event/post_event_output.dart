class PostEventOutput {
  final String status;

  PostEventOutput({
    required this.status,
  });

  factory PostEventOutput.fromJson(Map<String, dynamic> parsedJson) {
    return PostEventOutput(
      status: parsedJson["status"],
    );
  }
}
