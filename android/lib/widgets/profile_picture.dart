import 'package:flutter/cupertino.dart';
import 'package:android/network/image/get_image_service.dart';
import 'package:android/network/image/get_image_output.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// ignore: must_be_immutable
class profilePictureWidget extends StatelessWidget {
  int pictureid;

  profilePictureWidget({super.key, required this.pictureid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImageNetwork(pictureid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            default:
              if (snapshot.hasError) {
                return const Text("Error");
              }

              if (snapshot.data != null) {
                GetImageOutput image_output = snapshot.data!;
                if (image_output.status != "OK") {
                  return const Text(
                      "An error occured while loading profile page!");
                }

                return CircleAvatar(
                  radius: 4.0,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: MemoryImage(
                      base64Decode(image_output.image!.base64String)),
                );
              } else {
                return const Text("");
              }
          }
        });
  }
}
