import 'package:android/models/user_model.dart';

class LoginOutput {
  final String status;
  final String? token;


  LoginOutput({
    required this.status,
    this.token,
  });

  factory LoginOutput.fromJson(Map<String, dynamic> parsedJson) {

    if(parsedJson["status"] == "OK") {
      return LoginOutput(
        status: parsedJson["status"],
        token: parsedJson["token"],
      );
    } else {
      return LoginOutput(
        status: parsedJson["status"],
        token: null,
      );
    }
  }
}
