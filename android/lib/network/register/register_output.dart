class RegisterOutput {
  final String status;

  RegisterOutput({
    required this.status,
  });

  factory RegisterOutput.fromJson(Map<String, dynamic> parsedJson) {
    return RegisterOutput(
      status: parsedJson["status"],
    );
  }
}
