import 'package:android/models/models.dart';
import 'package:android/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_routes.dart';
import '../providers/user_provider.dart';
import '../widgets/form_app_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
// Controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void logIn() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // TODO these values will come from the backend
    CurrentUser user = CurrentUser(
      username: username,
      token: "test token",
      name: "Tom Bombadil",
      email: "test email",
      imageUrl: "https://avatarfiles.alphacoders.com/935/93509.jpg",
    );

    // save user in local storage
    saveUser(user);

    // notify other pages about the user via provider
    Provider.of<UserProvider>(context, listen: false).setUser(user);

    // delete every route in navigation stack before navigating to homepage
    Navigator.pushNamedAndRemoveUntil(
      context,
      homepage,
      (route) => false,
    );
    return;
  }

  void signUp() {
    Navigator.pushNamed(context, register);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget usernameField = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: _usernameController,
            autofocus: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Username',
            ),
          ),
        ),
      ),
    );

    Widget passwordField = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: _passwordController,
            autofocus: false,
            obscureText: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Password',
            ),
          ),
        ),
      ),
    );

    Widget logInButton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: logIn,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'Log In',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );

    Widget signUpButton = GestureDetector(
      onTap: signUp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Not a User? ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          Text(
            'Sign up now.',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: FormAppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Logo
                const Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.white,
                  size: 150,
                ),
                // App Name
                const Text(
                  'Art Share',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // Input
                const SizedBox(height: 30),
                usernameField,
                const SizedBox(height: 10),
                passwordField,
                // Buttons
                const SizedBox(height: 10),
                logInButton,
                const SizedBox(height: 10),
                signUpButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
