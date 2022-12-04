import 'package:flutter/material.dart';

import '../main.dart';
import '../util/annotation.dart';

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

AlertDialog multipleAnnotationDialog(List<Annotation> annotationList, context) {
  return AlertDialog(
    title: const Text("Annotations on this text:"),
    content: SingleChildScrollView(
      child: ListBody(
          children: annotationList
              .map((a) => TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return annotationDialog(
                              a.body,
                              a.author,
                            );
                          });
                    },
                    child: Text("Annotated by: ${a.author}"),
                  ))
              .toList()),
    ),
    actions: [
      cancelButton,
    ],
  );
}

AlertDialog makeAnnotationDialog(
    Function(String, int, int) makeAnnotation, int start, int end) {
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
