class PostSettingsInput {
  final String? username;
  final String? email;
  final String? name;
  final String? surname;
  final String? country;
  final DateTime? dateOfBirth;
  final int? profilePictureId;

  PostSettingsInput({
    this.username,
    this.email,
    this.name,
    this.surname,
    this.country,
    this.dateOfBirth,
    this.profilePictureId,
  });

  Map<String, dynamic> toJson() {

    Map<String, dynamic> json = {};
    if (username != null) json['username'] = username;
    if (email != null) json['email'] = email;
    if (name != null) json['name'] = name;
    if (surname != null) json['surname'] = surname;
    if (country != null) json['country'] = country;
    if (dateOfBirth != null) json['dateOfBirth'] = dateOfBirth!.toIso8601String();
    if (profilePictureId != null) json['profilePictureId'] = profilePictureId;

    return json;
  }

}