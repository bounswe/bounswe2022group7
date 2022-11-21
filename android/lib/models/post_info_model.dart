class PostInfo {
  final int id;
  final String name;
  final String description;
  final String? imageUrl;

  PostInfo({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
  });

  factory PostInfo.fromJson(Map<String, dynamic> json) {
    return PostInfo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}