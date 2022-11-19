import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/event/post_event_input.dart';
import 'package:android/network/event/post_event_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

Future<PostEventOutput> postEventNetwork(PostEventInput postEventInput) async {
  Response response;
  try {
    response = await post(
      Uri.parse(eventURL),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(postEventInput),
    );
    if (response.body == "true") {
      return PostEventOutput(status: "Event creation successful");
    } else if (response.body == "false") {
      return PostEventOutput(status: "Event creation unsuccessful");
    } else {
      return PostEventOutput(status: response.body);
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return PostEventOutput(status: "Network Error");
  }
}
