import 'dart:convert';

import 'package:android/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../config/api_endpoints.dart';
import '../../shared_prefs/user_preferences.dart';

Future<dynamic> postBid(int id, String amount) async {
  Response response;
  CurrentUser? us = await getUser();

  int? bidAmount = int.tryParse(amount);
  if (bidAmount == null) {
    return "Invalid bid";
  }
  final token = us == null ? "" : us.token;
  try {
    response = await post(
      Uri.parse(Uri.encodeFull('$artItemURL/bid/$id')),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({"bidAmount": bidAmount}),
    );

    if (response.statusCode != 200) {
      return "Unsuccessful";
    }
    print("psotbid response: ${response.body}");
    return response.statusCode;
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return "Network Error";
  }
}
