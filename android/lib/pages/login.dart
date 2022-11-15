import 'package:android/models/models.dart';
import 'package:android/network/login/login_input.dart';
import 'package:android/network/login/login_output.dart';
import 'package:android/providers/login_provider.dart';
import 'package:android/shared_prefs/user_preferences.dart';
import 'package:android/widgets/form_widgets.dart';
import 'package:android/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:android/util/validators.dart';
import 'package:android/util/snack_bar.dart';
import 'package:android/widgets/loading.dart';

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

  final formKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormFieldState>();
  final passwordFormKey = GlobalKey<FormFieldState>();

  String? _email, _password;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);


    void logIn() {
      final form = formKey.currentState!;

      if (!form.validate()) {
        showSnackBar(context, "Please complete the form properly");
        return;
      }

      form.save();

      LoginInput loginInput = LoginInput(
        email: _email!,
        password: _password!,
      );

      loginProvider.login(loginInput).then((LoginOutput loginOutput) {
        if (loginOutput.status != "OK") {
          showSnackBar(context, loginOutput.status);
          return;
        }

        CurrentUser user = CurrentUser(token: loginOutput.token!, email: _email!);

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
      });
    }

    void signUp() {
      Navigator.pushNamed(context, register);
    }

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

    final passwordField = inputField(TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: passwordFormKey,
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
                  // Input
                  const SizedBox(height: 30),
                  emailField,
                  const SizedBox(height: 10),
                  passwordField,
                  // Buttons
                  const SizedBox(height: 10),
                  loginProvider.isLoading
                      ? loading("Trying to login ... Please wait")
                      : longButtons("Log In", logIn),
                  const SizedBox(height: 10),
                  navigateToOtherFormText('Not a User?', 'Sign up now.', signUp),
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
