class AccountInfo {
  final String email;
  final String username;
  final int id;
  // final String? registered_user;
  final String? name;
  final String? surname;
  final String? country;
  DateTime? date_of_birth;
  final int? profile_picture_id;

  AccountInfo({
    required this.email,
    required this.username,
    required this.id,
    // this.registered_user,
    this.name,
    this.surname,
    this.country,
    this.date_of_birth,
    this.profile_picture_id,
  });


  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    AccountInfo info = AccountInfo(
      id: json["id"],
      email: json["email"],
      username: json["username"],
      // registered_user: json["registeredUser"],
      name: json["name"],
      surname: json["surname"],
      country: json["country"],
      profile_picture_id: json["profilePictureId"],
    );

    if(json["dateOfBirth"] != null) {
      info.date_of_birth = DateTime.parse(json["dateOfBirth"]);
    }

    return info;
  }
}