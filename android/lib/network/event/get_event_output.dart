import 'package:android/models/models.dart';

class GetEventOutput {
  final String status;
  final Event? event;

  GetEventOutput({required this.status, this.event});

  factory GetEventOutput.fromJson(Map<String, dynamic> json) {
    return GetEventOutput(
      // status: json['status'],
      status: "OK",
      // event: Event.fromJson(json['event']),
      event: Event.fromJson(json),
    );
  }
}
