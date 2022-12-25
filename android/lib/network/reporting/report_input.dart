class ReportInput {
  final int artItemId;
  final String description;

  ReportInput({
    required this.artItemId,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "artItemId": artItemId,
      "description": description,
    };
  }
}
