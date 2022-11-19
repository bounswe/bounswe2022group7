class PostEventInput {
  final String? category;
  final String title;
  final String? base64poster;
  final String description;
  final DateTime startingDate;
  final DateTime endingDate;
  final List<String>? labels;
  final double? eventPrice;

  PostEventInput({
    required this.category,
    required this.title,
    required this.base64poster,
    required this.description,
    required this.startingDate,
    required this.endingDate,
    required this.labels,
    required this.eventPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "category": category,
      "title": title,
      "base64poster": base64poster,
      "description": description,
      "startingDate": startingDate,
      "endingDate": endingDate,
      "labels": labels,
      "eventPrice": eventPrice,
    };
  }
}
