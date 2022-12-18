import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/discussion/post_discussion_vote_input.dart';
import 'package:android/network/discussion/post_discussion_vote_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../models/models.dart';
import '../../shared_prefs/user_preferences.dart';

Future<PostDiscussionVoteOutput> postDiscussionVoteNetwork(
    PostDiscussionVoteInput postDiscussionVoteInput) async {
  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;
    response = await post(
      Uri.parse("$discussionURL/vote"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(postDiscussionVoteInput.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return PostDiscussionVoteOutput.fromJson(data);
    } else {
      return PostDiscussionVoteOutput(status: response.statusCode.toString());
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return PostDiscussionVoteOutput(status: "Network Error");
  }
}
