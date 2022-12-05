import 'package:android/network/login/login_input.dart';
import 'package:android/network/register/register_input.dart';
import 'package:android/network/register/register_output.dart';
import 'package:android/providers/register_provider.dart';
import 'package:android/widgets/loading.dart';
import 'package:android/widgets/logo.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../config/app_routes.dart';
import '../models/user_model.dart';
import '../network/login/login_output.dart';
import '../providers/user_provider.dart';
import '../shared_prefs/user_preferences.dart';
import '../util/snack_bar.dart';
import '../util/validators.dart';
import '../widgets/form_app_bar.dart';
import '../widgets/form_widgets.dart';
import 'package:android/providers/login_provider.dart';


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
  final userTypeFormKey = GlobalKey<FormFieldState>();

  String? _username, _email, _password, _userType, _name, _surname;
  int? _age;
  Country? _country;

  @override
  Widget build(BuildContext context) {
    RegisterProvider registerProvider = Provider.of<RegisterProvider>(context);
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    final emailField = inputField(TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      key: emailFormKey,
      onChanged: (_) => emailFormKey.currentState!.validate(),
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: 'Email',
      ),
    ));

    final usernameField = inputField(TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: userNameFormKey,
      onChanged: (_) => userNameFormKey.currentState!.validate(),
      autofocus: false,
      validator: validateUsername,
      onSaved: (value) => _username = value,
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: 'Username',
      ),
    ));

    final passwordField = inputField(TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: passwordFormKey,
      controller: passwordController,
      onChanged: (_) => passwordFormKey.currentState!.validate(),
      autofocus: false,
      obscureText: true,
      validator: validatePassword,
      onSaved: (value) => _password = value,
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: 'Password',
      ),
    ));

    final confirmPassword = inputField(TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: confirmPasswordFormKey,
      onChanged: (_) => confirmPasswordFormKey.currentState!.validate(),
      autofocus: false,
      obscureText: true,
      validator: (value) =>
          (value != passwordController.text) ? "Passwords don't match" : null,
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: 'Confirm Password',
      ),
    ));

    final userTypes = ["Artist", "Regular User"];

    final userTypeField = inputField(DropdownButtonFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: userTypeFormKey,
      validator: validateUserType,
      onSaved: (value) => _userType = value,
      borderRadius: BorderRadius.circular(12),
      decoration: const InputDecoration(border: InputBorder.none),
      hint: const Text("User Type"),
      items: userTypes.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (a) {},
    ));

    void navigateToLoginPage() {
      Navigator.pushNamed(context, login);
    }

    void register() {
      final form = formKey.currentState!;

      // don't register if form is not valid (invalid email etc.)
      if (!form.validate()) {
        showSnackBar(context, "Please complete the form properly");
        return;
      }

      form.save();

      RegisterInput registerInput = RegisterInput(
        userType: _userType!,
        email: _email!,
        username: _username!,
        password: _password!,
      );

      registerProvider
          .register(registerInput)
          .then((RegisterOutput registerOutput) {
        // showSnackBar(context, registerOutput.status);
        if (registerOutput.status == "OK") {
            CurrentUser user = CurrentUser(token: registerOutput.token!, email: registerInput.email);

            // save user in local storage
            saveUser(user);

            // notify other pages about the user via provider
            Provider.of<UserProvider>(context, listen: false).setUser(user);

            // delete every route in navigation stack before navigating to homepage
            Navigator.pushNamed(
              context,
              accountInfoPage,
            );

        } else {
          showSnackBar(context, "Signup Failed!");
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: FormAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Logo(),
                  const SizedBox(height: 30.0),
                  userTypeField,
                  const SizedBox(height: 10.0),
                  emailField,
                  const SizedBox(height: 10.0),
                  usernameField,
                  const SizedBox(height: 10.0),
                  passwordField,
                  const SizedBox(height: 10.0),
                  confirmPassword,
                  const SizedBox(height: 10.0),
                  registerProvider.isLoading
                      ? loading("Registering ... Please wait")
                      : longButtons("Register", register),
                  const SizedBox(height: 10.0),
                  navigateToOtherFormText('Have an account?',
                      'Back to login page.', navigateToLoginPage, Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
