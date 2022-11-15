class RegisterInput {
  final String userType;
  final String email;
  final String username;
  final String password;

  RegisterInput({
    required this.userType,
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "username": username,
      "userType": userType,
      "password": password,
    };
  }
}
