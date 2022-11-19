import 'package:android/models/models.dart';

class GetImageOutput {
  final String status;
  final ImageModel? image;

  GetImageOutput({required this.status, this.image});

  factory GetImageOutput.fromJson(Map<String, dynamic> json) {
    return GetImageOutput(
      // status: json['status'],
      status: "OK",
      // event: Event.fromJson(json['event']),
      image: ImageModel.fromJson(json),
    );
  }
}
