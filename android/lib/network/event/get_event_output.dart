import '../../models/user_model.dart';

class GetEventOutput {
  final String status;
  final String? name;
  final String? type;
  final String? description;
  final String? imageUrl;
  final String? location;
  final User? host;
  final DateTime? date;
  final DateTime? creationDate;

  GetEventOutput(
      { required this.status,
        this.name,
       this.type,
       this.description,
       this.imageUrl,
       this.location,
       this.host,
       this.date,
       this.creationDate});

  factory GetEventOutput.fromJson(Map<String, dynamic> parsedJson) {
    return GetEventOutput(
      status: parsedJson["status"],
      name: parsedJson["name"],
      type: parsedJson["type"],
      description: parsedJson["description"],
      imageUrl: parsedJson["imageUrl"],
      location: parsedJson["location"],
      host: User.fromJson(parsedJson["host"]),
      date: DateTime.parse(parsedJson["date"]),
      creationDate: DateTime.parse(parsedJson["creationDate"]),
    );
  }
}
