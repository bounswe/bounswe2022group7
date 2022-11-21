class PostInfo {
  final int id;
  final String name;
  final String description;
  final int? imageId;

  PostInfo({
    required this.id,
    required this.name,
    required this.description,
    this.imageId,
  });

  factory PostInfo.fromJson(Map<String, dynamic> json) {
    return PostInfo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageId: json['imageId'],
    );
  }
}