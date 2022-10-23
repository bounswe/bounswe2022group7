import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {int duration = 3}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      // action: SnackBarAction(label: 'Dismiss', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
