class PostArtItemOutput {
  final String status;
  final int artItemId;

  PostArtItemOutput({
    required this.status,
    required this.artItemId,
  });

  factory PostArtItemOutput.fromJson(Map<String, dynamic> parsedJson) {
    return PostArtItemOutput(
      status: "OK",
      artItemId: parsedJson["id"],
    );
  }
}
