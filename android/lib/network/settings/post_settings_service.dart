import 'dart:convert';
import 'package:android/network/settings/post_settings_input.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/settings/get_settings_output.dart';

import 'package:android/models/user_model.dart';

// they are using the same output format with the get service
Future<GetSettingsOutput> postSettingsNetwork(CurrentUser user, PostSettingsInput postSettingsInput) async {
  Response response;

  try {
    response = await post(
      Uri.parse(Uri.encodeFull('$settingsURL/')),
      headers: {'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.token}'
      },
      body: json.encode(postSettingsInput),
    );

    if (response.statusCode != 200) {
      return GetSettingsOutput(status: response.body);
    }
    Map<String, dynamic> data = json.decode(response.body);
    return GetSettingsOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetSettingsOutput(status: "Network Error");
  }
}