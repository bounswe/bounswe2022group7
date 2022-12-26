import 'dart:convert';
import 'package:android/models/user_model.dart';
import 'package:android/network/art_item/get_art_item_output.dart';
import 'package:android/shared_prefs/user_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';

Future<GetArtItemOutput> postArtItemAuction(int id) async {
  Response response;

  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;
    response = await post(
      Uri.parse(Uri.encodeFull('$artItemURL/auction/$id/')),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode != 200) {
      return GetArtItemOutput(status: response.body);
    }
    Map<String, dynamic> data = json.decode(response.body);
    return GetArtItemOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetArtItemOutput(status: "Network Error");
  }
}
