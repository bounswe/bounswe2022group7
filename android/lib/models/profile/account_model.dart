import 'package:android/data/data.dart';
import 'package:android/models/art_item/art_item_info_model.dart';
import 'package:android/models/models.dart';
import 'package:android/models/profile/account_info.dart';
import 'package:android/models/event/event_model.dart';
import 'package:android/models/art_item/art_item_model.dart';
import 'package:android/network/art_item/get_art_item_service.dart';
import 'package:android/network/art_item/get_art_item_output.dart';
import 'package:android/network/event/get_event_output.dart';
import 'package:android/network/event/get_event_service.dart';

Future<Account> accountJsonConverter(Map<String, dynamic> json) async {
  List<Event> event_list = [];
  List<ArtItem> art_item_list = [];
  if (json["hostedEvents"] != null && !json["hostedEvents"].isEmpty) {
    for (int i = 0; i < json["hostedEvents"].length; i++) {
      int id;
      try {
        id = json["hostedEvents"][i]["id"];
      } catch (err) {
        id = json["hostedEvents"][i];
      }
      GetEventOutput eo = await getEventNetworkWithIndex(id, i);
      Event ev = eo.event!;
      event_list.add(ev);
    }
  }
  if (json["artItems"] != null && !json["artItems"].isEmpty) {
    for (int i = 0; i < json["artItems"].length; i++) {
      // print(json["artItems"][i]["commentList"]);
      ArtItem ai;
      if (json["artItems"][i] is int) {
        GetArtItemOutput aio = await getArtItemNetwork(json["artItems"][i]);
        ai = aio.artItem!;
      } else {
        ai = ArtItem.fromJson(json["artItems"][i]);
      }
      art_item_list.add(ai!);
    }
  }
  Account account = Account(
    account_info: AccountInfo.fromJson(json['accountInfo']),
    id: json["id"],
    is_verified: json['isVerified'],
    level: json['level'],
    xp: json['xp'],
    all_events: event_list,
    all_art_items: art_item_list,
  );

  return account;
}

class Account {
  final AccountInfo account_info;
  final int id;
  final bool is_verified;
  final int level;
  final double xp;
  List<Event> all_events;
  List<ArtItem> all_art_items;

  Account({
    required this.account_info,
    required this.id,
    required this.is_verified,
    required this.level,
    required this.xp,
    required this.all_events,
    required this.all_art_items,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    List<Event> event_list = [];
    List<ArtItem> art_item_list = [];

    if (!json["hostedEvents"].isEmpty) {
      for (int i = 0; i < json["hostedEvents"].length; i++) {
        Event ev = Event.fromJson(json["hostedEvents"][i]);
        event_list.add(ev);
      }
    }
    if (!json["artItems"].isEmpty) {
      for (int i = 0; i < json["artItems"].length; i++) {
        ArtItem? ai;
        getArtItemNetwork(json["artItems"][i])
            .then((value) => ai = value.artItem);
        art_item_list.add(ai!);
      }
    }

    Account account = Account(
      account_info: AccountInfo.fromJson(json['accountInfo']),
      id: json["id"],
      is_verified: json['isVerified'],
      level: json['level'],
      xp: json['xp'],
      all_events: event_list,
      all_art_items: art_item_list,
    );

    return account;
  }
}
