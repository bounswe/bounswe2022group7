import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/login/login_input.dart';
import 'package:android/network/login/login_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

Future<LoginOutput> loginNetwork(LoginInput loginInput) async {
  final Map<String, String?> body = {
    'email': loginInput.email,
    'password': loginInput.password,
  };
  Response response;
  try {
    response = await post(
      Uri.parse(loginURL),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(body),
    );
    if (response.statusCode != 200) {
      return LoginOutput(status: response.body);
    }
    Map<String, dynamic> data = json.decode(response.body);
    return LoginOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return LoginOutput(status: "Network Error");
  }
}
