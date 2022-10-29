import 'package:android/network/register/register_service.dart';
import 'package:flutter/material.dart';
import '../network/register/register_input.dart';

import '../network/register/register_output.dart';

class RegisterProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<RegisterOutput> register(RegisterInput registerInput) async {
    isLoading = true;
    notifyListeners();
    RegisterOutput registerOutput = await registerNetwork(registerInput);
    isLoading = false;
    notifyListeners();
    return registerOutput;
  }
}
