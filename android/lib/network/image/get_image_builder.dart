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
                ? Image.memory(base64Decode(
                    currentImage.base64String.contains("data:image/png;base64,")
                        ? currentImage.base64String
                            .split("data:image/png;base64,")
                            .elementAt(1)
                        : currentImage.base64String))
                : Container();
          } else {
            // snapshot.data == null
            return Container();
          }
      }
    },
  );
}

Widget imageBuilderWithSize(int? imageId, double width, double height) {
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
                ? Image.memory(base64Decode(
                    currentImage.base64String.contains("data:image/png;base64,")
                        ? currentImage.base64String
                            .split("data:image/png;base64,")
                            .elementAt(1)
                        : currentImage.base64String),
                    width: width,
                    height: height)
                : Container();
          } else {
            // snapshot.data == null
            return Container();
          }
      }
    },
  );
}

Widget circleAvatarBuilder(int? imageId, double radius) {
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
              return Icon(Icons.person, size: 2 * radius);
            }
            ImageModel currentImage = responseData.image!;
            return currentImage.base64String != null
                ? CircleAvatar(
                    radius: radius,
                    backgroundImage: MemoryImage(base64Decode(
                        currentImage.base64String.contains(
                                "data:image/png;base64,")
                            ? currentImage.base64String
                                .split("data:image/png;base64,")
                                .elementAt(1)
                            : currentImage.base64String)))
                :  Icon(Icons.person, size: 2 * radius);
          } else {
            // snapshot.data == null
            return Icon(Icons.person, size: 2 * radius);
          }
      }
    },
  );
}