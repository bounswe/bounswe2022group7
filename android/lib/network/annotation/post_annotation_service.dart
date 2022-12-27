import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'package:uuid/uuid.dart';

import 'package:android/config/api_endpoints.dart';

Future<bool> postImageAnnotation(Map<String, dynamic> annotation) async {
  var uuid = const Uuid();

  Response response;

  try {
    Map<String, dynamic> body = {
      "@context": "http://www.w3.org/ns/anno.jsonld",
      "type": "Annotation",
      "creator": "https://ideart.tk/api/profile/${annotation['creator']}",
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
    } else {
      return true;
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return false;
  }
}

Future<bool> postTextAnnotation(Map<String, dynamic> annotation) async {
  var uuid = const Uuid();

  Response response;

  try {
    Map<String, dynamic> body = {
      "@context": "http://www.w3.org/ns/anno.jsonld",
      "type": "Annotation",
      "creator": "$serverIP/profile/${annotation['creator']}",
      "body": [
        {
          "type": "TextualBody",
          "value": annotation['text'],
          "purpose": "commenting"
        }
      ],
      "target": {
        "source": annotation['source'],
        "selector": {
          "type": "TextPositionSelector",
          "start": annotation['start'],
          "end": annotation['end'],
        }
      },
      "id": "c_#${uuid.v4()}"
    };

    response = await post(
      Uri.parse(Uri.encodeFull("$annotationsURL/")),
      headers: {'Content-Type': 'application/ld+json'},
      body: jsonEncode(body),
    );
    if (response.statusCode != 200) {
      return false;
    } else {
      return true;
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return false;
  }
}
