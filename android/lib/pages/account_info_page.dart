import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Info'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Account Info"),
            const SizedBox(height: 10.0),
            Text("Email: ${widget.email}"),
            const SizedBox(height: 10.0),
            Text("Username: ${widget.username}"),
            const SizedBox(height: 10.0),
            Text("Name: ${widget.name}"),
            const SizedBox(height: 10.0),
            Text("Surname: ${widget.surname}"),
            const SizedBox(height: 10.0),
            Text("Country: ${widget.country}"),
            const SizedBox(height: 10.0),
            Text("Date of birth: ${widget.dateOfBirth}"),
            const SizedBox(height: 10.0),
            Text("Profile picture id: ${widget.profilePictureId}"),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
