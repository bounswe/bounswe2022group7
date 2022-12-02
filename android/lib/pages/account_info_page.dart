import 'package:flutter/material.dart';
import 'package:android/network/image/get_image_builder.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              //Navigator.pushNamed(context, editAccountInfo);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username: ",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
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
                    Text(
                      "${widget.email}",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (widget.profilePictureId != null)
                  imageBuilderWithSize(widget.profilePictureId!, 150, 150)
                else
                  const Icon(Icons.account_circle, size: 150),
              ],
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
                Text(
                  "${widget.name}",
                  style: const TextStyle(
                    fontSize: 16.0,
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
                Text(
                  "${widget.surname}",
                  style: const TextStyle(
                    fontSize: 16.0,
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
                Text(
                  "${widget.country}",
                  style: const TextStyle(
                    fontSize: 16.0,
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
                Text(
                  "${widget.dateOfBirth}",
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}
