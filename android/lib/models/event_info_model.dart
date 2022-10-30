class EventInfo {
  final int id;
  final String title;
  final DateTime endingDate;
  final DateTime startingDate;
  final String description;
  final String? category;
  final double? eventPrice;
  final List<String>? labels;
  final String? posterUrl;

  EventInfo(
      {required this.id,
      required this.title,
      required this.endingDate,
      required this.startingDate,
      required this.description,
      this.category,
      this.eventPrice,
      this.labels,
      this.posterUrl});

  factory EventInfo.fromJson(Map<String, dynamic> json) {
    return EventInfo(
      id: json['id'],
      title: json['title'],
      endingDate: DateTime.parse(json['endingDate']),
      startingDate: DateTime.parse(json['startingDate']),
      description: json['description'],
      category: json['category'],
      eventPrice: json['eventPrice'],
      labels: json['labels'].map((e) => e.toString()).toList(),
      posterUrl: json['posterUrl'],
    );
  }
}
