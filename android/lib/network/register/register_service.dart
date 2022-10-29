import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/register/register_input.dart';
import 'package:android/network/register/register_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

Future<RegisterOutput> registerNetwork(RegisterInput registerInput) async {
  final Map<String, String?> testInput = {
    'username': "test",
  };
  Response response;
  try {
    response = await post(
      Uri.parse(registerURL),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(testInput),
    );
    if (response.statusCode != 200) {
      return RegisterOutput(status: response.body);
    }
    Map<String, dynamic> data = json.decode(response.body);
    return RegisterOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return RegisterOutput(status: "Network Error");
  }
}
