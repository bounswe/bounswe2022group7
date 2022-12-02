import 'package:android/util/string_helpers.dart';
import 'package:android/models/models.dart';

class ArtItemInfo extends PostInfo {
  final String? category;
  final List<String>? labels;

  ArtItemInfo({
    required int id,
    required String name,
    required String description,
    int? imageId,
    this.category,
    this.labels,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageId: imageId,
        );

  factory ArtItemInfo.fromJson(Map<String, dynamic> json) {
    ArtItemInfo info = ArtItemInfo(
      id: json['id'] ?? 8,
      name: json['name'],
      description: json['description'],
      category: json['category'],
      imageId: json['imageId'],
      labels: stringToList(json['labels'].toString()),
    );
    return info;
  }
}
