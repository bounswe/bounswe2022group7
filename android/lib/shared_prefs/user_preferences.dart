import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

void saveUser(CurrentUser user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user", jsonEncode(user.toJson()));
}

Future<CurrentUser?> getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userString = prefs.getString("user");
  if (userString == null) return null;
  Map<String, dynamic> userMap = jsonDecode(userString);
  return CurrentUser.fromJson(userMap);
}

void removeUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("user");
}
