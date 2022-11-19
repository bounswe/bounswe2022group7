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
