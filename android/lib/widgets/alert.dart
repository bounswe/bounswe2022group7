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

AlertDialog annotationDialog(String body, String username) {
  return AlertDialog(
    title: Text("Annotated by: $username"),
    content: Text(body),
    actions: [
      cancelButton,
    ],
  );
}

AlertDialog makeAnnotationDialog(Function(String, int, int) makeAnnotation, int start, int end) {
  TextEditingController _controller = TextEditingController();
  return alert(
    "Make an annotation",
    TextButton(
      onPressed: () {
        makeAnnotation(_controller.text, start, end);
        navigatorKey.currentState?.pop();
      },
      child: const Text("Submit"),
    ),
    content: TextField(
      controller: _controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Annotation',
      ),
    ),
  );
}
