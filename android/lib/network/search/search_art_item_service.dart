import 'dart:convert';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/search/search_outputs.dart';

import '../../models/user_model.dart';
import '../../shared_prefs/user_preferences.dart';

Future<SearchArtItemOutput> searchArtItemNetwork(String keys) async {
  String request = "keywords=${keys.trim().replaceAll(' ', '&keywords=')}";
  SearchArtItemOutput saio;

  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;

    response = await get(
      Uri.parse(Uri.encodeFull('$searchArtItemURL?$request')),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode != 200) {
      return SearchArtItemOutput(status: response.statusCode.toString());
    }

    Iterable data = json.decode(response.body);
    saio = SearchArtItemOutput.fromJson(data);
  } catch (err) {
    print('error: ${err.toString()}');
    return SearchArtItemOutput(status: err.toString());
  }

  return saio;
}
