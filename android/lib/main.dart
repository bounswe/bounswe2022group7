import 'package:android/pages/login.dart';
import 'package:android/pages/register.dart';
import 'package:flutter/material.dart';

import '/config/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArtShare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
      routes: {
        login: (context) => const Login(),
        register: (context) => const Register(),
      },
    );
  }
}
