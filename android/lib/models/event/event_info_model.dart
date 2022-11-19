import 'package:android/util/string_helpers.dart';

class EventInfo {
  final int id;
  final String title;
  final DateTime endingDate;
  final DateTime startingDate;
  final String description;
  final String? category;
  final double? eventPrice;
  final List<String>? labels;
  final int? posterId;

  EventInfo(
      {required this.id,
      required this.title,
      required this.endingDate,
      required this.startingDate,
      required this.description,
      this.category,
      this.eventPrice,
      this.labels,
      this.posterId});

  factory EventInfo.fromJson(Map<String, dynamic> json) {
    return EventInfo(
      id: json['id'],
      title: json['title'],
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

      posterId: json['posterId'],
    );
  }
}
