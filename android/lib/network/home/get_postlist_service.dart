import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/network/home/get_postlist_output.dart';

import '../../models/user_model.dart';

Future<GetPostListOutput> getGenericPost() async {
  Response response;
  GetArtItemListOutput artitemoutput;
  GetEventListOutput eventoutput;

  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$homepageURL/getGenericEvents/')),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return GetPostListOutput(status: response.body);
    }

    Iterable data = json.decode(response.body);
    eventoutput = GetEventListOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetPostListOutput(status: "Network Error");
  }

  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$homepageURL/getGenericArtItems/')),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return GetPostListOutput(status: response.body);
    }
    Iterable data = json.decode(response.body);
    artitemoutput = GetArtItemListOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetPostListOutput(status: "Network Error");
  }

  return GetPostListOutput.combine(eventoutput, artitemoutput);
}

Future<GetPostListOutput> getUserPost(CurrentUser? user) async {
  Response response;
  GetArtItemListOutput artitemoutput;
  GetEventListOutput eventoutput;
  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$homepageURL/getEventsForUser/')),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $user;'
      },
    );
    if (response.statusCode != 200) {
      return GetPostListOutput(status: response.body);
    }
    Iterable data = json.decode(response.body);
    eventoutput = GetEventListOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetPostListOutput(status: "Network Error");
  }

  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$homepageURL/getArtItemsForUser/')),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return GetPostListOutput(status: response.body);
    }
    Iterable data = json.decode(response.body);
    artitemoutput = GetArtItemListOutput.fromJson(data);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return GetPostListOutput(status: "Network Error");
  }

  return GetPostListOutput.combine(eventoutput, artitemoutput);
}
