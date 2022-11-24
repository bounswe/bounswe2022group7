import 'package:android/models/profile/account_info.dart';
import 'package:android/models/event/event_model.dart';
import 'package:android/models/art_item/art_item_model.dart';

class Account{
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

    print(json["allEvents"].length);
    List<Event> event_list = [];
    List<ArtItem> art_item_list = [];

    if(!json["allEvents"].isEmpty){
      for(int i=0; i<json["allEvents"].length; i++) {
        Event ev = Event.fromJson(json["allEvents"][i]);
        event_list.add(ev);
      }
    }

    if(!json["artItems"].isEmpty) {
      for(int i=0; i<json["artItems"].length; i++) {
        ArtItem ai = ArtItem.fromJson(json["artItems"][i]);
        art_item_list.add(ai);
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