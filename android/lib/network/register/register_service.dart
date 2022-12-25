import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/register/register_input.dart';
import 'package:android/network/register/register_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

Future<RegisterOutput> registerNetwork(RegisterInput registerInput) async {
  Response response;
  try {
    response = await post(
      Uri.parse(registerURL),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(registerInput),
    );
    Map<String, dynamic> data = json.decode(response.body);

    if(response.statusCode == 200) {
      return RegisterOutput(status: "OK", token: data["token"]);
    } else {
      return RegisterOutput(status: "ERROR");
    }
    // if (response.body == "true") {
    //   return RegisterOutput(status: "Signup successful");
    // } else if (response.body == "false") {
    //   return RegisterOutput(status: "Signup unsuccessful");
    // } else {
    //   return RegisterOutput(status: response.body);
    // }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return RegisterOutput(status: "Network Error");
  }
}
