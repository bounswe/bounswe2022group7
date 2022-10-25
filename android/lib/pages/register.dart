import 'package:android/widgets/logo.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../config/app_routes.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../shared_prefs/user_preferences.dart';
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

  Country? _country;

  @override
  Widget build(BuildContext context) {
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
      onSaved: (value) => _confirmPassword = value,
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: 'Confirm Password',
      ),
    ));

    final nameField = inputField(TextFormField(
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Name (optional)',
      ),
    ));

    final surnameField = inputField(TextFormField(
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Surname (optional)',
      ),
    ));

    final ageField = inputField(TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      inputFormatters: [LengthLimitingTextInputFormatter(2)],
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Age (optional)',
      ),
    ));

    final countryField = inputField(GestureDetector(
      onTap: () => showCountryPicker(
          context: context,
          onSelect: (Country country) {
            setState(() {
              _country = country;
            });
          }),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _country == null ? 'Country (optional)' : _country!.name,
              style: TextStyle(
                fontSize: 15,
                color: _country == null ? Colors.grey.shade600 : Colors.black,
              ),
            ),
          ),
          Visibility(
            visible: _country != null,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _country = null;
                });
              },
              icon: const Icon(Icons.highlight_remove_outlined),
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
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

      // TODO these values will come from the backend
      CurrentUser user = CurrentUser(
        username: _username!,
        token: "test token",
        name: "Tom Bombadil",
        email: _email!,
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
                  emailField,
                  const SizedBox(height: 10.0),
                  usernameField,
                  const SizedBox(height: 10.0),
                  passwordField,
                  const SizedBox(height: 10.0),
                  confirmPassword,
                  const SizedBox(height: 10.0),
                  nameField,
                  const SizedBox(height: 10.0),
                  surnameField,
                  const SizedBox(height: 10.0),
                  ageField,
                  const SizedBox(height: 10.0),
                  countryField,
                  const SizedBox(height: 10.0),
                  longButtons("Register", register),
                  const SizedBox(height: 10.0),
                  navigateToOtherFormText('Have an account?',
                      'Back to login page.', navigateToLoginPage),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
