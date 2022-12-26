import 'package:android/models/user_model.dart';
import 'package:android/models/image_model.dart';

class ImageAnnotation {
  /// An annotation for an image should look like this:
  // {
  //   "_id": "<internal_mongo_db_id>",
  //   "@context": "http://www.w3.org/ns/anno.jsonld",
  //   "type": "Annotation",
  //   "body": [
  //     {
  //       "type": "TextualBody",
  //       "value": "<annotation_text>",
  //       "purpose": "commenting"
  //     }
  //   ],
  //   "target": {
  //     "source": "<base64-image>",
  //     "selector": {
  //       "type": "FragmentSelector",
  //       "conformsTo": "http://www.w3.org/TR/media-frags/",
  //       "value": "xywh=pixel:<x>,<y>,<width>,<height>"
  //     }
  //   },
  //   "id": "<image_id>-#8c5f2fa2-17ce-4eff-be79-a8e554787586"
  // }

  final int imageId;
  final String text;
  final double x;
  final double y;
  final double width;
  final double height;

  ImageAnnotation({
    required this.imageId,
    required this.text,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory ImageAnnotation.fromJson(Map<String, dynamic> json) {
    final coordinates = json['target']['selector']['value']
        .split('=')[1]
        .split(':')[1]
        .split(',');

    return ImageAnnotation(
      imageId: int.parse(json['id'].split('-')[0]),
      text: json['body'][0]['value'],
      x: double.parse(coordinates[0]),
      y: double.parse(coordinates[1]),
      width: double.parse(coordinates[2]),
      height: double.parse(coordinates[3]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageId': imageId,
      'text': text,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    };
  }
}
