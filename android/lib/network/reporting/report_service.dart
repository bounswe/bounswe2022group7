import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/models/user_model.dart';
import 'package:android/network/reporting/report_input.dart';
import 'package:android/network/reporting/report_output.dart';
import 'package:android/shared_prefs/user_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

Future<ReportOutput> reportNetwork(ReportInput reportInput) async {
  Response response;
  try {
    CurrentUser? user = await getUser();
    final token = user == null ? "" : user.token;
    response = await post(
      Uri.parse(reportURL),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(reportInput),
    );
    Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      return ReportOutput(
          status: "OK", id: data["id"], description: data["description"]);
    } else {
      return ReportOutput(status: "ERROR");
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return ReportOutput(status: "Network Error");
  }
}
