import 'package:android/models/user_model.dart';

class LoginOutput {
  final String status;
  final CurrentUser? currentUser;


  LoginOutput({
    required this.status,
    this.currentUser,
  });

  factory LoginOutput.fromJson(Map<String, dynamic> parsedJson) {

    if(parsedJson["status"] == "OK") {
      return LoginOutput(
        status: parsedJson["status"],
        currentUser: CurrentUser.fromJson(parsedJson),
      );
    } else {
      return LoginOutput(
        status: parsedJson["status"],
        currentUser: null,
      );
    }
  }
}
