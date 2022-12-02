class GetSettingsOutput {
  final String status;
  final String? email;
  final String? username;
  final String? name;
  final String? surname;
  final String? country;
  final String? dateOfBirth;
  final int? profilePictureId;

  GetSettingsOutput({
    required this.status,
    this.email,
    this.username,
    this.name,
    this.surname,
    this.country,
    this.dateOfBirth,
    this.profilePictureId,
  });

  factory GetSettingsOutput.fromJson(Map<String, dynamic> json) {
    return GetSettingsOutput(
      status: "OK",
      email: json['email'],
      username: json['username'],
      name: json['name'],
      surname: json['surname'],
      country: json['country'],
      dateOfBirth: json['dateOfBirth'],
      profilePictureId: json['profilePictureId'],
    );
  }
}