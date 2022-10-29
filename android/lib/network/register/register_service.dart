import 'package:android/network/register/register_input.dart';
import 'package:android/network/register/register_output.dart';

RegisterOutput registerNetwork(RegisterInput registerInput) {
  print(registerInput.userType);
  print(registerInput.age);
  return RegisterOutput(status: "OK");
}
