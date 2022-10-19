import 'package:flutter/material.dart';

AppBar formAppBar({bool backButtonVisible = false}) {
  return AppBar(
    automaticallyImplyLeading: backButtonVisible,
    title: const Text("ArtShare"),
    elevation: 0.1,
  );
}
