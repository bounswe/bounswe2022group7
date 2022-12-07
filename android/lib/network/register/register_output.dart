class RegisterOutput {
  final String status;
  final String? token;

  RegisterOutput({
    required this.status,
    this.token,
  });

  factory RegisterOutput.fromJson(Map<String, dynamic> parsedJson) {
    return RegisterOutput(
      status: parsedJson["status"],
      token: parsedJson["token"]
    );
  }
}
