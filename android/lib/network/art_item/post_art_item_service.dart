import 'dart:convert';

import 'package:android/network/art_item/post_art_item_output.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

import '../../config/api_endpoints.dart';
import '../../models/user_model.dart';
import '../../shared_prefs/user_preferences.dart';
import 'post_art_item_input.dart';

Future<PostArtItemOutput> postArtItemNetwork(
    PostArtItemInput createArtItemInput) async {
  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;
    response = await post(
      Uri.parse(artItemURL),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(createArtItemInput.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return PostArtItemOutput.fromJson(data);
    } else {
      return PostArtItemOutput(
        status: response.statusCode.toString(),
        artItemId: -1,
      );
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return PostArtItemOutput(
      status: "Network Error",
      artItemId: -1,
    );
  }
}
