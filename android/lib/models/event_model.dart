import 'package:android/models/models.dart';
import 'package:android/models/user_model.dart';

class Event {
  final String name;
  final String type;
  final String description;
  final String imageUrl;
  final String location;
  final User host;
  final DateTime date;
  final DateTime creationDate;

  Event(
      {required this.name,
      required this.type,
      required this.description,
      required this.imageUrl,
      required this.location,
      required this.host,
      required this.date,
      required this.creationDate});
}
