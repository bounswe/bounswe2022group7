import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:android/network/image/get_image_builder.dart';
import 'package:flutter/material.dart';

getSourceImage(int imageId, double width) async {
  final Image? sourceImage = await getImageObjectWithSize(imageId, width);
  return sourceImage;
}

convertToUiImage(Image image) async {
  final Completer<ui.Image> completer = Completer();
  image.image
      .resolve(const ImageConfiguration(size: Size(100, 100)))
      .addListener(
        ImageStreamListener(
          (ImageInfo info, bool _) => completer.complete(info.image),
        ),
      );
  return completer.future;
}

Future<Uint8List> getCroppedImage(
    Image src, double x, double y, double width, double height) async {
  /**
   * The source image used in this function MUST have a width to be preserved.
   */

  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder);
  final Paint paint = Paint()..isAntiAlias = true;
  final uiImage = await convertToUiImage(src);
  final double scale = uiImage.width / src.width!;
  canvas.drawImageRect(
      uiImage,
      Rect.fromLTWH(x * scale, y * scale, width * scale, height * scale),
      Rect.fromLTWH(0, 0, width, height),
      paint);
  final ui.Picture picture = recorder.endRecording();
  final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

Widget buildCroppedImage(
    Image src, double x, double y, double width, double height) {
  return FutureBuilder(
      future: getCroppedImage(src, x, y, width, height),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data as Uint8List);
        } else {
          return const SizedBox();
        }
      });
}
