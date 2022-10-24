import 'package:android/pages/login.dart';
import 'package:android/pages/profilePage.dart';
import 'package:android/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:android/models/user_model.dart';


import '/config/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User tom = User(
      name: "Tom Bombadil",
      imageUrl: "https://avatarfiles.alphacoders.com/935/93509.jpg",
      email: 'bombadil@anduin.me',
      username: '@tombadil',
    );
    return MaterialApp(
      title: 'ArtShare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
      routes: {
        login: (context) => const Login(),
        register: (context) => const Register(),
        profile: (context) => ProfilePage(current_user: tom,),
      },
    );
  }
}
