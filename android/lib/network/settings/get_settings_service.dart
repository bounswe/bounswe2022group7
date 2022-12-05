import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/settings/get_settings_output.dart';

import 'package:android/models/user_model.dart';

Future<GetSettingsOutput> getSettingsNetwork(CurrentUser user) async {
  Response response;

  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$settingsURL/')),
      headers: {'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${user.token}'
      },
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