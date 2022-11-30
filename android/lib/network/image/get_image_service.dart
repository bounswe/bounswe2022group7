import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/image/get_image_output.dart';

Future<GetImageOutput> getImageNetwork(int? id) async {
  Response response;

  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$getImageURL/$id/')),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return GetImageOutput(status: response.body);
    }
    Map<String, dynamic> data = json.decode(response.body);
    return GetImageOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetImageOutput(status: "Network Error");
  }
}
