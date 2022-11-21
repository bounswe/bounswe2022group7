import 'package:android/util/string_helpers.dart';
import 'package:android/models/models.dart';

class EventInfo extends PostInfo {
  final DateTime endingDate;
  final DateTime startingDate;
  final String? category;
  final double? eventPrice;
  final List<String>? labels;

  EventInfo({
    required int id,
    required String name,
    required String description,
    int? imageId,
    required this.endingDate,
    required this.startingDate,
    this.category,
    this.eventPrice,
    this.labels,
  }) : super(
          id: id,
          name: name,
          description: description,
    imageId: imageId,
        );

  factory EventInfo.fromJson(Map<String, dynamic> json) {
    return EventInfo(
      id: json['id'],
      name: json['title'],
      endingDate: DateTime.parse(json['endingDate']),
      startingDate: DateTime.parse(json['startingDate']),
      description: json['description'],
      category: json['category'],
      eventPrice: json['eventPrice'],

      // *** Data sent from the back-end team is not in the correct format ***
      // Instead of a list of strings, it is a single string representing a list
      // Uncomment below when the back-end team fixes the problem
      //labels: json['labels'].map((e) => e.toString()).toList(),
      labels: stringToList(json['labels']),

      imageId: json['posterId'],
    );
  }
}
