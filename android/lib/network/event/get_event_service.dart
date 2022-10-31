import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/event/get_event_output.dart';

Future<GetEventOutput> getEventNetwork(int id) async {
  Response response;

  /*
    header for testing with custom token:

    const token = "GET_YOUR_TOKEN_FROM_BACKEND";
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
   */

  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$eventURL/$id/')),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return GetEventOutput(status: response.body);
    }
    Map<String, dynamic> data = json.decode(response.body);
    return GetEventOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetEventOutput(status: "Network Error");
  }
}
