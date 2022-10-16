import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../widgets/form_app_bar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                    Navigator.pushNamed(context, login),
                child: const Text("go to login page")),
            const Text("Register page"),
          ],
        ),
      ),
    );
  }
}
