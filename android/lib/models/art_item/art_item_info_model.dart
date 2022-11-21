import 'package:android/util/string_helpers.dart';
import 'package:android/models/models.dart';

class ArtItemInfo extends PostInfo {
  final String? category;
  final List<String>? labels;

  ArtItemInfo({
    required int id,
    required String name,
    required String description,
    String? imageUrl,
    this.category,
    this.labels,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
        );

  factory ArtItemInfo.fromJson(Map<String, dynamic> json) {
    return ArtItemInfo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      labels: stringToList(json['labels']),
    );
  }
}
