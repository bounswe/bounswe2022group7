class ReportOutput {
  final String status;
  final int? id;
  final String? description;

  ReportOutput({
    required this.status,
    this.id,
    this.description,
  });

  factory ReportOutput.fromJson(Map<String, dynamic> parsedJson) {
    return ReportOutput(
        status: parsedJson["status"],
        id: parsedJson["id"],
        description: parsedJson["description"]);
  }
}
