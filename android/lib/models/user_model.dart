class User {
  final String name;
  final String? surname;
  final String email;
  final String imageUrl;
  final String username;
  final String userType;
  final int? age;
  final String? country;

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.username,
    this.surname,
    required this.userType,
    this.age,
    this.country,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      name: parsedJson["name"] ?? "",
      surname: parsedJson["surname"] ?? "",
      email: parsedJson["email"] ?? "",
      imageUrl:
          parsedJson["imageUrl"] ?? "https://api.multiavatar.com/Robo.png",
      username: parsedJson["username"] ?? "",
      userType: parsedJson["userType"] ?? "",
      age: parsedJson["age"] ?? 0,
      country: parsedJson["country"] ?? "",
    );
  }
}

/// User that is using the application has an extra token attribute that will be used for API calls
class CurrentUser {
  final String token;

  CurrentUser({
    required this.token,
  });

  // Functions below are used to convert user to string and vice versa
  // Used to store the user in shared preferences as a string
  // Shared preferences doesn't accept objects

  factory CurrentUser.fromJson(Map<String, dynamic> parsedJson) {
    return CurrentUser(
      token: parsedJson["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }
}
