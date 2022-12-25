import "package:android/data/data.dart";

class User {
  final int id;
  final String? name;
  final String? surname;
  final String email;
  final String imageUrl;
  final String username;
  final String? userType;
  final int? age;
  final String? country;

  User({
    required this.id,
    this.name,
    required this.email,
    required this.imageUrl,
    required this.username,
    this.surname,
    required this.userType,
    this.age,
    this.country,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    User us = User(
      id: parsedJson["id"],
      name: parsedJson["name"],
      surname: parsedJson["surname"],

      // TODO: correct below
      // although fields below are defined as required,
      // they are sometimes not sent in the creator's info
      email: parsedJson["email"] ?? "",
      imageUrl: parsedJson["profilePictureUrl"] ?? mehmet.imageUrl,
      username: parsedJson["username"] ?? "",

      userType: parsedJson["userType"],
      age: parsedJson["age"],
      country: parsedJson["country"],
    );

    return us;
  }
}

/// User that is using the application has an extra token attribute that will be used for API calls
class CurrentUser {
  final String token;
  final String email;
  String? username;

  CurrentUser({
    required this.token,
    required this.email,
    this.username,
  });

  // Functions below are used to convert user to string and vice versa
  // Used to store the user in shared preferences as a string
  // Shared preferences doesn't accept objects

  factory CurrentUser.fromJson(Map<String, dynamic> parsedJson) {
    return CurrentUser(
      token: parsedJson["token"],
      email: parsedJson["email"],
      username: parsedJson["username"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "email": email,
      "username": username,
    };
  }
}
