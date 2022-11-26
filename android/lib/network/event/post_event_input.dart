import 'package:android/models/location_model.dart';

class PostEventInfo {
  final String title;
  final DateTime startingDate;
  final DateTime endingDate;
  final String? description;
  final String? category;
  final double? eventPrice;
  final String? labels;
  final int? posterId;

  PostEventInfo({
    required this.title,
    this.description,
    required this.startingDate,
    required this.endingDate,
    this.category,
    this.eventPrice,
    this.labels,
    this.posterId,
  });

  Map<String, dynamic> toJson() {
    return {
      "category": category,
      "title": title,
      "posterId": posterId,
      "description": description,
      "startingDate": startingDate,
      "endingDate": endingDate,
      "labels": labels,
      "eventPrice": eventPrice,
    };
  }
}

class PostOnlineEventInput {
  final PostEventInfo eventInfo;
  final List<int>? artItemIds;

  PostOnlineEventInput({
    required this.eventInfo,
    this.artItemIds,
  });

  Map<String, dynamic> toJson() {
    return {
      "eventInfo": eventInfo.toJson(),
      "artItemIds": artItemIds,
    };
  }
}

class PostPhysicalEventInput {
  final PostEventInfo eventInfo;
  final Location? location;
  final String? rules;

  PostPhysicalEventInput({
    required this.eventInfo,
    this.location,
    this.rules,
  });

  Map<String, dynamic> toJson() {
    return {
      "eventInfo": eventInfo.toJson(),
      "location": location?.toJson(),
      "rules": rules,
    };
  }
}
