class RegisterOutput {
  final String status;
  final String? imageUrl;
  final String? token;

  RegisterOutput({
    this.token,
    this.imageUrl,
    required this.status,
  });

  factory RegisterOutput.fromJson(Map<String, dynamic> parsedJson) {
    return RegisterOutput(
      status: parsedJson["status"],
      token: parsedJson["token"],
    );
  }
}
