import 'dart:convert';
import 'package:android/network/discussion/get_discussion_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';

Future<GetDiscussionOutput> getDiscussionNetwork(int id) async {
  Response response;

  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$discussionURL/$id/')),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return GetDiscussionOutput(status: response.body);
    }
    Map<String, dynamic> data = json.decode(response.body);
    return GetDiscussionOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetDiscussionOutput(status: "Network Error");
  }
}
