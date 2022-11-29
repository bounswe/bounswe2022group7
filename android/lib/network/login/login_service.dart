import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/login/login_input.dart';
import 'package:android/network/login/login_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

Future<LoginOutput> loginNetwork(LoginInput loginInput) async {
  Response response;
  try {
    response = await post(
      Uri.parse(loginURL),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(loginInput),
    );
    return LoginOutput.fromJson(jsonDecode(response.body));
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return LoginOutput(status: "Network Error");
  }
}
