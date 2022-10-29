import 'package:android/models/models.dart';
import 'package:android/models/user_model.dart';

class Event {
  final String name;
  final String description;
  final String imageUrl;
  final String location;
  final User host;
  final DateTime date;

  Event(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.location,
      required this.host,
      required this.date});
}
