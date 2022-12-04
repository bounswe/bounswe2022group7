import 'dart:convert';
import 'package:android/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/profile/get_user_output.dart';
import 'package:android/providers/user_provider.dart';

Future<getUserOutput> getUserNetwork(String? username, CurrentUser? user) async {
  Response response;
  getUserOutput user_output;
  if(user==null) {
    try {
      response = await get(
        Uri.parse(Uri.encodeFull('$profileURL/$username')),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode != 200) {
        return getUserOutput(status: response.body);
      }

      Map<String, dynamic> data = json.decode(response.body);
      user_output = getUserOutput.fromJson(data);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return getUserOutput(status: "Network Error");
    }
  } else {

    try {
      response = await get(
        Uri.parse(Uri.encodeFull(profileURL)),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user.token};'
          },
      );

      if (response.statusCode != 200) {
        return getUserOutput(status: response.body);
      }

      Map<String, dynamic> data = json.decode(response.body);
      // user_output = getUserOutput.fromJson(data);
      user_output = await userOutputJsonConverter(data);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return getUserOutput(status: "Network Error");
    }
  }

  return user_output;
}