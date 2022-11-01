class LoginOutput {
  final String status;
  final String? token;


  LoginOutput({
    required this.status,
    this.token,
  });

  factory LoginOutput.fromJson(String response) {

    if(response != "") {
      return LoginOutput(
        status: "OK",
        token: response,
      );
    } else {
      return LoginOutput(
        status: "Login Unsuccessful",
        token: null,
      );
    }
  }
}
