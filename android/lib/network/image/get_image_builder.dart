import 'dart:convert';

import 'package:android/models/models.dart';
import 'package:android/network/image/get_image_service.dart';
import 'package:android/network/image/get_image_output.dart';
import 'package:flutter/material.dart';

Widget imageBuilder(int? imageId) {
  if (imageId == null) return Container();
  return FutureBuilder(
    future: getImageNetwork(imageId),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return const CircularProgressIndicator();
        default:
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Snapshot Error!"),
              ),
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }

          if (snapshot.data != null) {
            GetImageOutput responseData = snapshot.data!;
            if (responseData.status != "OK") {
              return Container();
            }
            ImageModel currentImage = responseData.image!;
            return currentImage.base64String != null
                ? Image.memory(base64Decode(currentImage.base64String))
                : Container();
          } else {
            // snapshot.data == null
            return Container();
          }
      }
    },
  );
}
