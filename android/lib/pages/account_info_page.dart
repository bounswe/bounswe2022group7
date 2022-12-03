import 'package:flutter/material.dart';
import 'package:android/network/image/get_image_builder.dart';

import '../util/validators.dart';
import 'package:country_picker/country_picker.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage(
      {Key? key,
      this.editing = false,
      this.email,
      this.username,
      this.name,
      this.surname,
      this.country,
      this.dateOfBirth,
      this.profilePictureId})
      : super(key: key);

  final bool editing;
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
  String? _username, _email, _name, _surname;
  Country? _country;
  DateTime? _dateOfBirth;

  @override
  Widget build(BuildContext context) {

    final userNameFormKey = GlobalKey<FormState>();
    final emailFormKey = GlobalKey<FormState>();
    final nameFormKey = GlobalKey<FormState>();
    final surnameFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: widget.editing
            ? const Text('Edit Account Info')
            : const Text('Account Info'),
        actions: [
          widget.editing
              ? Container()
              : IconButton(
                  onPressed: () {
                    redirectToEdit(context);
                  },
                  icon: const Icon(Icons.edit),
                )
        ],
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
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
                      widget.editing
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 25,
                              width: 180,
                              child: TextFormField(
                                key: userNameFormKey,
                                onChanged: (_) =>
                                    userNameFormKey.currentState!.validate(),
                                autofocus: false,
                                validator: validateUsername,
                                onSaved: (value) => _username = value,
                                initialValue: widget.username,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 11, top: 11, right: 10),
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
                      widget.editing
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 25,
                              width: 180,
                              child: TextFormField(
                                key: emailFormKey,
                                onChanged: (_) =>
                                    emailFormKey.currentState!.validate(),
                                autofocus: false,
                                validator: validateEmail,
                                onSaved: (value) => _email = value,
                                initialValue: widget.email,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 11, top: 11, right: 10),
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
                  if (widget.profilePictureId != null)
                    imageBuilderWithSize(widget.profilePictureId!, 100, 100)
                  else
                    const Icon(Icons.account_circle, size: 150),
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
                      widget.editing
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 25,
                              width: 180,
                              child: TextFormField(
                                key: nameFormKey,
                                autofocus: false,
                                onSaved: (value) => _name = value,
                                initialValue: widget.name ?? "",
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 11, top: 11, right: 10),
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
                      widget.editing
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 25,
                              width: 180,
                              child: TextFormField(
                                key: surnameFormKey,
                                autofocus: false,
                                onSaved: (value) => _surname = value,
                                initialValue: widget.surname ?? "",
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 10, bottom: 11, top: 11, right: 10),
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
                      widget.editing // use country picker to select country
                          // with dropdown
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 25,
                              width: 180,
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
                                            ? '  N/A'
                                            : _country!.name,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: widget.country == null
                                              ? Colors.grey.shade600
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _country != null,
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _country = null;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.highlight_remove_outlined),
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
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
                      widget.editing
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 25,
                              width: 180,
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
                                            ? '  N/A'
                                            : "${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: widget.dateOfBirth == null
                                              ? Colors.grey.shade600
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _dateOfBirth != null,
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      maintainState: true,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _dateOfBirth = null;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.highlight_remove_outlined),
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
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
            if (!widget.editing &&
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
            ElevatedButton(
              onPressed: () {
                redirectToEdit(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: widget.editing
                  ? const Text(
                      "Save Changes",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    )
                  : const Text(
                      "Edit Account Info",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void redirectToEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountInfoPage(
          editing: true,
          email: widget.email,
          username: widget.username,
          name: widget.name,
          surname: widget.surname,
          country: widget.country,
          dateOfBirth: widget.dateOfBirth,
          profilePictureId: widget.profilePictureId,
        ),
      ),
    );
  }
}
