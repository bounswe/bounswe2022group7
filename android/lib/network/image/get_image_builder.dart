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
            late String base64String;
            if (currentImage.base64String.contains("data:image/png;base64,")) {
              base64String = currentImage.base64String
                  .split("data:image/png;base64,")
                  .elementAt(1);
            } else if (currentImage.base64String
                .contains("data:image/jpeg;base64,")) {
              base64String = currentImage.base64String
                  .split("data:image/jpeg;base64,")
                  .elementAt(1);
            } else {
              base64String = currentImage.base64String;
            }
            return Image.memory(base64Decode(base64String));
          } else {
            // snapshot.data == null
            return Container();
          }
      }
    },
  );
}

Widget imageCircleBuilder(int? imageId) {
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
            late String base64String;
            if (currentImage.base64String.contains("data:image/png;base64,")) {
              base64String = currentImage.base64String
                  .split("data:image/png;base64,")
                  .elementAt(1);
            } else if (currentImage.base64String
                .contains("data:image/jpeg;base64,")) {
              base64String = currentImage.base64String
                  .split("data:image/jpeg;base64,")
                  .elementAt(1);
            } else {
              base64String = currentImage.base64String;
            }
            return CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.grey[300],
              backgroundImage: Image.memory(base64Decode(base64String)).image,
            );
          } else {
            // snapshot.data == null
            return Container();
          }
      }
    },
  );
}
