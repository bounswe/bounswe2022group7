import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:android/network/event/post_event_input.dart';
import 'package:android/network/event/post_event_output.dart';
import 'package:android/pages/pages.dart';
import 'package:android/providers/post_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../util/snack_bar.dart';
import '../util/validators.dart';
import '../widgets/form_app_bar.dart';
import '../widgets/form_widgets.dart';
import '../widgets/loading.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    startDateController.text = "";
    endDateController.text = "";
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final endDateFormKey = GlobalKey<FormFieldState>();
  final startDateFormKey = GlobalKey<FormFieldState>();
  final posterFormKey = GlobalKey<FormFieldState>();
  final titleFormKey = GlobalKey<FormFieldState>();
  final eventCategoryFormKey = GlobalKey<FormFieldState>();

  String? _description, _base64Image, _title, _eventCategory;
  double _price = 0;
  List<String>? _labels;
  GeoPoint? _location;

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return;
    setState(() {
      dateRange = newDateRange;
      final start = dateRange.start;
      final end = dateRange.end;
      startDateController.text = "${start.day}/${start.month}/${start.year}";
      endDateController.text = "${end.day}/${end.month}/${end.year}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    final ValueNotifier<XFile?> imageNotifier = ValueNotifier(null);
    XFile? image;

    PostEventProvider postEventProvider =
        Provider.of<PostEventProvider>(context);

    final ValueNotifier<bool> locationSelected = ValueNotifier(false);

    final priceField = inputField(TextFormField(
      onSaved: (value) => _price = double.parse(value!),
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Price',
      ),
    ));

    final labelField = inputField(TextFormField(
      validator: validateNotEmpty,
      onSaved: (value) => _labels!.add(value!),
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Labels',
      ),
    ));

    final endDateField = inputField(TextFormField(
      controller: endDateController, //editing controller of this TextField
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: endDateFormKey,
      validator: validateEventDate,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'End Date',
      ),
      readOnly: true, // when true user cannot edit text
      onTap: pickDateRange,
    ));

    final startDateField = inputField(TextFormField(
      controller: startDateController, //editing controller of this TextField
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: startDateFormKey,
      validator: validateEventDate,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Start Date',
      ),
      readOnly: true, // when true user cannot edit text
      onTap: pickDateRange,
    ));

    final descriptionField = inputField(TextFormField(
      onSaved: (value) => _description = value,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Description',
      ),
    ));

    var selectPosterField = InkWell(
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
          child: const Text("Select Poster")),
    );

    final titleField = inputField(TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: titleFormKey,
      validator: validateEventTitle,
      onSaved: (value) => _title = value,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
      ),
    ));

    final eventCategories = ["Online Gallery", "Physical Exhibition"];

    final eventCategoryField = inputField(DropdownButtonFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: eventCategoryFormKey,
      validator: validateEventCategory,
      onSaved: (value) => _eventCategory = value,
      borderRadius: BorderRadius.circular(12),
      decoration: const InputDecoration(border: InputBorder.none),
      hint: const Text("Event Category"),
      items: eventCategories.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (a) {},
    ));

    final pageTitle = Row(
      children: const [
        Icon(
          Icons.add_location_alt_outlined,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(width: 10.0),
        Text(
          'New Event',
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

    final mapField = InkWell(
      onTap: () async {
        var p = await showSimplePickerLocation(
          context: context,
          isDismissible: true,
          title: "Select Event Location",
          textConfirmPicker: "Select",
          initCurrentUserPosition: true,
          initZoom: 2,
          radius: 8.0,
        );
        _location = p;
        if (p != null) {
          locationSelected.value = true;
        }
      },
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding:
            const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: ValueListenableBuilder<bool>(
          valueListenable: locationSelected,
          builder: (context, value, child) {
            return value
                ? const Text("Update Event Location")
                : const Text("Select Event Location");
          },
        ),
      ),
    );

    void createEvent() {
      final form = formKey.currentState!;

      // don't register if form is not valid (invalid email etc.)
      if (!form.validate()) {
        showSnackBar(context, "Please complete the form properly");
        return;
      }

      form.save();

      PostEventInput postEventInput = PostEventInput(
        category: _eventCategory,
        title: _title!,
        base64poster: _base64Image,
        description: _description!,
        startingDate: dateRange.start,
        endingDate: dateRange.end,
        labels: _labels,
        eventPrice: _price,
      );

      postEventProvider
          .postEvent(postEventInput)
          .then((PostEventOutput postEventOutput) {
        showSnackBar(context, postEventOutput.status);
        if (postEventOutput.status == "OK") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventPage(id: postEventOutput.eventId),
            ),
          );
        }
      });
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
                  eventCategoryField,
                  const SizedBox(height: 10.0),
                  titleField,
                  const SizedBox(height: 10.0),
                  ValueListenableBuilder<XFile?>(
                    valueListenable: imageNotifier,
                    builder: (context, value, child) {
                      return value != null
                          ? Image.file(File(image!.path))
                          : const SizedBox();
                    },
                  ),
                  selectPosterField,
                  const SizedBox(height: 10.0),
                  descriptionField,
                  const SizedBox(height: 10.0),
                  startDateField,
                  const SizedBox(height: 10.0),
                  endDateField,
                  const SizedBox(height: 10.0),
                  labelField,
                  const SizedBox(height: 10.0),
                  priceField,
                  const SizedBox(height: 10.0),
                  mapField,
                  const SizedBox(height: 10.0),
                  postEventProvider.isLoading
                      ? loading("Creating Event... Please Wait")
                      : longButtons("Create", createEvent),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
