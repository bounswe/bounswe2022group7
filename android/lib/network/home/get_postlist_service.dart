import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/home/get_postlist_output.dart';

import '../../models/user_model.dart';

Future<GetPostListOutput> getPosts(CurrentUser? user) async {
  Response response;
  GetArtItemListOutput artItemOutput;
  GetEventListOutput eventOutput;

  try {
    if (user == null) {
      response = await get(
        Uri.parse(Uri.encodeFull(homepageEventURL)),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
    } else {
      response = await get(
        Uri.parse(Uri.encodeFull(homepageEventURL)),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user.token}'
        },
      );
    }

    if (response.statusCode != 200) {
      return GetPostListOutput(status: response.body);
    }
    Iterable data = json.decode(response.body);
    eventOutput = GetEventListOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetPostListOutput(status: "Network Error");
  }

  try {
    if (user == null) {
      response = await get(
        Uri.parse(Uri.encodeFull(homepageArtItemURL)),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
    } else {
      response = await get(
        Uri.parse(Uri.encodeFull(homepageArtItemURL)),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $user'
        },
      );
    }
    if (response.statusCode != 200) {
      return GetPostListOutput(status: response.body);
    }
    Iterable data = json.decode(response.body);
    artItemOutput = GetArtItemListOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetPostListOutput(status: "Network Error");
  }

  return GetPostListOutput.combine(eventOutput, artItemOutput);
}
