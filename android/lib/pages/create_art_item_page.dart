import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateArtItemPage extends StatefulWidget {
  const CreateArtItemPage({Key? key}) : super(key: key);

  @override
  State<CreateArtItemPage> createState() => _CreateArtItemPageState();
}

class _CreateArtItemPageState extends State<CreateArtItemPage> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    XFile? image;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: InkWell(
            onTap: () async {
              image = await picker.pickImage(source: ImageSource.gallery);
              final bytes = File(image!.path).readAsBytesSync();
              String base64Image =
                  "data:image/png;base64,${base64Encode(bytes)}";
              log(base64Image); // prints null if string is too large
            },
            child: const Text("select picture")),
      ),
    );
  }
}
