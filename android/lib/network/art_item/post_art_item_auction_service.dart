import 'package:android/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../config/api_endpoints.dart';

Future<dynamic> postAuction(int id, CurrentUser user) async {
  Response response;

  try {
    response = await post(
      Uri.parse(Uri.encodeFull('$artItemURL/auction/$id')),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.token}',
      },
    );
    print("auction:");
    print(response.body);
    return response.body;
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return "Network Error";
  }
}
