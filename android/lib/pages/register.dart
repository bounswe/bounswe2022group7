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
  final userTypeFormKey = GlobalKey<FormFieldState>();

  String? _username, _email, _password, _userType, _name, _surname;
  int? _age;
  Country? _country;

  @override
  Widget build(BuildContext context) {
    RegisterProvider registerProvider = Provider.of<RegisterProvider>(context);

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


    final nameField = inputField(TextFormField(
      onSaved: (value) => _name = value,
      autofocus: false,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Name (optional)',
      ),
    ));

    final surnameField = inputField(TextFormField(
      onSaved: (value) => _surname = value,
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
        name: _name,
        surname: _surname,
        age: _age,
        country: _country?.name,
      );

      registerProvider
          .register(registerInput)
          .then((RegisterOutput registerOutput) {
        showSnackBar(context, registerOutput.status);
        if (registerOutput.status == "Signup successful") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            login,
            (route) => false,
          );
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
                  nameField,
                  const SizedBox(height: 10.0),
                  surnameField,
                  const SizedBox(height: 10.0),
                  ageField,
                  const SizedBox(height: 10.0),
                  countryField,
                  const SizedBox(height: 10.0),
                  registerProvider.isLoading
                      ? loading("Registering ... Please wait")
                      : longButtons("Register", register),
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
