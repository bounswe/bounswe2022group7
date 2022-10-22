import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../widgets/form_app_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: formAppBar(),
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, register),
                child: const Text("go to register page")),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, profile),
                  child: const Text("go to profile page"),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, homepage),
                  child: const Text("home page"),
            ),
            const Text("Login page"),
          ],
        ),
      ),
    );
  }
}
