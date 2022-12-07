import 'package:android/network/image/get_image_builder.dart';
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
    return circleAvatarBuilder(pictureid, 12.0);
  }
}
