import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../util/snack_bar.dart';
import '../util/validators.dart';
import '../widgets/form_app_bar.dart';
import '../widgets/form_widgets.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormFieldState>();
  final userNameFormKey = GlobalKey<FormFieldState>();
  final passwordFormKey = GlobalKey<FormFieldState>();
  final confirmPasswordFormKey = GlobalKey<FormFieldState>();

  String? _username, _email, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      key: emailFormKey,
      onChanged: (_) => emailFormKey.currentState!.validate(),
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Enter email address", Icons.email),
    );

    final usernameField = TextFormField(
      key: userNameFormKey,
      onChanged: (_) => userNameFormKey.currentState!.validate(),
      autofocus: false,
      validator: validateUsername,
      onSaved: (value) => _username = value,
      decoration:
          buildInputDecoration("Enter username", Icons.supervised_user_circle),
    );

    final passwordField = TextFormField(
      key: passwordFormKey,
      controller: passwordController,
      onChanged: (_) => passwordFormKey.currentState!.validate(),
      autofocus: false,
      obscureText: true,
      validator: validatePassword,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Enter password", Icons.lock),
    );

    final confirmPassword = TextFormField(
      key: confirmPasswordFormKey,
      onChanged: (_) => confirmPasswordFormKey.currentState!.validate(),
      autofocus: false,
      obscureText: true,
      validator: (value) =>
          (value != passwordController.text) ? "Passwords don't match" : null,
      onSaved: (value) => _confirmPassword = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    void register() {
      final form = formKey.currentState!;

      // don't register if form is not valid (invalid email etc.)
      if (!form.validate()) {
        showSnackBar(context, "Please complete the form properly");
        return;
      }

      form.save();

      // delete every route in navigation stack before navigating to homepage
      Navigator.pushNamedAndRemoveUntil(
        context,
        homepage,
        (route) => false,
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: FormAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15.0),
                  const Text("Email"),
                  const SizedBox(height: 5.0),
                  emailField,
                  const SizedBox(height: 15.0),
                  const Text("Username"),
                  const SizedBox(height: 5.0),
                  usernameField,
                  const SizedBox(height: 15.0),
                  const Text("Password"),
                  const SizedBox(height: 10.0),
                  passwordField,
                  const SizedBox(height: 15.0),
                  const Text("Confirm Password"),
                  const SizedBox(height: 10.0),
                  confirmPassword,
                  const SizedBox(height: 20.0),
                  longButtons("Register", register),
                  const SizedBox(height: 30.0),
                  longButtons(
                    "Login if you have an account",
                    () => Navigator.pushNamed(context, login),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
