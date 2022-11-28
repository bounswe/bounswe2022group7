class PostImageInput {
  final String? base64string;

  PostImageInput({
    required this.base64string,
  });

  Map<String, dynamic> toJson() {
    return {
      "base64String": base64string,
    };
  }
}
