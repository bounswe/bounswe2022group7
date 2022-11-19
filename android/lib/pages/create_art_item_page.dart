import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:android/util/validators.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../util/snack_bar.dart';
import '../widgets/form_app_bar.dart';
import '../widgets/form_widgets.dart';

class CreateArtItemPage extends StatefulWidget {
  const CreateArtItemPage({Key? key}) : super(key: key);

  @override
  State<CreateArtItemPage> createState() => _CreateArtItemPageState();
}

class _CreateArtItemPageState extends State<CreateArtItemPage> {
  final formKey = GlobalKey<FormState>();
  String? _name, _price, _description, _category, _labels, _base64Image;

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    final ValueNotifier<XFile?> imageNotifier = ValueNotifier(null);
    XFile? image;

    final nameField = inputField(TextFormField(
      validator: validateNotEmpty,
      onSaved: (value) => _name = value,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
      ),
    ));

    final priceField = inputField(TextFormField(
      validator: validateNotEmpty,
      onSaved: (value) => _price = value,
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Price',
      ),
    ));

    final descriptionField = inputField(TextFormField(
      validator: validateNotEmpty,
      onSaved: (value) => _description = value,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Description',
      ),
    ));

    final categoryField = inputField(TextFormField(
      validator: validateNotEmpty,
      onSaved: (value) => _category = value,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Category',
      ),
    ));

    final labelField = inputField(TextFormField(
      validator: validateNotEmpty,
      onSaved: (value) => _labels = value,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Labels',
      ),
    ));

    var selectPictureField = InkWell(
      onTap: () async {
        image = await picker.pickImage(source: ImageSource.gallery);
        if (image == null) return;
        imageNotifier.value = image;
        final bytes = File(image!.path).readAsBytesSync();
        _base64Image = "data:image/png;base64,${base64Encode(bytes)}";
        // log(base64Image); // prints null if string is too large
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding:
            const EdgeInsets.only(left: 100, right: 100, top: 20, bottom: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: const Text("select picture")),
      );

    final pageTitle = Row(
      children: const [
        Icon(
          Icons.art_track_outlined,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(width: 10.0),
        Text(
          'New Art Item',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );

    void createArtItem() {
      final form = formKey.currentState!;

      // don't register if form is not valid
      if (!form.validate()) {
        showSnackBar(context, "Please complete the form properly");
        return;
      }

      form.save();
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: FormAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  pageTitle,
                  const SizedBox(height: 30.0),
                  nameField,
                  const SizedBox(height: 10.0),
                  descriptionField,
                  const SizedBox(height: 10.0),
                  categoryField,
                  const SizedBox(height: 10.0),
                  labelField,
                  const SizedBox(height: 10.0),
                  priceField,
                  const SizedBox(height: 10.0),
                  ValueListenableBuilder<XFile?>(
                    valueListenable: imageNotifier,
                    builder: (context, value, child) {
                      return value != null ? Image.file(File(image!.path)) : const SizedBox();
                    },
                  ),
                  selectPictureField,
                  const SizedBox(height: 10),
                  longButtons("Create", createArtItem),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
