import 'package:android/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../config/app_routes.dart';
import '../util/snack_bar.dart';
import '../util/validators.dart';
import '../widgets/form_app_bar.dart';
import '../widgets/form_widgets.dart';

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

  String? _price, _description, _poster, _title, _eventCategory;

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
    final priceField = inputField(TextFormField(
      onSaved: (value) => _price = value,
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Price',
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

    final posterField = inputField(TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: posterFormKey,
      validator: validateEventPoster,
      onSaved: (value) => _poster = value,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Poster URL',
      ),
    ));

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

    void createEvent() {
      final form = formKey.currentState!;

      // don't register if form is not valid (invalid email etc.)
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
                  eventCategoryField,
                  const SizedBox(height: 10.0),
                  titleField,
                  const SizedBox(height: 10.0),
                  posterField,
                  const SizedBox(height: 10.0),
                  descriptionField,
                  const SizedBox(height: 10.0),
                  startDateField,
                  const SizedBox(height: 10.0),
                  endDateField,
                  const SizedBox(height: 10.0),
                  priceField,
                  const SizedBox(height: 10.0),
                  longButtons("Create", createEvent),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
