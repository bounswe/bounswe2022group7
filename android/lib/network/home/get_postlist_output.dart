import 'package:android/models/models.dart';

class GetPostListOutput {
  final String status;
  final List<Post>? list;

  GetPostListOutput({required this.status, this.list});

  GetPostListOutput.combine(
      GetEventListOutput events, GetArtItemListOutput artitems)
      : status = "OK",
        list = List<Post>.empty(growable: true) {
    for (final event in events.list) {
      list?.add(event);
    }
    for (final artItem in artitems.list) {
      list?.add(artItem);
    }
  }
}

class GetEventListOutput {
  final String status;
  final List<Event> list;

  GetEventListOutput({required this.status, required this.list});

  factory GetEventListOutput.fromJson(Iterable json) {
    List<Event> events =
        List<Event>.from(json.map((model) => Event.fromJson(model)));
    return GetEventListOutput(
      status: "OK",
      list: events,
    );
  }
}

class GetArtItemListOutput {
  final String status;
  final List<ArtItem> list;

  GetArtItemListOutput({required this.status, required this.list});

  factory GetArtItemListOutput.fromJson(Iterable json) {
    List<ArtItem> artitems =
        List<ArtItem>.from(json.map((model) => ArtItem.fromJson(model)));
    return GetArtItemListOutput(
      status: "OK",
      list: artitems,
    );
  }
}
