import 'package:android/network/login/login_service.dart';
import 'package:flutter/material.dart';
import '../network/login/login_input.dart';

import '../network/login/login_output.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<LoginOutput> login(LoginInput loginInput) async {
    isLoading = true;
    notifyListeners();
    LoginOutput loginOutput = await loginNetwork(loginInput);
    isLoading = false;
    notifyListeners();
    return loginOutput;
  }
}
