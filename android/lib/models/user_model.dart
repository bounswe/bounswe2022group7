class User {
  final String name;
  final String email;
  final String imageUrl;
  final String username;

  User(
      {required this.name,
      required this.email,
      required this.imageUrl,
      required this.username});
}

/// User that is using the application has an extra token attribute that will be used for API calls
class CurrentUser extends User {
  final String token;

  CurrentUser({
    required this.token,
    required super.name,
    required super.email,
    required super.username,
    required super.imageUrl,
  });

  // Functions below are used to convert user to string and vice versa
  // Used to store the user in shared preferences as a string
  // Shared preferences doesn't accept objects

  factory CurrentUser.fromJson(Map<String, dynamic> parsedJson) {
    return CurrentUser(
      name: parsedJson['name'],
      email: parsedJson['email'],
      imageUrl: parsedJson['imageUrl'],
      username: parsedJson['username'],
      token: parsedJson["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "imageUrl": imageUrl,
      "username": username,
      "token": token,
    };
  }
}
