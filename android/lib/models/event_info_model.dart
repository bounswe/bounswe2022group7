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
}
