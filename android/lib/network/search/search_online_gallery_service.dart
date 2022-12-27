import 'dart:convert';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/search/search_outputs.dart';

import '../../models/user_model.dart';
import '../../shared_prefs/user_preferences.dart';

Future<SearchOnlineGalleryOutput> searchOnlineGalleryNetwork(
    String keys) async {
  String request = "keywords=${keys.trim().replaceAll(' ', '&keywords=')}";
  SearchOnlineGalleryOutput sogo;

  Response response;

  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;

    response = await get(
      Uri.parse(Uri.encodeFull('$searchOnlineURL?$request')),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode != 200) {
      return SearchOnlineGalleryOutput(status: response.statusCode.toString());
    }

    Iterable data = json.decode(response.body);
    sogo = SearchOnlineGalleryOutput.fromJson(data);
  } catch (err) {
    print('error: ${err.toString()}');
    return SearchOnlineGalleryOutput(status: err.toString());
  }

  return sogo;
}
