import 'dart:convert';
import 'package:android/network/discussion/get_discussionlist_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';

Future<GetDiscussionListOutput> getDiscussionPosts() async {
  Response response;

  try {
    response = await get(
      Uri.parse(Uri.encodeFull(discussionURL)),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return GetDiscussionListOutput(status: response.body);
    }

    Iterable data = json.decode(response.body);
    return GetDiscussionListOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }

    return GetDiscussionListOutput(status: "Network Error");
  }
}
