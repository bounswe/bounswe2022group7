import 'package:android/config/api_endpoints.dart';
import 'package:android/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../shared_prefs/user_preferences.dart';

Future<int> postFollowNetwork(String username) async {
  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;
    response = await post(
      Uri.parse("$followURL/$username"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    return response.statusCode;
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return 503;
  }
}
