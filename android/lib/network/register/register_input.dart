class RegisterInput {
  final String userType;
  final String email;
  final String username;
  final String password;
  final String? name;
  final String? surname;
  final int? age;
  final String? country;

  RegisterInput({
    required this.userType,
    required this.email,
    required this.username,
    required this.password,
    this.name,
    this.surname,
    this.age,
    this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "username": username,
      "userType": userType,
      "surname": surname,
      "age": age,
      "country": country,
      "password": password,
    };
  }
}
