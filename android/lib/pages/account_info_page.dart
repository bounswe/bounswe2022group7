import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:android/network/image/get_image_builder.dart';
import 'package:image_picker/image_picker.dart';

import '../util/snack_bar.dart';
import '../util/validators.dart';
import 'package:country_picker/country_picker.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage(
      {Key? key,
      this.email,
      this.username,
      this.name,
      this.surname,
      this.country,
      this.dateOfBirth,
      this.profilePictureId})
      : super(key: key);

  final String? email;
  final String? username;
  final String? name;
  final String? surname;
  final String? country;
  final String? dateOfBirth;
  final int? profilePictureId;

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  bool editing = false;
  String? _username, _email, _name, _surname, _profilePicture;
  Country? _country;
  DateTime? _dateOfBirth;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final ImagePicker picker = ImagePicker();
    final ValueNotifier<XFile?> imageNotifier = ValueNotifier(null);
    XFile? image;

    return Scaffold(
      appBar: AppBar(
        leading: editing
          ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  editing = false;
                });
              },
            )
          : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: editing
            ? const Text('Edit Account Info')
            : const Text('Account Info'),
        actions: [
          editing
              ? Container()
              : IconButton(
                  onPressed: () {
                    setState(() {
                      editing = true;
                    });
                  },
                  icon: const Icon(Icons.edit),
                )
        ],
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[100]!),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Username: ",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              editing
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 25,
                                      width: 180,
                                      child: TextFormField(
                                        autofocus: false,
                                        validator: validateUsername,
                                        onSaved: (value) => _username = value,
                                        initialValue: widget.username,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              bottom: 11,
                                              top: 11,
                                              right: 10),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "${widget.username}",
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                              const SizedBox(height: 15),
                              const Text(
                                "Email Address: ",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              editing
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 25,
                                      width: 180,
                                      child: TextFormField(
                                        autofocus: false,
                                        validator: validateEmail,
                                        onSaved: (value) => _email = value,
                                        initialValue: widget.email,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              bottom: 11,
                                              top: 11,
                                              right: 10),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "${widget.email}",
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                            ],
                          ),
                          const Spacer(),
                          editing
                              ? Column(
                                  children: [
                                    ValueListenableBuilder<XFile?>(
                                      valueListenable: imageNotifier,
                                      builder: (context, value, child) {
                                        return value != null
                                            ? Image.file(
                                                File(image!.path),
                                                fit: BoxFit.fitWidth,
                                                width: 100,
                                                height: 100,
                                              )
                                            : widget.profilePictureId != null
                                                ? imageBuilderWithSize(
                                                    widget.profilePictureId!,
                                                    100,
                                                    100)
                                                : const Icon(Icons.account_circle,
                                                    size: 100);
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    InkWell(
                                      onTap: () async {
                                        image = await picker.pickImage(
                                            source: ImageSource.gallery);
                                        if (image == null) return;
                                        imageNotifier.value = image;
                                        final bytes =
                                            File(image!.path).readAsBytesSync();
                                        _profilePicture =
                                            "data:image/png;base64,${base64Encode(bytes)}";
                                      },
                                      child: Container(
                                          width: 100,
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: Colors.black),
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5))),
                                          child: const Text(
                                              "Upload profile picture",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12))),
                                    ),
                                  ],
                                )
                              : widget.profilePictureId != null
                                  ? imageBuilderWithSize(
                                      widget.profilePictureId!, 100, 100)
                                  : const Icon(Icons.account_circle, size: 100),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[700]!),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          const Center(
                            child: Text("Personal Information",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const SizedBox(height: 30.0),
                          Row(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              editing
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 25,
                                      width: 180,
                                      child: TextFormField(
                                        autofocus: false,
                                        onSaved: (value) => _name = value,
                                        initialValue: widget.name ?? "",
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              bottom: 11,
                                              top: 11,
                                              right: 10),
                                        ),
                                      ),
                                    )
                                  : widget.name != null
                                      ? Text(
                                          "${widget.name}",
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        )
                                      : const Text(
                                          "N/A",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            children: [
                              const Text(
                                "Surname: ",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              editing
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 25,
                                      width: 180,
                                      child: TextFormField(
                                        autofocus: false,
                                        onSaved: (value) => _surname = value,
                                        initialValue: widget.surname ?? "",
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              bottom: 11,
                                              top: 11,
                                              right: 10),
                                        ),
                                      ),
                                    )
                                  : widget.surname != null
                                      ? Text(
                                          "${widget.surname}",
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        )
                                      : const Text(
                                          "N/A",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            children: [
                              const Text(
                                "Country: ",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              editing // use country picker to select country
                                  // with dropdown
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 25,
                                      width: 180,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: GestureDetector(
                                        onTap: () => showCountryPicker(
                                            context: context,
                                            onSelect: (Country country) {
                                              setState(() {
                                                _country = country;
                                              });
                                            }),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _country == null
                                                    ? 'N/A'
                                                    : _country!.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: _country == null
                                                      ? Colors.grey.shade600
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            _country != null
                                                ? Transform.scale(
                                                    scale: 0.8,
                                                    child: IconButton(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      onPressed: () {
                                                        setState(() {
                                                          _country = null;
                                                        });
                                                      },
                                                      icon: const Icon(Icons
                                                          .highlight_remove_outlined),
                                                      color: Colors.grey.shade600,
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                            const Icon(Icons.arrow_drop_down),
                                          ],
                                        ),
                                      ),
                                    )
                                  : widget.country != null
                                      ? Text(
                                          "${widget.country}",
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        )
                                      : const Text(
                                          "N/A",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            children: [
                              const Text(
                                "Date of Birth: ",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              editing
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 25,
                                      width: 180,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                          ).then((value) {
                                            setState(() {
                                              _dateOfBirth = value;
                                            });
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _dateOfBirth == null
                                                    ? 'N/A'
                                                    : "${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: _dateOfBirth == null
                                                      ? Colors.grey.shade600
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                            _dateOfBirth != null
                                                ? Transform.scale(
                                                    scale: 0.8,
                                                    child: IconButton(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      onPressed: () {
                                                        setState(() {
                                                          _dateOfBirth = null;
                                                        });
                                                      },
                                                      icon: const Icon(Icons
                                                          .highlight_remove_outlined),
                                                      color: Colors.grey.shade600,
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                            const Icon(Icons.calendar_month),
                                            const Icon(Icons.arrow_drop_down),
                                          ],
                                        ),
                                      ),
                                    )
                                  : widget.dateOfBirth != null
                                      ? Text(
                                          "${widget.dateOfBirth}",
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        )
                                      : const Text(
                                          "N/A",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (!editing &&
                        (widget.name == null ||
                            widget.surname == null ||
                            widget.country == null ||
                            widget.dateOfBirth == null))
                      Column(
                        children: [
                          const SizedBox(height: 30.0),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text(
                              "Please complete your personal information to get the best experience!",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 30.0),
                    editing
                        ? ElevatedButton(
                            onPressed: () {
                              final form = formKey.currentState!;

                              // don't register if form is not valid
                              if (!form.validate()) {
                                showSnackBar(context, "Please complete the form properly");
                                return;
                              }
                              form.save();

                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              "Save Changes",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              setState(() {
                                editing = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              "Edit Account Info",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          )
                  ],
                ),
              ),
              const SizedBox(height: 400.0), // so that the page is scrollable
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
