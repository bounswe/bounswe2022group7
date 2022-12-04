import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:android/config/app_routes.dart';
import 'package:android/providers/user_provider.dart';
import 'package:android/models/user_model.dart';
import 'package:android/pages/account_info_page.dart';

import 'package:android/network/image/get_image_builder.dart';

import 'package:android/network/settings/get_settings_service.dart';
import 'package:android/network/settings/get_settings_output.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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

  Scaffold erroneousSettingsPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("There was an error loading your settings"),
          ],
        ),
      ),
    );
  }

  Scaffold settingsPage(GetSettingsOutput settings) {
    Widget profilePicture = circleAvatarBuilder(settings.profilePictureId, 10);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, homepage);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Text(settings.username!),
                const SizedBox(width: 10),
                profilePicture,
              ],
            ),
          ),
        ],
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountInfoPage(
                      email: settings.email,
                      username: settings.username,
                      name: settings.name,
                      surname: settings.surname,
                      country: settings.country,
                      dateOfBirth: settings.dateOfBirth,
                      profilePictureId: settings.profilePictureId,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(
                        Icons.person,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Personal Information",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                //Navigator.pushNamed(context, '/privacy');
              },
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(
                        Icons.settings,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Account Management",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                //Navigator.pushNamed(context, '/notifications');
              },
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(
                        Icons.notifications,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Notifications",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                //Navigator.pushNamed(context, '/blocking');
              },
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(
                        Icons.block,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Blocking",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                //Navigator.pushNamed(context, '/copyrightReports');
              },
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(
                        Icons.report,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Copyright Reports",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                //Navigator.pushNamed(context, '/help');
              },
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(
                        Icons.help,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Help",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 15),
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

    currentUser = currentUser!;

    return FutureBuilder(
      future: getSettingsNetwork(currentUser),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Snapshot Error!"),
                ),
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }

            if (snapshot.data != null) {
              GetSettingsOutput responseData = snapshot.data!;
              if (responseData.status != "OK") {
                return erroneousSettingsPage();
              }
              return settingsPage(responseData);
            } else {
              // snapshot.data == null
              return erroneousSettingsPage();
            }
        }
      },
    );
  }
}
