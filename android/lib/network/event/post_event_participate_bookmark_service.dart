import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/event/get_event_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../models/models.dart';
import '../../shared_prefs/user_preferences.dart';

Future<GetEventOutput> postEventMarkNetwork(int id, String url) async {
  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;
    response = await post(
      Uri.parse("$eventURL/$url/$id/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return GetEventOutput.fromJson(data);
    } else {
      return GetEventOutput(status: response.statusCode.toString());
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetEventOutput(status: "Network Error");
  }
}
