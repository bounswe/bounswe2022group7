class ImageModel {
  final int id;
  final String base64String;

  ImageModel({required this.id, required this.base64String});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      base64String: json['base64String'],
    );
  }
}
