import 'package:android/models/models.dart';
import 'package:android/models/user_model.dart';

class ArtItem {
  final String name;
  final String description;
  final String imageUrl;
  final User artist;

  ArtItem(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.artist});
}
