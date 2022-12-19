import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/comment/post_comment_vote_input.dart';
import 'package:android/network/comment/post_comment_vote_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../models/models.dart';
import '../../shared_prefs/user_preferences.dart';

Future<PostCommentVoteOutput> postDiscussionVoteNetwork(
    PostCommentVoteInput postCommentVoteInput) async {
  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;
    response = await post(
      Uri.parse("$commentURL/vote"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(postCommentVoteInput.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return PostCommentVoteOutput.fromJson(data);
    } else {
      return PostCommentVoteOutput(status: response.statusCode.toString());
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return PostCommentVoteOutput(status: "Network Error");
  }
}
