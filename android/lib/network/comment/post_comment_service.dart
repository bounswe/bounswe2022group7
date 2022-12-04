import 'package:android/models/models.dart';
import 'package:android/network/comment/post_comment_input.dart';
import 'package:http/http.dart';
import '../../shared_prefs/user_preferences.dart';
import 'package:android/config/api_endpoints.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

Future<int> postCommentNetwork(postCommentInfo commentInfo) async {
  Response response;

  try {
    CurrentUser? user = await getUser();
    final token = user != null ? user.token : "";

    response = await post(
      Uri.parse(commentURL),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(commentInfo.toJson()),
    );

    return response.statusCode;
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return -1;
  }
}
