import 'dart:convert';
import 'package:android/network/art_item/get_art_item_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';

Future<GetArtItemOutput> getArtItemNetwork(int id) async {
  Response response;

  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$artItemURL/$id/')),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
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
