import 'dart:convert';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/image/post_image_input.dart';
import 'package:android/network/image/post_image_output.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

Future<PostImageOutput> postImageNetwork(PostImageInput postImageInput) async {
  Response response;
  try {
    response = await post(
      Uri.parse(getImageURL),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(postImageInput),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return PostImageOutput.fromJson(data);
    } else {
      return PostImageOutput(status: response.statusCode.toString(), id: -1);
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return PostImageOutput(status: "Network Error", id: -1);
  }
}
