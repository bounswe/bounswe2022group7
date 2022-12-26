import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:uuid/uuid.dart';


import 'package:android/config/api_endpoints.dart';
import 'package:android/models/image_annotation_model.dart';

Future<bool> postAnnotation(Map<String, dynamic> annotation) async {

  var uuid = const Uuid();

  Response response;

  try {
    Map<String, dynamic> body = {
      "@context": "http://www.w3.org/ns/anno.jsonld",
      "type": "Annotation",
      "body": [
        {
          "type": "TextualBody",
          "value": annotation['text'],
          "purpose": "commenting"
        }
      ],
      "target": {
        "source": "https://ideart.tk/api/image/${annotation['imageId']}",
        "selector": {
          "type": "FragmentSelector",
          "conformsTo": "http://www.w3.org/TR/media-frags/",
          "value":
              "xywh=pixel:${annotation['x']},${annotation['y']},${annotation['width']},${annotation['height']}"
        }
      },
      "id": "${annotation['imageId']}-#${uuid.v4()}"
    };

    response = await post(
      Uri.parse(Uri.encodeFull("$annotationsURL/")),
      headers: {'Content-Type': 'application/ld+json'},
      body: jsonEncode(body),
    );
    if (response.statusCode != 200) {
      return false;
    }
    else {
      return true;
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return false;
  }
}
