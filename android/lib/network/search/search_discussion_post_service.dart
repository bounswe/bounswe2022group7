import 'dart:convert';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/search/search_outputs.dart';

import '../../models/user_model.dart';
import '../../shared_prefs/user_preferences.dart';

Future<SearchDiscussionPostOutput> searchDiscussionPostNetwork(
    String keys) async {
  String request = "keywords=${keys.trim().replaceAll(' ', '&keywords=')}";
  SearchDiscussionPostOutput sdpo;

  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;

    response = await get(
      Uri.parse(Uri.encodeFull('$searchDiscussionURL?$request')),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode != 200) {
      return SearchDiscussionPostOutput(status: response.statusCode.toString());
    }

    Iterable data = json.decode(response.body);
    sdpo = SearchDiscussionPostOutput.fromJson(data);
  } catch (err) {
    print('search discussion post network error: ${err.toString()}');
    return SearchDiscussionPostOutput(status: err.toString());
  }

  return sdpo;
}
