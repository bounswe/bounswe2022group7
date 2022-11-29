class LoginOutput {
  final String status;
  final String? token;


  LoginOutput({
    required this.status,
    this.token,
  });

  factory LoginOutput.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey("token")) {
      return LoginOutput(
        status: json["message"],
        token: null,
      );
    }

    return LoginOutput(
      status: "OK",
      token: json['token'],
    );
  }
}
