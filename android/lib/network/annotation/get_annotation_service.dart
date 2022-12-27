import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:android/config/api_endpoints.dart';
import 'package:android/models/image_annotation_model.dart';

Future<List<ImageAnnotation>> getImageAnnotationsNetwork() async {
  Response response;

  try {
    response = await get(
      Uri.parse(Uri.encodeFull(annotationsURL)),
      headers: {'Content-Type': 'application/ld+json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return [];
    }
    List<dynamic> data = json.decode(response.body);
    List<dynamic> imageAnnotations = [];
    for (var annotation in data) {
      if (annotation['id'][0] != 'a' || annotation['id'][0] != 'e' || annotation['id'][0] != 'd') {
        if (annotation['target']['source'] != null) {
          imageAnnotations.add(annotation);
        }
      }
    }
    return imageAnnotations.map((e) => ImageAnnotation.fromJson(e)).toList();
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return [];
  }
}

Future<List<dynamic>> getTextAnnotationsNetwork(String postType) async {
  Response response;

  try {
    response = await get(
      Uri.parse(Uri.encodeFull(annotationsURL)),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return [];
    }
    List<dynamic> data = json.decode(response.body);
    List<dynamic> textAnnotations = [];
    for (var annotation in data) {
      if (annotation['id'][0] == postType) {
        textAnnotations.add(annotation);
      }
    }
    return textAnnotations;
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return [];
  }
}

Future<List<ImageAnnotation>> getAnnotationsNetworkByImageId(int? imageId) async {
  if (imageId == null) {
    return [];
  }

  Response response;

  try {
    response = await get(
      Uri.parse(Uri.encodeFull('$annotationsURL/$imageId')),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if (response.statusCode != 200) {
      return [];
    }
    List<dynamic> data = json.decode(response.body);
    List<dynamic> imageAnnotations = [];
    for (var annotation in data) {
      if (annotation['id'][0] != 'a' || annotation['id'][0] != 'e' || annotation['id'][0] != 'd') {
        if (annotation['target']['source'] != null) {
          imageAnnotations.add(annotation);
        }
      }
    }
    return imageAnnotations.map((e) => ImageAnnotation.fromJson(e)).toList();
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return [];
  }
}