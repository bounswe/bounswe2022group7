import 'package:flutter/material.dart';

import '../main.dart';

Widget cancelButton = TextButton(
  child: const Text("Cancel"),
  onPressed: () {
    navigatorKey.currentState?.pop();
  },
);

AlertDialog alert(String title, TextButton continueButton, {content: Widget}) {
  return AlertDialog(
    title: Text(title),
    content: content,
    actions: [
      cancelButton,
      continueButton,
    ],
  );
}

AlertDialog logoutDialog(Function() logout) {
  return alert(
    "Attention!",
    TextButton(
      onPressed: logout,
      child: const Text("Log out"),
    ),
    content: const Text("Are you sure you want to log out?"),
  );
}
