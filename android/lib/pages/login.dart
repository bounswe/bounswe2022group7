import 'package:android/models/models.dart';
import 'package:android/shared_prefs/user_preferences.dart';
import 'package:android/widgets/form_widgets.dart';
import 'package:android/widgets/logo.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void logIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // TODO these values will come from the backend
    CurrentUser user = CurrentUser(
      userType: "Regular User",
      username: "temp username",
      token: "test token",
      name: "Tom Bombadil",
      email: email,
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget emailField = inputField(TextFormField(
      controller: _emailController,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Email',
      ),
    ));

    Widget passwordField = inputField(TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Password',
      ),
    ));

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: FormAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const Logo(),
                // Input
                const SizedBox(height: 30),
                emailField,
                const SizedBox(height: 10),
                passwordField,
                // Buttons
                const SizedBox(height: 10),
                longButtons("Log In", logIn),
                const SizedBox(height: 10),
                navigateToOtherFormText('Not a User?', 'Sign up now.', signUp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
