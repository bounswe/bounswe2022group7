import 'package:flutter/material.dart';

Widget longButtons(
  String title,
  Function() fun, {
  Color color = Colors.indigo,
  Color textColor = Colors.white,
}) {
  return GestureDetector(
    onTap: fun,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}

Widget inputField(Widget formField) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 5, top: 5),
      child: formField,
    ),
  );
}

Widget navigateToOtherFormText(String whiteText, String linkText,
    Function() linkAction, Color whiteTextColor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "$whiteText ",
        style: TextStyle(
          color: whiteTextColor,
          fontSize: 13,
        ),
      ),
      GestureDetector(
        onTap: linkAction,
        child: Text(
          linkText,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      )
    ],
  );
}
