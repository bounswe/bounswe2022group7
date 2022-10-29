import 'package:android/shared_prefs/user_preferences.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  CurrentUser? _user;

  CurrentUser? get user => _user;

  void setUser(CurrentUser user) {
    _user = user;
  }

  void logout() {
    _user = null;
    removeUser();
  }
}
