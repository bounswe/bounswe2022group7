class PostEventOutput {
  final String status;
  final int eventId;

  PostEventOutput({
    required this.status,
    required this.eventId,
  });

  factory PostEventOutput.fromJson(Map<String, dynamic> parsedJson) {
    return PostEventOutput(
      status: parsedJson["status"],
      eventId: parsedJson["id"],
    );
  }
}
