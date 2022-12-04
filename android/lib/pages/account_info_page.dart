import 'dart:convert';
import 'dart:io';

import 'package:android/models/models.dart';
import 'package:android/network/image/post_image_input.dart';
import 'package:android/network/image/post_image_service.dart';
import 'package:flutter/material.dart';
import 'package:android/network/image/get_image_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../config/app_routes.dart';
import '../network/settings/post_settings_service.dart';
import '../providers/user_provider.dart';
import '../util/snack_bar.dart';
import '../util/validators.dart';
import 'package:country_picker/country_picker.dart';

import '../network/settings/post_settings_input.dart';

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
  final DateTime? dateOfBirth;
  final int? profilePictureId;

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {



  bool editing = false;
  String? _username, _email, _name, _surname, _profilePicture;
  String? _country;
  DateTime? _dateOfBirth;

  Scaffold unauthorizedScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You are not logged in"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, login);
              },
              child: const Text("Log in"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    CurrentUser? currentUser = Provider.of<UserProvider>(context).user;

    if (currentUser == null) {
      return unauthorizedScreen();
    }

    final formKey = GlobalKey<FormState>();

    final ImagePicker picker = ImagePicker();
    final ValueNotifier<XFile?> imageNotifier = ValueNotifier(null);
    XFile? image;

    final ValueNotifier<String?> countryNotifier =
        ValueNotifier(widget.country);

    final ValueNotifier<DateTime?> dateOfBirthNotifier =
        ValueNotifier(widget.dateOfBirth);

    return Scaffold(
      appBar: AppBar(
        leading: editing
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    editing = false;
                    _username = widget.username;
                    _email = widget.email;
                    _name = widget.name;
                    _surname = widget.surname;
                    _country = widget.country;
                    _dateOfBirth = widget.dateOfBirth;
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
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
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                                : const Icon(
                                                    Icons.account_circle,
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
                                              border: Border.all(
                                                  color: Colors.black),
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
                                              _country = country.name;
                                              countryNotifier.value =
                                                  country.name;
                                            }),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              // show country's name with value listener:
                                              child: ValueListenableBuilder(
                                                valueListenable:
                                                    countryNotifier,
                                                builder: (context, value, _) =>
                                                    value != null
                                                        ? Text(
                                                            value,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )
                                                        : const Text(
                                                            "N/A",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                              ),
                                            ),
                                            ValueListenableBuilder(
                                              valueListenable: countryNotifier,
                                              builder: (context, value, _) =>
                                                  value != null
                                                      ? Transform.scale(
                                                          scale: 0.8,
                                                          child: IconButton(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            onPressed: () {
                                                              countryNotifier
                                                                  .value = null;
                                                              _country = null;
                                                            },
                                                            icon: const Icon(Icons
                                                                .highlight_remove_outlined),
                                                            color: Colors
                                                                .grey.shade600,
                                                          ))
                                                      : const SizedBox.shrink(),
                                            ),
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
                                      width: 190,
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                          ).then((value) {
                                            if (value != null) {
                                              _dateOfBirth = value;
                                              dateOfBirthNotifier.value = value;
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ValueListenableBuilder(
                                                valueListenable:
                                                    dateOfBirthNotifier,
                                                builder: (context, value, _) =>
                                                    value != null
                                                        ? Text(
                                                            "${value.day}/${value.month}/${value.year}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                          )
                                                        : const Text(
                                                            "N/A",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                              ),
                                            ),
                                            ValueListenableBuilder(
                                              valueListenable:
                                                  dateOfBirthNotifier,
                                              builder: (context, value, _) =>
                                                  value != null
                                                      ? Transform.scale(
                                                          scale: 0.8,
                                                          child: IconButton(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            onPressed: () {
                                                              dateOfBirthNotifier
                                                                  .value = null;
                                                              _dateOfBirth =
                                                                  null;
                                                            },
                                                            icon: const Icon(Icons
                                                                .highlight_remove_outlined),
                                                            color: Colors
                                                                .grey.shade600,
                                                          ))
                                                      : const SizedBox.shrink(),
                                            ),
                                            const Icon(Icons.edit_calendar),
                                          ],
                                        ),
                                      ),
                                    )
                                  : widget.dateOfBirth != null
                                      ? Text(
                                "${widget.dateOfBirth!.day}/${widget.dateOfBirth!.month}/${widget.dateOfBirth!.year}",
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
                            onPressed: () async {
                              final form = formKey.currentState!;

                              // don't register if form is not valid
                              if (!form.validate()) {
                                showSnackBar(context,
                                    "Please complete the form properly");
                                return;
                              }
                              form.save();

                              List<dynamic> data = [
                                null,
                                null,
                                null,
                                null,
                                null,
                                null,
                                null
                              ];

                              if (_username != null &&
                                  _username != widget.username) {
                                data[0] = (_username!.trim());
                              }
                              if (_email != null && _email != widget.email) {
                                data[1] = (_email!.trim());
                              }
                              if (_name != null && _name != widget.name) {
                                data[2] = (_name!.trim());
                              }
                              if (_surname != null &&
                                  _surname != widget.surname) {
                                data[3] = (_surname!.trim());
                              }
                              if (_country != null &&
                                  _country != widget.country) {
                                data[4] = (_country!);
                              }
                              if (_dateOfBirth != null) {
                                if (widget.dateOfBirth == null) {
                                  data[5] = (_dateOfBirth);
                                } else if (_dateOfBirth!.day !=
                                        widget.dateOfBirth!.day ||
                                    _dateOfBirth!.month !=
                                        widget.dateOfBirth!.month ||
                                    _dateOfBirth!.year !=
                                        widget.dateOfBirth!.year) {
                                  data[5] = (_dateOfBirth);
                                }
                              }
                              if (_profilePicture != null) {
                                final response = await postImageNetwork(
                                    PostImageInput(
                                        base64string: _profilePicture!));
                                if (response.status == "OK") {
                                  data[6] = response.id;
                                }
                              }

                              PostSettingsInput requestInput = PostSettingsInput(
                                username: data[0],
                                email: data[1],
                                name: data[2],
                                surname: data[3],
                                country: data[4],
                                dateOfBirth: data[5],
                                profilePictureId: data[6],
                              );

                              final response = await postSettingsNetwork(currentUser!, requestInput);

                              if (response.status == "OK") {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => AccountInfoPage(
                                      username: response.username ?? widget.username,
                                      email: response.email ?? widget.email,
                                      name: response.name ?? widget.name,
                                      surname: response.surname ?? widget.surname,
                                      country: response.country ?? widget.country,
                                      dateOfBirth: response.dateOfBirth ?? widget.dateOfBirth,
                                      profilePictureId: response.profilePictureId ?? widget.profilePictureId,
                                    ),
                                  ),
                                );
                              } else {
                                showSnackBar(context, response.status);
                              }
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
            ],
          ),
        ),
      ),
    );
  }
}
