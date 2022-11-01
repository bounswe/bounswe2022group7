import 'package:android/models/models.dart';

class GetArtItemOutput {
  final String status;
  final ArtItem? artItem;

  GetArtItemOutput({required this.status, this.artItem});

  factory GetArtItemOutput.fromJson(Map<String, dynamic> json) {
    return GetArtItemOutput(
      status: "OK",
      artItem: ArtItem.fromJson(json),
    );
  }
}
