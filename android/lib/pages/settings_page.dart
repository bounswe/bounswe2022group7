import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:android/config/app_routes.dart';
import 'package:android/providers/user_provider.dart';
import 'package:android/models/user_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Scaffold unauthorizedScreen() {
    return Scaffold(
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
      // please login first:
      return unauthorizedScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Settings for the user:',
            ),
            Text(
              currentUser!.email,
            ),
          ],
        ),
      ),
    );
  }
}
