import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/event/post_event_input.dart';
import 'package:android/network/event/post_event_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../models/models.dart';
import '../../shared_prefs/user_preferences.dart';

Future<PostEventOutput> postOnlineEventNetwork(
    PostOnlineEventInput postEventInput) async {
  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;
    response = await post(
      Uri.parse("$eventURL/online"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer$token'
      },
      body: json.encode(postEventInput),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return PostEventOutput.fromJson(data);
    } else {
      return PostEventOutput(
          status: response.statusCode.toString(), eventId: -1);
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return PostEventOutput(status: "Network Error", eventId: -1);
  }
}

Future<PostEventOutput> postPhysicalEventNetwork(
    PostPhysicalEventInput postEventInput) async {
  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;
    response = await post(
      Uri.parse("$eventURL/physical"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer$token'
      },
      body: json.encode(postEventInput),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return PostEventOutput.fromJson(data);
    } else {
      return PostEventOutput(
          status: response.statusCode.toString(), eventId: -1);
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return PostEventOutput(status: "Network Error", eventId: -1);
  }
}
