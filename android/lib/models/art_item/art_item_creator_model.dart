class ArtItemCreator {
  final int id;
  final String name;
  final String surname;

  ArtItemCreator({
    required this.id,
    required this.name,
    required this.surname,
  });

  factory ArtItemCreator.fromJson(Map<String, dynamic> json) {
    return ArtItemCreator(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
    );
  }
}
