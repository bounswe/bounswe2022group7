import 'package:android/util/string_helpers.dart';
import 'package:android/models/models.dart';

class ArtItemInfo extends PostInfo {
  final List<String>? category;
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
      category:
          List<String>.from(json["category"].map((item) => item.toString())),
      imageId: json['imageId'],
      labels:
          List<String>.from(json['labels'].map((label) => label.toString())),
    );

    print("info");
    return info;
  }
}
