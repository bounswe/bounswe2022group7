import 'dart:developer';

import 'package:android/util/string_helpers.dart';
import 'package:android/models/models.dart';

class ArtItemInfo extends PostInfo {
  final List<dynamic>? category;
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
    Map<String, dynamic> jsont = json;
    if (json['name'] == null) {
      jsont = json['artItemInfo'];
    }
    ArtItemInfo info = ArtItemInfo(
      id: jsont['id'] ?? 8,
      name: jsont['name'],
      description: jsont['description'],
      category:
          List<String>.from(jsont["category"].map((item) => item.toString())),
      imageId: jsont['imageId'],
      labels:
          List<String>.from(jsont['labels'].map((label) => label.toString())),
    );

    return info;
  }
}
